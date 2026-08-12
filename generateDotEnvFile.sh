#!/bin/bash

# Generate a random alphanumeric password (letters + numbers only)
generate_password() {
  local length=${1:-20}
  tr -dc 'A-Za-z0-9' < /dev/urandom | head -c "$length"
}

# Generate three separate passwords
FILEBROWSER_ADMIN_PASSWORD=$(generate_password)

PASSWORD=$FILEBROWSER_ADMIN_PASSWORD
# For Separate Password
# PASSWORD=$(generate_password)

SUDO_PASSWORD=$FILEBROWSER_ADMIN_PASSWORD
# For Separate Password
# SUDO_PASSWORD=$(generate_password)

# Write the .env file
cat > .env << EOF
# File Browser
FILEBROWSER_ADMIN_PASSWORD=${FILEBROWSER_ADMIN_PASSWORD}

# Code Server
PASSWORD=${PASSWORD}
SUDO_PASSWORD=${SUDO_PASSWORD}
EOF

echo "Generated .env file with new passwords:"
echo
cat .env
