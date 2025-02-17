.PHONY: run
run:
	ansible-playbook test.yml

.PHONY: vault-up
vault-up:
	podman run \
		--cap-add=IPC_LOCK \
		-e 'VAULT_LOCAL_CONFIG={"storage": {"file": {"path": "/vault/file"}}, "listener": [{"tcp": { "address": "0.0.0.0:8200", "tls_disable": true}}], "default_lease_ttl": "168h", "max_lease_ttl": "720h", "ui": true}' \
		-p 8200:8200 \
		docker.io/hashicorp/vault \
		server

.PHONY: vault-dev
vault-dev:
	podman run \
		--cap-add=IPC_LOCK \
		--name=dev-vault \
		--publish 8200:8200 \
		--rm \
		hashicorp/vault
