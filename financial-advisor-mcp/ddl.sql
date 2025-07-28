-- Financial Advisory Platform Database Schema

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE branches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  branch_code VARCHAR(10) UNIQUE NOT NULL,
  branch_name VARCHAR(100) NOT NULL,
  address_line1 VARCHAR(255) NOT NULL,
  address_line2 VARCHAR(255),
  city VARCHAR(100) NOT NULL,
  state VARCHAR(2) NOT NULL,
  zip_code VARCHAR(10) NOT NULL,
  phone VARCHAR(20),
  fax VARCHAR(20),
  region VARCHAR(20) NOT NULL CHECK (region IN ('northeast', 'southeast', 'midwest', 'west', 'central')),
  manager_id UUID,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE financial_advisors (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  employee_id VARCHAR(20) UNIQUE NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(20),
  license_number VARCHAR(50) UNIQUE NOT NULL,
  specialization VARCHAR(100),
  branch_id UUID NOT NULL REFERENCES branches(id),
  manager_id UUID,
  hire_date DATE NOT NULL,
  termination_date DATE,
  commission_rate DECIMAL(5,4) CHECK (commission_rate >= 0 AND commission_rate <= 1),
  status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended', 'terminated')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  customer_number VARCHAR(20) UNIQUE NOT NULL,
  ssn TEXT,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(20),
  date_of_birth DATE NOT NULL,
  address_line1 VARCHAR(255) NOT NULL,
  address_line2 VARCHAR(255),
  city VARCHAR(100) NOT NULL,
  state VARCHAR(2) NOT NULL,
  zip_code VARCHAR(10) NOT NULL,
  risk_tolerance VARCHAR(20) NOT NULL DEFAULT 'moderate' CHECK (risk_tolerance IN ('conservative', 'moderate', 'aggressive')),
  kyc_status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (kyc_status IN ('pending', 'approved', 'rejected', 'expired')),
  kyc_completed_date DATE,
  onboarding_date DATE NOT NULL DEFAULT CURRENT_DATE,
  financial_advisor_id UUID REFERENCES financial_advisors(id),
  branch_id UUID NOT NULL REFERENCES branches(id),
  status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended', 'terminated')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT chk_age CHECK (date_of_birth <= CURRENT_DATE - INTERVAL '18 years')
);

CREATE TABLE accounts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_number VARCHAR(20) UNIQUE NOT NULL,
  customer_id UUID NOT NULL REFERENCES customers(id),
  account_type VARCHAR(20) NOT NULL CHECK (account_type IN ('checking', 'savings', 'investment', 'ira', '401k', 'money_market')),
  balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  available_balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  interest_rate DECIMAL(6,4) DEFAULT 0.0000,
  date_opened DATE NOT NULL DEFAULT CURRENT_DATE,
  date_closed DATE,
  minimum_balance DECIMAL(15,2) DEFAULT 0.00,
  monthly_fee DECIMAL(8,2) DEFAULT 0.00,
  status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended', 'closed')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT chk_balance_non_negative CHECK (balance >= 0 OR account_type = 'checking'),
  CONSTRAINT chk_available_balance CHECK (available_balance <= balance),
  CONSTRAINT chk_interest_rate CHECK (interest_rate >= 0 AND interest_rate <= 1)
);

CREATE TABLE transactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL REFERENCES accounts(id),
  transaction_type VARCHAR(20) NOT NULL CHECK (transaction_type IN ('deposit', 'withdrawal', 'transfer', 'fee', 'interest', 'dividend')),
  amount DECIMAL(15,2) NOT NULL,
  transaction_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  description TEXT,
  reference_number VARCHAR(50),
  counterparty_account_id UUID REFERENCES accounts(id),
  initiated_by_user_id UUID,
  authorized_by_user_id UUID,
  status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed', 'reversed')),
  balance_after DECIMAL(15,2) NOT NULL,
  fees DECIMAL(8,2) DEFAULT 0.00,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT chk_amount_not_zero CHECK (amount != 0),
  CONSTRAINT chk_transfer_has_counterparty CHECK (
      (transaction_type = 'transfer' AND counterparty_account_id IS NOT NULL) OR
      (transaction_type != 'transfer')
  )
);

CREATE TABLE investment_portfolios (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  customer_id UUID NOT NULL REFERENCES customers(id),
  financial_advisor_id UUID NOT NULL REFERENCES financial_advisors(id),
  portfolio_name VARCHAR(100) NOT NULL,
  investment_strategy TEXT,
  total_value DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  cash_balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  created_date DATE NOT NULL DEFAULT CURRENT_DATE,
  last_rebalance_date DATE,
  target_risk_score INTEGER CHECK (target_risk_score BETWEEN 1 AND 10),
  current_risk_score INTEGER CHECK (current_risk_score BETWEEN 1 AND 10),
  benchmark_index VARCHAR(50),
  performance_ytd DECIMAL(8,4),
  status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'suspended', 'closed')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT chk_cash_balance_positive CHECK (cash_balance >= 0),
  CONSTRAINT chk_total_value_positive CHECK (total_value >= 0)
);

