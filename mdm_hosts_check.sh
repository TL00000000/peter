#!/bin/bash

# Define color codes (optional for logging)
RED='\033[1;31m'
GRN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

# MDM Server Domains to block
MDM_DOMAINS=(
  "deviceenrollment.apple.com"
  "mdmenrollment.apple.com"
  "iprofiles.apple.com"
)

# Hosts file path
HOSTS_FILE="/etc/hosts"

# Function to block MDM domains
block_mdm_domains() {
  for domain in "${MDM_DOMAINS[@]}"; do
    if ! grep -q "0.0.0.0 $domain" "$HOSTS_FILE"; then
      echo "0.0.0.0 $domain" | sudo tee -a "$HOSTS_FILE" > /dev/null
      echo -e "${GRN}Blocked $domain${NC}"
    fi
  done
}

# Run the block function
block_mdm_domains
