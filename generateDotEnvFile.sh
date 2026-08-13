#!/bin/bash

# Directory of this script, so it works no matter where it is invoked from.
DIR="$(cd "$(dirname "$0")" && pwd)"

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

# Write the .env file next to this script. Values are quoted so they can be
# double-clicked and copied in a terminal (docker-compose strips the quotes).
cat > "$DIR/.env" << EOF
# File Browser
FILEBROWSER_ADMIN_PASSWORD="${FILEBROWSER_ADMIN_PASSWORD}"

# Code Server
PASSWORD="${PASSWORD}"
SUDO_PASSWORD="${SUDO_PASSWORD}"
EOF

echo "Generated .env file with new passwords:"
echo
cat "$DIR/.env"

# Regenerate the Caddyfile so basic auth uses the new PASSWORD.
"$DIR/scripts/generateCaddyfile.sh"