CREATE TABLE audit_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL,
  user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('customer', 'advisor', 'admin', 'system', 'compliance')),
  user_role VARCHAR(50) NOT NULL,
  action_type VARCHAR(20) NOT NULL CHECK (action_type IN ('view', 'create', 'update', 'delete', 'login', 'logout', 'transfer', 'approve')),
  table_name VARCHAR(50),
  record_id UUID,
  timestamp TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ip_address VARCHAR(45),
  user_agent TEXT,
  session_id UUID,
  old_values JSONB,
  new_values JSONB,
  compliance_flag BOOLEAN DEFAULT FALSE,
  severity_level INTEGER DEFAULT 1 CHECK (severity_level BETWEEN 1 AND 5),
  description TEXT
);

CREATE TABLE compliance_reports (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  report_number VARCHAR(20) UNIQUE NOT NULL,
  report_type VARCHAR(30) NOT NULL CHECK (report_type IN ('suspicious_activity', 'large_transaction', 'kyc_review', 'aml_check')),
  customer_id UUID REFERENCES customers(id),
  account_id UUID REFERENCES accounts(id),
  transaction_id UUID REFERENCES transactions(id),
  generated_by_user_id UUID NOT NULL,
  generated_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  report_data JSONB NOT NULL,
  summary TEXT,
  status VARCHAR(20) NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'submitted', 'under_review', 'approved', 'closed')),
  priority_level INTEGER DEFAULT 2 CHECK (priority_level BETWEEN 1 AND 5),
  reviewer_id UUID,
  review_date TIMESTAMP WITH TIME ZONE,
  review_notes TEXT,
  regulatory_filing_required BOOLEAN DEFAULT FALSE,
  filing_deadline DATE,
  resolution_notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_customers_advisor ON customers(financial_advisor_id);
CREATE INDEX idx_customers_branch ON customers(branch_id);
CREATE INDEX idx_customers_status ON customers(status);
CREATE INDEX idx_customers_email ON customers(email);

CREATE INDEX idx_accounts_customer ON accounts(customer_id);
CREATE INDEX idx_accounts_type ON accounts(account_type);
CREATE INDEX idx_accounts_status ON accounts(status);

CREATE INDEX idx_transactions_account ON transactions(account_id);
CREATE INDEX idx_transactions_counterparty ON transactions(counterparty_account_id);
CREATE INDEX idx_transactions_date ON transactions(transaction_date);
CREATE INDEX idx_transactions_type ON transactions(transaction_type);
CREATE INDEX idx_transactions_status ON transactions(status);
CREATE INDEX idx_transactions_initiated_by ON transactions(initiated_by_user_id);

CREATE INDEX idx_portfolios_customer ON investment_portfolios(customer_id);
CREATE INDEX idx_portfolios_advisor ON investment_portfolios(financial_advisor_id);

CREATE INDEX idx_advisors_branch ON financial_advisors(branch_id);
CREATE INDEX idx_advisors_manager ON financial_advisors(manager_id);
CREATE INDEX idx_advisors_status ON financial_advisors(status);

CREATE INDEX idx_audit_user ON audit_logs(user_id);
CREATE INDEX idx_audit_timestamp ON audit_logs(timestamp);
CREATE INDEX idx_audit_table_record ON audit_logs(table_name, record_id);
CREATE INDEX idx_audit_action ON audit_logs(action_type);
CREATE INDEX idx_audit_compliance ON audit_logs(compliance_flag);

CREATE INDEX idx_compliance_customer ON compliance_reports(customer_id);
CREATE INDEX idx_compliance_account ON compliance_reports(account_id);
CREATE INDEX idx_compliance_transaction ON compliance_reports(transaction_id);
CREATE INDEX idx_compliance_generated_by ON compliance_reports(generated_by_user_id);
CREATE INDEX idx_compliance_status ON compliance_reports(status);
CREATE INDEX idx_compliance_type ON compliance_reports(report_type);

-- Create trigger function for updating timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for automatic timestamp updates
CREATE TRIGGER update_branches_updated_at BEFORE UPDATE ON branches
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_financial_advisors_updated_at BEFORE UPDATE ON financial_advisors
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_customers_updated_at BEFORE UPDATE ON customers
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_accounts_updated_at BEFORE UPDATE ON accounts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_transactions_updated_at BEFORE UPDATE ON transactions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_investment_portfolios_updated_at BEFORE UPDATE ON investment_portfolios
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_compliance_reports_updated_at BEFORE UPDATE ON compliance_reports
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Summary tables for common access patterns with primary keys
CREATE TABLE customer_account_summary AS
SELECT 
  c.id as customer_id,
  c.customer_number,
  c.first_name,
  c.last_name,
  c.financial_advisor_id,
  c.branch_id,
  COUNT(a.id) as total_accounts,
  COALESCE(SUM(a.balance), 0) as total_balance,
  COUNT(ip.id) as total_portfolios,
  COALESCE(SUM(ip.total_value), 0) as total_portfolio_value,
  CURRENT_TIMESTAMP as last_updated
