#!/bin/sh

# Currently work only on MacOS

SCRIPT_DIR=$(dirname "$0")
USER_ID=$1

# Function to create JWT token (expires in 1 day)
create_jwt_token() {
    local user_id="$1"
    local secret="1234567890abcdef1234567890abcdef"  # Must match the ones in appropriate .env.* files
    
    # Create header (base64url encoded)
    header='{"alg":"HS256","typ":"JWT"}'
    header_b64=$(printf "%s" "$header" | openssl base64 -e -A | tr '/+' '_-' | tr -d '=')
    
    # Create payload based on user_id
    current_time=$(date +%s)
    expiry_time=$((current_time + 86400))  # 86400 seconds = 1 day
    
    if [ "$user_id" = "admin" ]; then
        payload="{\"role\":\"admin\",\"iat\":$current_time,\"exp\":$expiry_time}"
    else
        # Read UUID from user-mapping.txt
        mapping_file="$SCRIPT_DIR/user-mapping.txt"
        if [ ! -f "$mapping_file" ]; then
            echo "Error: User mapping file not found: $mapping_file" >&2
            return 1
        fi
        
        sub=$(grep "^$user_id:" "$mapping_file" | cut -d: -f2)
        if [ -z "$sub" ]; then
            echo "Error: User ID '$user_id' not found in mapping file" >&2
            return 1
        fi
        
        payload="{\"sub\":\"$sub\",\"iat\":$current_time,\"exp\":$expiry_time}"
    fi
    
    payload_b64=$(printf "%s" "$payload" | openssl base64 -e -A | tr '/+' '_-' | tr -d '=')
    
    # Create signature
    message="$header_b64.$payload_b64"
    signature=$(printf "%s" "$message" | openssl dgst -sha256 -hmac "$secret" -binary | openssl base64 -e -A | tr '/+' '_-' | tr -d '=')
    
    # Return complete JWT
    echo "$header_b64.$payload_b64.$signature"
}

# Check if the user ID is provided and validate format
if [ -z "$USER_ID" ]; then
    echo "Usage: $0 <user_id>"
    echo "user_id must start with EMP or CUST, or be 'admin'"
    exit 1
fi

# Validate user_id format
case "$USER_ID" in
    EMP*|CUST*|admin)
        ;;
    *)
        echo "Error: Invalid user_id '$USER_ID'. Must start with EMP or CUST, or be 'admin'"
        exit 1
        ;;
esac

JWT_TOKEN=$(create_jwt_token "$USER_ID")

if [ -z "$JWT_TOKEN" ]; then
    printf "Available user IDs: "
    cut -d: -f1 "$SCRIPT_DIR/user-mapping.txt" | tr '\n' ' '
    echo
    exit 1
fi

CLAUDE_CONFIG="{
  \"mcpServers\": {
    \"finance-advisory-local\": {
      \"command\": \"$HOME/.exograph/bin/exo-mcp-bridge\",
      \"args\": [
        \"--endpoint\",
        \"http://localhost:9876/mcp\",
        \"--header\",
        \"Authorization=Bearer $JWT_TOKEN\"
      ]
    }
  }
}"

# Check if the configuration file exists
if [ -f "$HOME/Library/Application Support/Claude/claude_desktop_config.json" ]; then
   printf "Configuration file already exists. Should I overwrite it? (y/n) "
   read -r response
   if [[ "$response" != "y" && "$response" != "Y" ]]; then
       echo "Exiting without changes."
       exit 0
   fi
fi

# Copy the configuration to the Claude directory
echo "$CLAUDE_CONFIG" > "$HOME/Library/Application Support/Claude/claude_desktop_config.json" || {
    echo "Error: Failed to write claude_desktop_config.json"
    exit 1
}
