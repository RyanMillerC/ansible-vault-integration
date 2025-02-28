#!/bin/bash

set -e

ROLE_NAME=ansible

vault policy write "$ROLE_NAME" - << EOF
# Allow everything (because it's a demo, dude.)
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOF

vault write "auth/approle/role/$ROLE_NAME" \
    token_type=batch \
    secret_id_ttl=10m \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    policies="$ROLE_NAME"

echo "Role ID:"
vault read "auth/approle/role/$ROLE_NAME/role-id"

echo "Secret ID:"
vault write -f "auth/approle/role/$ROLE_NAME/secret-id"