FROM customers c
LEFT JOIN accounts a ON c.id = a.customer_id AND a.status = 'active'
LEFT JOIN investment_portfolios ip ON c.id = ip.customer_id AND ip.status = 'active'
WHERE c.status = 'active'
GROUP BY c.id, c.customer_number, c.first_name, c.last_name, c.financial_advisor_id, c.branch_id;

ALTER TABLE customer_account_summary ADD PRIMARY KEY (customer_id);

ALTER TABLE customer_account_summary ADD CONSTRAINT fk_customer_summary_customer 
   FOREIGN KEY (customer_id) REFERENCES customers(id);

ALTER TABLE customer_account_summary ADD CONSTRAINT fk_customer_summary_advisor 
   FOREIGN KEY (financial_advisor_id) REFERENCES financial_advisors(id);

ALTER TABLE customer_account_summary ADD CONSTRAINT fk_customer_summary_branch 
   FOREIGN KEY (branch_id) REFERENCES branches(id);

-- Table for advisor performance with financial_advisor_id as primary key
CREATE TABLE advisor_performance AS
SELECT 
  fa.id as financial_advisor_id,
  fa.employee_id,
  fa.first_name,
  fa.last_name,
  fa.branch_id,
  COUNT(DISTINCT c.id) as total_customers,
  COUNT(DISTINCT a.id) as total_accounts,
  COALESCE(SUM(a.balance), 0) as total_assets_under_management,
  COUNT(DISTINCT ip.id) as total_portfolios,
  COALESCE(SUM(ip.total_value), 0) as total_investment_assets,
  CURRENT_TIMESTAMP as last_updated
FROM financial_advisors fa
LEFT JOIN customers c ON fa.id = c.financial_advisor_id AND c.status = 'active'
LEFT JOIN accounts a ON c.id = a.customer_id AND a.status = 'active'
LEFT JOIN investment_portfolios ip ON c.id = ip.financial_advisor_id AND ip.status = 'active'
WHERE fa.status = 'active'
GROUP BY fa.id, fa.employee_id, fa.first_name, fa.last_name, fa.branch_id;

ALTER TABLE advisor_performance ADD PRIMARY KEY (financial_advisor_id);

ALTER TABLE advisor_performance ADD CONSTRAINT fk_advisor_performance_advisor 
   FOREIGN KEY (financial_advisor_id) REFERENCES financial_advisors(id);

ALTER TABLE advisor_performance ADD CONSTRAINT fk_advisor_performance_branch 
   FOREIGN KEY (branch_id) REFERENCES branches(id);

-- Indexes on summary tables for better query performance
CREATE INDEX idx_customer_summary_advisor ON customer_account_summary(financial_advisor_id);
CREATE INDEX idx_customer_summary_branch ON customer_account_summary(branch_id);
CREATE INDEX idx_advisor_performance_branch ON advisor_performance(branch_id);

-- Comments for documentation
COMMENT ON TABLE customers IS 'Customer master data with KYC and risk profile information';
COMMENT ON TABLE financial_advisors IS 'Financial advisor employee information and assignments';
COMMENT ON TABLE accounts IS 'Customer bank accounts including checking, savings, and investment accounts';
COMMENT ON TABLE transactions IS 'All financial transactions across all account types';
COMMENT ON TABLE investment_portfolios IS 'Customer investment portfolios managed by advisors';
COMMENT ON TABLE audit_logs IS 'Comprehensive audit trail for all system activities';
COMMENT ON TABLE compliance_reports IS 'Regulatory compliance reports and suspicious activity monitoring';
COMMENT ON TABLE branches IS 'Bank branch locations and management structure';
COMMENT ON TABLE advisor_performance IS 'Summary table for advisor performance metrics with FK for access control';
COMMENT ON TABLE customer_account_summary IS 'Summary table for customer account data with FK for access control';

COMMENT ON COLUMN customers.ssn IS 'Social Security Number for compliance';
COMMENT ON COLUMN transactions.initiated_by_user_id IS 'User ID who initiated the transaction (customer or advisor)';
COMMENT ON COLUMN transactions.authorized_by_user_id IS 'User ID who authorized the transaction for compliance';
COMMENT ON COLUMN audit_logs.compliance_flag IS 'Flag indicating if this action requires compliance review';
COMMENT ON COLUMN compliance_reports.report_data IS 'JSON data containing specific report details and findings';