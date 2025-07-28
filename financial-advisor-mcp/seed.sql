-- Financial Advisory Platform - Seed Data

INSERT INTO branches (id, branch_code, branch_name, address_line1, city, state, zip_code, phone, region) VALUES
('8f7e2a3c-9b4d-4e1f-a2c5-3d8e9f1a2b3c', 'NYC001', 'Manhattan Wealth Center', '245 Park Avenue', 'New York', 'NY', '10167', '212-555-0100', 'northeast'),
('2b5a8f3e-7c1d-4a9b-8f2e-1c5d9e3f7a8b', 'BOS001', 'Boston Financial District', '101 Federal Street', 'Boston', 'MA', '02110', '617-555-0200', 'northeast'),
('9c4f7b2a-5e8d-4c3f-9a1b-7e2f8c4d9b5a', 'MIA001', 'Brickell Investment Center', '1221 Brickell Avenue', 'Miami', 'FL', '33131', '305-555-0400', 'southeast'),
('4a7c2e9f-8b3d-4f1a-b5c8-2e9f4a7c1b8d', 'SF001', 'Financial District Branch', '555 California Street', 'San Francisco', 'CA', '94104', '415-555-0700', 'west');

-- Financial Advisors with varied specializations
INSERT INTO financial_advisors (id, employee_id, first_name, last_name, email, phone, license_number, specialization, branch_id, hire_date, commission_rate, status) VALUES
('f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c', 'EMP001', 'Jonathan', 'Blackstone', 'jonathan.blackstone@finserv.com', '212-555-0101', 'LIC001234', 'Private Equity & Alternative Investments', '8f7e2a3c-9b4d-4e1f-a2c5-3d8e9f1a2b3c', '2018-03-15', 0.0350, 'active'),
('7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a', 'EMP002', 'Sarah', 'Henderson', 'sarah.henderson@finserv.com', '617-555-0201', 'LIC001235', 'Retirement Planning & 401k Management', '2b5a8f3e-7c1d-4a9b-8f2e-1c5d9e3f7a8b', '2020-07-22', 0.0225, 'active'),
('e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', 'EMP003', 'Marcus', 'Wellington', 'marcus.wellington@finserv.com', '305-555-0401', 'LIC001236', 'Ultra High Net Worth & Family Office Services', '9c4f7b2a-5e8d-4c3f-9a1b-7e2f8c4d9b5a', '2016-11-08', 0.0400, 'active'),
('a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1', 'EMP004', 'Lisa', 'Chen', 'lisa.chen@finserv.com', '415-555-0701', 'LIC001237', 'General Wealth Management & Financial Planning', '4a7c2e9f-8b3d-4f1a-b5c8-2e9f4a7c1b8d', '2019-09-30', 0.0275, 'active');

UPDATE branches SET manager_id = 'f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c' WHERE id = '8f7e2a3c-9b4d-4e1f-a2c5-3d8e9f1a2b3c'; -- Jonathan manages NYC
UPDATE branches SET manager_id = '7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a' WHERE id = '2b5a8f3e-7c1d-4a9b-8f2e-1c5d9e3f7a8b'; -- Sarah manages Boston
UPDATE branches SET manager_id = 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d' WHERE id = '9c4f7b2a-5e8d-4c3f-9a1b-7e2f8c4d9b5a'; -- Marcus manages Miami
UPDATE branches SET manager_id = 'a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1' WHERE id = '4a7c2e9f-8b3d-4f1a-b5c8-2e9f4a7c1b8d'; -- Lisa manages SF

