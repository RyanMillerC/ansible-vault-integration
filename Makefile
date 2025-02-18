# Run playbook from command line
.PHONY: run
run:
	# Dev token regenerated on restart. Nothing to see here.
	ansible-playbook \
		-e ansible_hashi_vault_url="https://vault.taco.moe" \
		-e ansible_hashi_vault_token="hvs.GAj7TE2TRKKzHxvsVDTtAzjO" \
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
