# Run playbook using approle auth (preferred)
.PHONY: run-approle
run-approle:
	-rm "${HOME}/.vault_token"
	# Yeah, this repo has secrets in it. Yeah, that isn't a good idea. The secrets are for a throw away lab environment. 🤷
	ansible-playbook \
		-e ansible_hashi_vault_auth_method="approle" \
		-e ansible_hashi_vault_role_id="995e700d-e7b8-1124-cc69-3e2ba8286a69" \
		-e ansible_hashi_vault_secret_id="e0dc3e6d-a98d-14ed-2eaf-7914bed63a3a" \
		-e ansible_hashi_vault_url="https://vault.taco.moe" \
		-i ./inventory \
		test.yml

# Run playbook using token auth (for testing)
.PHONY: run-token
run-token:
	-rm "${HOME}/.vault_token"
	# Yeah, this repo has secrets in it. Yeah, that isn't a good idea. The secrets are for a throw away lab environment. 🤷
	ansible-playbook \
		-e ansible_hashi_vault_url="https://vault.taco.moe" \
		-e ansible_hashi_vault_token="hvs.GAj7TE2TRKKzHxvsVDTtAzjO" \
		-i ./inventory \
		test.yml


# Build Ansible Execution Environment image with community.hashi_vault
# collection and dependencies installed.
.PHONY: build-ee
build-ee:
	ansible-builder build --tag hashi_vault_ee --extra-build-cli-args "--platform linux/amd64"


# Run vault in a container (for testing).
.PHONY: vault-dev
vault-dev:
	podman run \
		--cap-add=IPC_LOCK \
		--name=dev-vault \
		--publish 8200:8200 \
		--rm \
		docker.io/hashicorp/vault