INSERT INTO customers (id, customer_number, ssn, first_name, last_name, email, phone, date_of_birth, address_line1, city, state, zip_code, risk_tolerance, kyc_status, kyc_completed_date, onboarding_date, financial_advisor_id, branch_id, status) VALUES
('c7f9a2e8-3d1b-4f8c-a7e9-2f8c1b4d7a9e', 'CUST000001', 'enc_ssn_001', 'Jennifer', 'Martinez', 'jennifer.martinez@email.com', '212-555-1001', '1985-06-15', '432 East 85th Street, Apt 3B', 'New York', 'NY', '10028', 'conservative', 'approved', '2023-01-15', '2023-01-10', 'f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c', '8f7e2a3c-9b4d-4e1f-a2c5-3d8e9f1a2b3c', 'active'),
('b3d8f1a7-e4c2-4b9f-d8a3-f1e4c2b9f8d3', 'CUST000002', 'enc_ssn_002', 'Richard', 'Pemberton', 'richard.pemberton@email.com', '212-555-1002', '1968-03-22', '740 Park Avenue, Unit 12A', 'New York', 'NY', '10021', 'aggressive', 'approved', '2023-02-20', '2023-02-15', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', '8f7e2a3c-9b4d-4e1f-a2c5-3d8e9f1a2b3c', 'active'),
('d9e5c2f8-a1b4-4d7e-c2f9-e5a1b4d7e2c9', 'CUST000003', 'enc_ssn_003', 'Dr. Michael', 'Thompson', 'michael.thompson@email.com', '617-555-2001', '1973-11-08', '85 Marlborough Street', 'Boston', 'MA', '02116', 'moderate', 'approved', '2023-03-10', '2023-03-05', '7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a', '2b5a8f3e-7c1d-4a9b-8f2e-1c5d9e3f7a8b', 'active'),
('f2c7b8e4-9a3d-4f1c-b8f2-c7e4a3d9f1c8', 'CUST000004', 'enc_ssn_004', 'Victoria', 'Ashford', 'victoria.ashford@email.com', '617-555-2002', '1962-09-14', '16 Louisburg Square', 'Boston', 'MA', '02108', 'moderate', 'approved', '2023-04-05', '2023-04-01', '7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a', '2b5a8f3e-7c1d-4a9b-8f2e-1c5d9e3f7a8b', 'active'),
('a8d3f7c1-e2b9-4a5d-f7a8-d3c1e2b9a5d7', 'CUST000005', 'enc_ssn_005', 'Carlos', 'Rodrigues', 'carlos.rodrigues@email.com', '305-555-3001', '1991-12-03', '1040 Biscayne Boulevard, Unit 503', 'Miami', 'FL', '33132', 'conservative', 'approved', '2023-01-25', '2023-01-20', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', '9c4f7b2a-5e8d-4c3f-9a1b-7e2f8c4d9b5a', 'active'),
('e1f4a9c7-b8d2-4e3f-a9e1-f4c7b8d2e3f9', 'CUST000006', 'enc_ssn_006', 'Isabella', 'Cortez', 'isabella.cortez@email.com', '305-555-3002', '1976-07-18', '2127 Brickell Avenue, PH-A', 'Miami', 'FL', '33129', 'aggressive', 'approved', '2023-05-12', '2023-05-08', 'f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c', '9c4f7b2a-5e8d-4c3f-9a1b-7e2f8c4d9b5a', 'active'),
('c5b9f3a2-d7e1-4c8b-f3c5-b9a2d7e1c8f3', 'CUST000007', 'enc_ssn_007', 'David', 'Chang', 'david.chang@email.com', '415-555-4001', '1979-04-27', '1 Rincon Hill, Unit 2801', 'San Francisco', 'CA', '94105', 'moderate', 'approved', '2023-02-08', '2023-02-03', 'a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1', '4a7c2e9f-8b3d-4f1a-b5c8-2e9f4a7c1b8d', 'active'),
('f7e2c9a5-b1d8-4f4e-c9f7-e2a5b1d8f4c9', 'CUST000008', 'enc_ssn_008', 'Amanda', 'Foster', 'amanda.foster@email.com', '415-555-4002', '1987-01-11', '2200 Pacific Avenue, Apt 12', 'San Francisco', 'CA', '94115', 'conservative', 'approved', '2023-06-22', '2023-06-18', 'f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c', '4a7c2e9f-8b3d-4f1a-b5c8-2e9f4a7c1b8d', 'active'),
('b4c8f1e7-a3d9-4b2c-f1b4-c8e7a3d9b2c8', 'CUST000009', 'enc_ssn_009', 'Alexander', 'Vanderbilt', 'alexander.vanderbilt@email.com', '212-555-1003', '1955-08-19', '834 Fifth Avenue, PH', 'New York', 'NY', '10065', 'moderate', 'approved', '2023-03-15', '2023-03-10', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', '8f7e2a3c-9b4d-4e1f-a2c5-3d8e9f1a2b3c', 'active'),
('d8a3f6c2-e9b7-4d1a-f6d8-a3c2e9b7d1a3', 'CUST000010', 'enc_ssn_010', 'Linda', 'Williams', 'linda.williams@email.com', '617-555-2003', '1984-05-30', '45 Beacon Hill Road', 'Boston', 'MA', '02108', 'conservative', 'approved', '2023-07-08', '2023-07-03', '7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a', '2b5a8f3e-7c1d-4a9b-8f2e-1c5d9e3f7a8b', 'active'),
('a2f7c4e9-b8d3-4a6f-c4a2-f7e9b8d3a6c4', 'CUST000011', 'enc_ssn_011', 'Robert', 'Jackson', 'robert.jackson@email.com', '305-555-3003', '1965-10-12', '5 Island Avenue, Unit 1205', 'Miami', 'FL', '33139', 'moderate', 'approved', '2023-04-18', '2023-04-13', 'a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1', '9c4f7b2a-5e8d-4c3f-9a1b-7e2f8c4d9b5a', 'active'),
('e7c1f8b4-d9a2-4e5c-f8e7-c1b4d9a2e5c1', 'CUST000012', 'enc_ssn_012', 'Margaret', 'Steinberg', 'margaret.steinberg@email.com', '415-555-4003', '1971-02-25', '2712 Broadway Street', 'San Francisco', 'CA', '94115', 'aggressive', 'approved', '2023-08-14', '2023-08-09', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', '4a7c2e9f-8b3d-4f1a-b5c8-2e9f4a7c1b8d', 'active'),
('c9f2a7e3-b5d1-4c4f-a7c9-f2e3b5d1c4a7', 'CUST000013', 'enc_ssn_013', 'James', 'Murphy', 'james.murphy@email.com', '212-555-1004', '1993-07-04', '201 East 69th Street, Apt 8F', 'New York', 'NY', '10021', 'conservative', 'approved', '2023-05-25', '2023-05-20', 'a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1', '8f7e2a3c-9b4d-4e1f-a2c5-3d8e9f1a2b3c', 'active'),
('f1e8c3a6-d2b9-4f7e-c3f1-e8a6d2b9f7c3', 'CUST000014', 'enc_ssn_014', 'Patricia', 'Lee', 'patricia.lee@email.com', '617-555-2004', '1978-12-16', '112 Mount Vernon Street', 'Boston', 'MA', '02108', 'moderate', 'approved', '2023-06-30', '2023-06-25', '7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a', '2b5a8f3e-7c1d-4a9b-8f2e-1c5d9e3f7a8b', 'active'),
('b6d4f9c2-a8e7-4b3d-f9b6-d4c2a8e7b3d4', 'CUST000015', 'enc_ssn_015', 'Thomas', 'Rodriguez', 'thomas.rodriguez@email.com', '305-555-3004', '1969-09-07', '900 Biscayne Bay, Unit 6301', 'Miami', 'FL', '33132', 'aggressive', 'approved', '2023-09-12', '2023-09-07', 'a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1', '9c4f7b2a-5e8d-4c3f-9a1b-7e2f8c4d9b5a', 'active'),
('a9c5f2d8-e1b6-4a7c-f2a9-c5d8e1b6a7c5', 'CUST000016', 'enc_ssn_016', 'Emily', 'Johnson', 'emily.johnson@email.com', '415-555-4004', '1990-03-28', '1875 Sacramento Street, Unit 402', 'San Francisco', 'CA', '94109', 'conservative', 'approved', '2023-07-20', '2023-07-15', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', '4a7c2e9f-8b3d-4f1a-b5c8-2e9f4a7c1b8d', 'active'),
('d3f8c1a7-b4e2-4d6f-c1d3-f8a7b4e2d6c1', 'CUST000017', 'enc_ssn_017', 'Catherine', 'Whitman', 'catherine.whitman@email.com', '212-555-1005', '1961-11-23', '510 Park Avenue, Unit 18B', 'New York', 'NY', '10022', 'aggressive', 'approved', '2023-10-05', '2023-10-01', 'f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c', '8f7e2a3c-9b4d-4e1f-a2c5-3d8e9f1a2b3c', 'active'),
('e4a7f3c9-d1b8-4e2a-f3e4-a7c9d1b8e2a7', 'CUST000018', 'enc_ssn_018', 'Kevin', 'Obrien', 'kevin.obrien@email.com', '617-555-2005', '1975-04-14', '77 Commonwealth Avenue, Unit 3', 'Boston', 'MA', '02116', 'moderate', 'approved', '2023-08-28', '2023-08-23', '7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a', '2b5a8f3e-7c1d-4a9b-8f2e-1c5d9e3f7a8b', 'active');

INSERT INTO accounts (id, account_number, customer_id, account_type, balance, available_balance, interest_rate, date_opened, minimum_balance, monthly_fee, status) VALUES
('f8e3c1a9-d2b7-4f5e-c1f8-e3a9d2b7f5c1', 'CHK-000001', 'c7f9a2e8-3d1b-4f8c-a7e9-2f8c1b4d7a9e', 'checking', 8500.00, 8000.00, 0.0025, '2023-01-10', 1000.00, 15.00, 'active'),
('a7d4f2c8-e1b9-4a3d-f2a7-d4c8e1b9a3d4', 'SAV-000001', 'c7f9a2e8-3d1b-4f8c-a7e9-2f8c1b4d7a9e', 'savings', 52000.00, 52000.00, 0.0175, '2023-01-10', 500.00, 0.00, 'active'),

-- Richard Pemberton (~8M total) - checking + investment + private accounts  
('c2e9f7a3-b8d1-4c6e-f7c2-e9a3b8d1c6e9', 'CHK-000002', 'b3d8f1a7-e4c2-4b9f-d8a3-f1e4c2b9f8d3', 'checking', 125000.00, 120000.00, 0.0025, '2023-02-15', 5000.00, 25.00, 'active'),
('b9f3c7e2-a4d8-4b1f-c7b9-f3e2a4d8b1c7', 'INV-000001', 'b3d8f1a7-e4c2-4b9f-d8a3-f1e4c2b9f8d3', 'investment', 7875000.00, 7875000.00, 0.0000, '2023-02-15', 25000.00, 0.00, 'active'),

-- Dr. Michael Thompson (~300K total) - checking + savings + 401k
('d5a8f1c4-e9b2-4d7a-f1d5-a8c4e9b2d7a8', 'CHK-000003', 'd9e5c2f8-a1b4-4d7e-c2f9-e5a1b4d7e2c9', 'checking', 35000.00, 32000.00, 0.0025, '2023-03-05', 2500.00, 20.00, 'active'),
('f1c6e4a9-b7d3-4f2c-e4f1-c6a9b7d3f2c6', 'SAV-000002', 'd9e5c2f8-a1b4-4d7e-c2f9-e5a1b4d7e2c9', 'savings', 115000.00, 115000.00, 0.0175, '2023-03-05', 1000.00, 0.00, 'active'),
('e8b4f9c1-d3a7-4e5b-f9e8-b4c1d3a7e5b4', '401K-00001', 'd9e5c2f8-a1b4-4d7e-c2f9-e5a1b4d7e2c9', '401k', 150000.00, 150000.00, 0.0000, '2023-03-05', 0.00, 0.00, 'active'),

-- Victoria Ashford (~12M total) - checking + investment + IRA
('a3f7c2e8-b9d4-4a1f-c2a3-f7e8b9d4a1c2', 'CHK-000004', 'f2c7b8e4-9a3d-4f1c-b8f2-c7e4a3d9f1c8', 'checking', 180000.00, 175000.00, 0.0025, '2023-04-01', 10000.00, 30.00, 'active'),
('c7e1f8b3-d4a9-4c5e-f8c7-e1b3d4a9c5e1', 'INV-000002', 'f2c7b8e4-9a3d-4f1c-b8f2-c7e4a3d9f1c8', 'investment', 10200000.00, 10200000.00, 0.0000, '2023-04-01', 50000.00, 0.00, 'active'),
('b8d2f5a7-e3c9-4b6d-f5b8-d2a7e3c9b6d2', 'IRA-000001', 'f2c7b8e4-9a3d-4f1c-b8f2-c7e4a3d9f1c8', 'ira', 1620000.00, 1620000.00, 0.0000, '2023-04-01', 0.00, 0.00, 'active'),

-- Carlos Rodrigues (~75K total) - checking + savings
('f4c8e1a6-d9b3-4f7c-e1f4-c8a6d9b3f7c8', 'CHK-000005', 'a8d3f7c1-e2b9-4a5d-f7a8-d3c1e2b9a5d7', 'checking', 15000.00, 14500.00, 0.0025, '2023-01-20', 1000.00, 15.00, 'active'),
('e9a5f3c7-b1d8-4e4a-f3e9-a5c7b1d8e4a5', 'SAV-000003', 'a8d3f7c1-e2b9-4a5d-f7a8-d3c1e2b9a5d7', 'savings', 60000.00, 60000.00, 0.0175, '2023-01-20', 500.00, 0.00, 'active'),

-- Isabella Cortez (~4.5M total) - checking + investment
('d1f9c4e7-a8b2-4d3f-c4d1-f9e7a8b2d3c4', 'CHK-000006', 'e1f4a9c7-b8d2-4e3f-a9e1-f4c7b8d2e3f9', 'checking', 85000.00, 80000.00, 0.0025, '2023-05-08', 5000.00, 25.00, 'active'),
('a6e2f8c3-b7d9-4a5e-f8a6-e2c3b7d9a5e2', 'INV-000003', 'e1f4a9c7-b8d2-4e3f-a9e1-f4c7b8d2e3f9', 'investment', 4415000.00, 4415000.00, 0.0000, '2023-05-08', 20000.00, 0.00, 'active'),

-- David Chang (~450K total) - checking + savings + investment
('c8f1e5a2-d4b7-4c9f-e5c8-f1a2d4b7c9e5', 'CHK-000007', 'c5b9f3a2-d7e1-4c8b-f3c5-b9a2d7e1c8f3', 'checking', 25000.00, 23000.00, 0.0025, '2023-02-03', 2500.00, 20.00, 'active'),
('b3e7f1c9-a5d8-4b2e-f1b3-e7c9a5d8b2e7', 'SAV-000004', 'c5b9f3a2-d7e1-4c8b-f3c5-b9a2d7e1c8f3', 'savings', 125000.00, 125000.00, 0.0175, '2023-02-03', 1000.00, 0.00, 'active'),
('f7a4e8c2-b9d1-4f6a-e8f7-a4c2b9d1f6a4', 'INV-000004', 'c5b9f3a2-d7e1-4c8b-f3c5-b9a2d7e1c8f3', 'investment', 300000.00, 300000.00, 0.0000, '2023-02-03', 10000.00, 0.00, 'active'),

-- Amanda Foster (~85K total) - checking + savings
('e2c6f9a1-d8b4-4e7c-f9e2-c6a1d8b4e7c6', 'CHK-000008', 'f7e2c9a5-b1d8-4f4e-c9f7-e2a5b1d8f4c9', 'checking', 12000.00, 11500.00, 0.0025, '2023-06-18', 1000.00, 15.00, 'active'),
('a9f3c5e8-b2d7-4a1f-c5a9-f3e8b2d7a1c5', 'SAV-000005', 'f7e2c9a5-b1d8-4f4e-c9f7-e2a5b1d8f4c9', 'savings', 73000.00, 73000.00, 0.0175, '2023-06-18', 500.00, 0.00, 'active'),

-- Alexander Vanderbilt (~15M total) - checking + investment + money_market
('d5e1f7c4-a3b9-4d8e-f7d5-e1c4a3b9d8e1', 'CHK-000009', 'b4c8f1e7-a3d9-4b2c-f1b4-c8e7a3d9b2c8', 'checking', 250000.00, 245000.00, 0.0025, '2023-03-10', 15000.00, 50.00, 'active'),
('c7f2e9a6-b4d1-4c3f-e9c7-f2a6b4d1c3e9', 'INV-000005', 'b4c8f1e7-a3d9-4b2c-f1b4-c8e7a3d9b2c8', 'investment', 13750000.00, 13750000.00, 0.0000, '2023-03-10', 100000.00, 0.00, 'active'),
('b8a4f1e3-d9c7-4b5a-f1b8-a4e3d9c7b5a4', 'MM-000001', 'b4c8f1e7-a3d9-4b2c-f1b4-c8e7a3d9b2c8', 'money_market', 1000000.00, 1000000.00, 0.0225, '2023-03-10', 50000.00, 0.00, 'active'),

-- Linda Williams (~65K total) - checking + 401k
('f3c9e2a7-b5d8-4f1c-e2f3-c9a7b5d8f1c9', 'CHK-000010', 'd8a3f6c2-e9b7-4d1a-f6d8-a3c2e9b7d1a3', 'checking', 18000.00, 17500.00, 0.0025, '2023-07-03', 1500.00, 15.00, 'active'),
('e6b2f8c1-a9d4-4e3b-f8e6-b2c1a9d4e3b2', '401K-00002', 'd8a3f6c2-e9b7-4d1a-f6d8-a3c2e9b7d1a3', '401k', 47000.00, 47000.00, 0.0000, '2023-07-03', 0.00, 0.00, 'active'),

-- Robert Jackson (~800K total) - checking + savings + investment
('a1d7f4c8-e2b9-4a6d-f4a1-d7c8e2b9a6d7', 'CHK-000011', 'a2f7c4e9-b8d3-4a6f-c4a2-f7e9b8d3a6c4', 'checking', 45000.00, 42000.00, 0.0025, '2023-04-13', 3000.00, 25.00, 'active'),
('c4f8e1a5-b7d2-4c9f-e1c4-f8a5b7d2c9e1', 'SAV-000006', 'a2f7c4e9-b8d3-4a6f-c4a2-f7e9b8d3a6c4', 'savings', 155000.00, 155000.00, 0.0175, '2023-04-13', 2000.00, 0.00, 'active'),
('b9e3f7c2-a1d8-4b4e-f7b9-e3c2a1d8b4e3', 'INV-000006', 'a2f7c4e9-b8d3-4a6f-c4a2-f7e9b8d3a6c4', 'investment', 600000.00, 600000.00, 0.0000, '2023-04-13', 15000.00, 0.00, 'active'),

-- Margaret Steinberg (~6.2M total) - checking + investment
('f2a8e5c1-d3b7-4f9a-e5f2-a8c1d3b7f9a8', 'CHK-000012', 'e7c1f8b4-d9a2-4e5c-f8e7-c1b4d9a2e5c1', 'checking', 95000.00, 90000.00, 0.0025, '2023-08-09', 5000.00, 30.00, 'active'),
('d7f1c4e9-a8b2-4d5f-c4d7-f1e9a8b2d5c4', 'INV-000007', 'e7c1f8b4-d9a2-4e5c-f8e7-c1b4d9a2e5c1', 'investment', 6105000.00, 6105000.00, 0.0000, '2023-08-09', 30000.00, 0.00, 'active'),

-- James Murphy (~55K total) - checking + savings
('e4c1f9a3-b8d5-4e2c-f9e4-c1a3b8d5e2c1', 'CHK-000013', 'c9f2a7e3-b5d1-4c4f-a7c9-f2e3b5d1c4a7', 'checking', 8500.00, 8000.00, 0.0025, '2023-05-20', 1000.00, 15.00, 'active'),
('a8f5c2e7-d1b9-4a3f-c2a8-f5e7d1b9a3c2', 'SAV-000007', 'c9f2a7e3-b5d1-4c4f-a7c9-f2e3b5d1c4a7', 'savings', 46500.00, 46500.00, 0.0175, '2023-05-20', 500.00, 0.00, 'active'),

-- Patricia Lee (~350K total) - checking + savings + 401k
('c6e9f2a4-b3d7-4c8e-f2c6-e9a4b3d7c8e9', 'CHK-000014', 'f1e8c3a6-d2b9-4f7e-c3f1-e8a6d2b9f7c3', 'checking', 28000.00, 26500.00, 0.0025, '2023-06-25', 2000.00, 20.00, 'active'),
('b2f6c9e1-a7d4-4b5f-c9b2-f6e1a7d4b5c9', 'SAV-000008', 'f1e8c3a6-d2b9-4f7e-c3f1-e8a6d2b9f7c3', 'savings', 122000.00, 122000.00, 0.0175, '2023-06-25', 1500.00, 0.00, 'active'),
('f7a3e1c8-d9b5-4f4a-e1f7-a3c8d9b5f4a3', '401K-00003', 'f1e8c3a6-d2b9-4f7e-c3f1-e8a6d2b9f7c3', '401k', 200000.00, 200000.00, 0.0000, '2023-06-25', 0.00, 0.00, 'active'),

-- Thomas Rodriguez (~3.8M total) - checking + investment + IRA
('d9c5f1e8-a2b7-4d6c-f1d9-c5e8a2b7d6c5', 'CHK-000015', 'b6d4f9c2-a8e7-4b3d-f9b6-d4c2a8e7b3d4', 'checking', 75000.00, 72000.00, 0.0025, '2023-09-07', 4000.00, 25.00, 'active'),
('a5e8f4c1-b9d3-4a7e-f4a5-e8c1b9d3a7e8', 'INV-000008', 'b6d4f9c2-a8e7-4b3d-f9b6-d4c2a8e7b3d4', 'investment', 3325000.00, 3325000.00, 0.0000, '2023-09-07', 20000.00, 0.00, 'active'),
('c1f7e2a9-d4b8-4c3f-e2c1-f7a9d4b8c3e2', 'IRA-000002', 'b6d4f9c2-a8e7-4b3d-f9b6-d4c2a8e7b3d4', 'ira', 400000.00, 400000.00, 0.0000, '2023-09-07', 0.00, 0.00, 'active'),

-- Emily Johnson (~72K total) - checking + savings  
('e8b4f1c7-a9d2-4e5b-f1e8-b4c7a9d2e5b4', 'CHK-000016', 'a9c5f2d8-e1b6-4a7c-f2a9-c5d8e1b6a7c5', 'checking', 14000.00, 13500.00, 0.0025, '2023-07-15', 1000.00, 15.00, 'active'),
('f3a7e9c2-b1d8-4f6a-e9f3-a7c2b1d8f6a7', 'SAV-000009', 'a9c5f2d8-e1b6-4a7c-f2a9-c5d8e1b6a7c5', 'savings', 58000.00, 58000.00, 0.0175, '2023-07-15', 500.00, 0.00, 'active'),

-- Catherine Whitman (~18M total) - checking + investment + money_market
('b7d2f5c9-e4a1-4b8d-f5b7-d2c9e4a1b8d2', 'CHK-000017', 'd3f8c1a7-b4e2-4d6f-c1d3-f8a7b4e2d6c1', 'checking', 320000.00, 315000.00, 0.0025, '2023-10-01', 20000.00, 75.00, 'active'),
('a4e1f8c6-d7b3-4a9e-f8a4-e1c6d7b3a9e1', 'INV-000009', 'd3f8c1a7-b4e2-4d6f-c1d3-f8a7b4e2d6c1', 'investment', 15680000.00, 15680000.00, 0.0000, '2023-10-01', 100000.00, 0.00, 'active'),
('c9f6e3a2-b5d8-4c1f-e3c9-f6a2b5d8c1e3', 'MM-000002', 'd3f8c1a7-b4e2-4d6f-c1d3-f8a7b4e2d6c1', 'money_market', 2000000.00, 2000000.00, 0.0225, '2023-10-01', 75000.00, 0.00, 'active'),

-- Kevin O'Brien (~520K total) - checking + savings + 401k + IRA
('f1e5c8a4-b2d9-4f3e-c8f1-e5a4b2d9f3c8', 'CHK-000018', 'e4a7f3c9-d1b8-4e2a-f3e4-a7c9d1b8e2a7', 'checking', 32000.00, 30000.00, 0.0025, '2023-08-23', 2500.00, 20.00, 'active'),
('d6c2f9e7-a8b1-4d4c-f9d6-c2e7a8b1d4c2', 'SAV-000010', 'e4a7f3c9-d1b8-4e2a-f3e4-a7c9d1b8e2a7', 'savings', 88000.00, 88000.00, 0.0175, '2023-08-23', 1500.00, 0.00, 'active'),
('b9f4c1e8-d7a3-4b6f-c1b9-f4e8d7a3b6c1', '401K-00004', 'e4a7f3c9-d1b8-4e2a-f3e4-a7c9d1b8e2a7', '401k', 275000.00, 275000.00, 0.0000, '2023-08-23', 0.00, 0.00, 'active'),
('e3a8f5c2-b4d1-4e7a-f5e3-a8c2b4d1e7a8', 'IRA-000003', 'e4a7f3c9-d1b8-4e2a-f3e4-a7c9d1b8e2a7', 'ira', 125000.00, 125000.00, 0.0000, '2023-08-23', 0.00, 0.00, 'active');

INSERT INTO investment_portfolios (id, customer_id, financial_advisor_id, portfolio_name, investment_strategy, total_value, cash_balance, created_date, last_rebalance_date, target_risk_score, current_risk_score, benchmark_index, performance_ytd, status) VALUES

-- High net worth clients with appropriate portfolios
('a7f3c9e2-b8d1-4a5f-c9a7-f3e2b8d1a5c9', 'b3d8f1a7-e4c2-4b9f-d8a3-f1e4c2b9f8d3', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', 'Pemberton Aggressive Growth', 'High-growth equity focus with alternative investments', 7875000.00, 235000.00, '2023-02-20', '2023-12-01', 8, 8, 'S&P 500', 0.1420, 'active'),
('c2e8f1a9-d4b7-4c6e-f1c2-e8a9d4b7c6e8', 'f2c7b8e4-9a3d-4f1c-b8f2-c7e4a3d9f1c8', '7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a', 'Ashford Wealth Preservation', 'Conservative wealth preservation with income focus', 10200000.00, 510000.00, '2023-04-05', '2023-11-15', 4, 4, 'Russell 1000 Value', 0.0850, 'active'),
('e9a5f7c3-b1d8-4e4a-f7e9-a5c3b1d8e4a5', 'e1f4a9c7-b8d2-4e3f-a9e1-f4c7b8d2e3f9', 'f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c', 'Cortez Private Equity Portfolio', 'Private equity and hedge fund alternatives', 4415000.00, 88000.00, '2023-05-12', '2023-12-08', 9, 9, 'MSCI World', 0.1680, 'active'),
('f5c1e9a6-d3b7-4f2c-e9f5-c1a6d3b7f2c1', 'c5b9f3a2-d7e1-4c8b-f3c5-b9a2d7e1c8f3', 'a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1', 'Chang Balanced Growth', 'Balanced portfolio with tech sector focus', 300000.00, 18000.00, '2023-02-08', '2023-11-20', 6, 6, 'NASDAQ Composite', 0.0920, 'active'),
('b8d4f2c7-a9e1-4b5d-f2b8-d4c7a9e1b5d4', 'b4c8f1e7-a3d9-4b2c-f1b4-c8e7a3d9b2c8', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', 'Vanderbilt Ultra Portfolio', 'Ultra high net worth family office strategy', 13750000.00, 687500.00, '2023-03-15', '2023-12-10', 5, 5, 'Dow Jones Industrial', 0.1120, 'active'),
('d1f8c5e3-b2a9-4d7f-c5d1-f8e3b2a9d7c5', 'a2f7c4e9-b8d3-4a6f-c4a2-f7e9b8d3a6c4', 'a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1', 'Jackson Growth & Income', 'Growth and income with real estate exposure', 600000.00, 36000.00, '2023-04-18', '2023-11-28', 7, 7, 'S&P 500', 0.1050, 'active'),
('a4e7f9c1-d8b3-4a2e-f9a4-e7c1d8b3a2e7', 'e7c1f8b4-d9a2-4e5c-f8e7-c1b4d9a2e5c1', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', 'Steinberg Tech Growth', 'Technology sector focus with growth emphasis', 6105000.00, 305000.00, '2023-08-14', '2023-12-15', 8, 8, 'NASDAQ 100', 0.1580, 'active'),
('c7f2e5a8-b4d9-4c1f-e5c7-f2a8b4d9c1e5', 'b6d4f9c2-a8e7-4b3d-f9b6-d4c2a8e7b3d4', 'a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1', 'Rodriguez International Portfolio', 'International diversification with emerging markets', 3325000.00, 165000.00, '2023-09-12', '2023-12-05', 7, 7, 'MSCI Emerging Markets', 0.0980, 'active'),
('f9e3c6a1-d7b2-4f8e-c6f9-e3a1d7b2f8c6', 'd3f8c1a7-b4e2-4d6f-c1d3-f8a7b4e2d6c1', 'f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c', 'Whitman Alternative Investments', 'Private equity, hedge funds, and alternative assets', 15680000.00, 940000.00, '2023-10-05', '2023-12-12', 9, 9, 'Russell 2000', 0.1720, 'active');

INSERT INTO transactions (id, account_id, transaction_type, amount, transaction_date, description, reference_number, initiated_by_user_id, status, balance_after, fees) VALUES
('d4f7c1e9-a8b2-4d3f-c1d4-f7e9a8b2d3c1', 'f8e3c1a9-d2b7-4f5e-c1f8-e3a9d2b7f5c1', 'deposit', 2800.00, '2024-12-28 10:30:00', 'Payroll Direct Deposit', 'DD240001', 'c7f9a2e8-3d1b-4f8c-a7e9-2f8c1b4d7a9e', 'completed', 8500.00, 0.00),
('a8e2f9c5-b1d7-4a6e-f9a8-e2c5b1d7a6e2', 'c2e9f7a3-b8d1-4c6e-f7c2-e9a3b8d1c6e9', 'withdrawal', -25000.00, '2024-12-26 14:22:00', 'Investment Transfer', 'INV240001', 'b3d8f1a7-e4c2-4b9f-d8a3-f1e4c2b9f8d3', 'completed', 125000.00, 50.00),
('c1f5e8a3-d9b4-4c2f-e8c1-f5a3d9b4c2e8', 'e2c6f9a1-d8b4-4e7c-f9e2-c6a1d8b4e7c6', 'deposit', 3200.00, '2024-12-27 11:20:00', 'Freelance Payment', 'FP240001', 'f7e2c9a5-b1d8-4f4e-c9f7-e2a5b1d8f4c9', 'completed', 12000.00, 0.00),
('e7a4f2c8-b3d9-4e5a-f2e7-a4c8b3d9e5a4', 'f2a8e5c1-d3b7-4f9a-e5f2-a8c1d3b7f9a8', 'deposit', 18500.00, '2024-12-31 08:45:00', 'Investment Dividend', 'DIV240001', NULL, 'completed', 95000.00, 0.00),
('b9c6f1e4-a7d2-4b8c-f1b9-c6e4a7d2b8c6', 'd5e1f7c4-a3b9-4d8e-f7d5-e1c4a3b9d8e1', 'fee', -75.00, '2024-12-31 23:59:00', 'Monthly Premium Account Fee', 'FEE240001', NULL, 'completed', 250000.00, 0.00);

INSERT INTO transactions (id, account_id, transaction_type, amount, transaction_date, description, reference_number, counterparty_account_id, initiated_by_user_id, status, balance_after, fees) VALUES
('f3e8c2a7-d1b9-4f4e-c2f3-e8a7d1b9f4c2', 'c2e9f7a3-b8d1-4c6e-f7c2-e9a3b8d1c6e9', 'transfer', -50000.00, '2024-12-29 16:45:00', 'Transfer to Investment Account', 'TRF240001', 'b9f3c7e2-a4d8-4b1f-c7b9-f3e2a4d8b1c7', 'b3d8f1a7-e4c2-4b9f-d8a3-f1e4c2b9f8d3', 'completed', 100000.00, 35.00),
('e6d1f9c4-a8b3-4e2d-f9e6-d1c4a8b3e2d1', 'b9f3c7e2-a4d8-4b1f-c7b9-f3e2a4d8b1c7', 'transfer', 50000.00, '2024-12-29 16:45:00', 'Transfer from Checking Account', 'TRF240001', 'c2e9f7a3-b8d1-4c6e-f7c2-e9a3b8d1c6e9', 'b3d8f1a7-e4c2-4b9f-d8a3-f1e4c2b9f8d3', 'completed', 7925000.00, 0.00);

INSERT INTO audit_logs (id, user_id, user_type, user_role, action_type, table_name, record_id, timestamp, ip_address, user_agent, session_id, compliance_flag, severity_level, description) VALUES
('a3e9f5c1-d8b4-4a7e-f5a3-e9c1d8b4a7e9', 'c7f9a2e8-3d1b-4f8c-a7e9-2f8c1b4d7a9e', 'customer', 'retail_customer', 'login', NULL, NULL, '2024-12-31 08:30:00', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', 'd2f8c4a1-e9b7-4d5f-c4d2-f8a1e9b7d5c4', FALSE, 1, 'Customer login successful'),
('c8f2e7a4-b1d9-4c5f-e7c8-f2a4b1d9c5e7', 'f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c', 'advisor', 'private_equity_specialist', 'view', 'customers', 'c7f9a2e8-3d1b-4f8c-a7e9-2f8c1b4d7a9e', '2024-12-31 09:05:00', '10.0.1.45', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)', 'b7e4c1a9-f2d8-4b3e-c1b7-e4a9f2d8b3c1', TRUE, 3, 'Private equity specialist reviewing small client - potential mismatch'),
('e1a7f4c9-d2b8-4e6a-f4e1-a7c9d2b8e6a7', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', 'advisor', 'ultra_high_net_worth_specialist', 'view', 'accounts', 'f4c8e1a6-d9b3-4f7c-e1f4-c8a6d9b3f7c8', '2024-12-31 09:15:00', '10.0.2.33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', 'f9c3e6a2-d7b1-4f8c-e6f9-c3a2d7b1f8c3', TRUE, 4, 'Ultra HNW specialist accessing 75K client account - major mismatch'),
('b6d9f3c5-a1e8-4b4d-f3b6-d9c5a1e8b4d9', 'b3d8f1a7-e4c2-4b9f-d8a3-f1e4c2b9f8d3', 'customer', 'high_net_worth_customer', 'transfer', 'transactions', 'f3e8c2a7-d1b9-4f4e-c2f3-e8a7d1b9f4c2', '2024-12-29 16:45:00', '203.0.113.25', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X)', 'a5c8f1e4-b9d2-4a7c-f1a5-c8e4b9d2a7c8', FALSE, 2, 'Large investment transfer completed'),
('f4a1e8c7-d3b9-4f2a-e8f4-a1c7d3b9f2a1', 'a1e4c8f2-9b7d-4a3e-c8f1-e4a7c2f9b8d1', 'advisor', 'general_wealth_manager', 'create', 'investment_portfolios', 'c7f2e5a8-b4d9-4c1f-e5c7-f2a8b4d9c1e5', '2024-12-30 14:30:00', '10.0.3.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', 'e2f9c5a8-b4d1-4e6f-c5e2-f9a8b4d1e6c5', FALSE, 2, 'Created new investment portfolio for client'),
('d7c4f2e9-a8b1-4d5c-f2d7-c4e9a8b1d5c4', '7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a', 'advisor', 'retirement_specialist', 'logout', NULL, NULL, '2024-12-31 17:00:00', '10.0.1.89', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)', 'c6e3f9a1-d8b7-4c2e-f9c6-e3a1d8b7c2e3', FALSE, 1, 'Advisor logout successful');

INSERT INTO compliance_reports (id, report_number, report_type, customer_id, generated_by_user_id, generated_date, report_data, summary, status, priority_level, regulatory_filing_required, filing_deadline) VALUES
('a9e5f2c8-b7d1-4a4e-f2a9-e5c8b7d1a4e5', 'RPT-2024-001', 'kyc_review', 'c7f9a2e8-3d1b-4f8c-a7e9-2f8c1b4d7a9e', 'f3b8e1c4-d7a2-4c9f-8e1b-4c7d9f2a8e1c', '2024-12-20 14:30:00', '{"client_assets": 60500, "advisor_specialization": "Private Equity & Alternative Investments", "mismatch_score": 8.5, "recommended_action": "reassign_to_general_wealth_manager"}', 'KYC review flagged advisor-client mismatch: 60K client with private equity specialist', 'under_review', 3, FALSE, NULL),
('c3f7e1a6-d8b4-4c9f-e1c3-f7a6d8b4c9e1', 'RPT-2024-002', 'kyc_review', 'a8d3f7c1-e2b9-4a5d-f7a8-d3c1e2b9a5d7', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', '2024-12-22 10:15:00', '{"client_assets": 75000, "advisor_specialization": "Ultra High Net Worth & Family Office Services", "mismatch_score": 9.2, "recommended_action": "immediate_reassignment"}', 'Severe mismatch: 75K client assigned to Ultra HNW specialist', 'submitted', 4, TRUE, '2025-01-15'),
('e8a4f9c2-b1d7-4e6a-f9e8-a4c2b1d7e6a4', 'RPT-2024-003', 'kyc_review', 'f2c7b8e4-9a3d-4f1c-b8f2-c7e4a3d9f1c8', '7d2f9a8c-3e1b-4f8d-a2c7-9f1e4b8c2d7a', '2024-12-18 16:45:00', '{"client_assets": 12000000, "advisor_specialization": "Retirement Planning & 401k Management", "mismatch_score": 7.8, "recommended_action": "reassign_to_ultra_hnw_specialist"}', 'High net worth client may benefit from specialist advisor', 'approved', 2, FALSE, NULL),
('b2f6c9e5-a7d3-4b1f-c9b2-f6e5a7d3b1c9', 'RPT-2024-004', 'kyc_review', 'a9c5f2d8-e1b6-4a7c-f2a9-c5d8e1b6a7c5', 'e9c5f2b7-4a8d-4e3c-b1f9-5c7e2f4a9b8d', '2024-12-21 09:30:00', '{"client_assets": 72000, "advisor_specialization": "Ultra High Net Worth & Family Office Services", "mismatch_score": 9.5, "recommended_action": "immediate_reassignment", "cost_efficiency_concern": true}', 'Critical mismatch: Small client with ultra HNW specialist - resource inefficiency', 'under_review', 5, TRUE, '2025-01-10');
