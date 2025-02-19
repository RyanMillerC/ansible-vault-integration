# Ansible (AAP) integration with Hashicorp Vault

Based off this [blog post](https://www.puzzle.ch/blog/2022/12/08/ansible-automation-platform-and-hashicorp-vault).

**Example Playbook:** [playbook.yml](playbook.yml)

## What's needed to make this work

* Custom *"Credential Type"* in AAP
* Ansible Execution Environment with *"community.hashi_vault"* collection and *"hvac"* Python dependency

## Custom Credential Type

* **Name:** Hashicorp Vault AppRole
* **Description:** Authenticate Ansible to Hashicorp Vault using an AppRole. For use with the community.hashi_vault collection.
* **Input Configuration:**

```yaml
fields:
  - id: vault_role_id
    label: AppRole Role ID
    type: string
  - id: vault_secret_id
    label: AppRole Secret ID
    secret: true
    type: string
  - id: vault_url
    label: Hashicorp Vault URL
    type: string
required:
  - vault_role_id
  - vault_secret_id
  - vault_url
```

* **Injector Configuration:**

```yaml
extra_vars:
  ansible_hashi_vault_auth_method: approle
  ansible_hashi_vault_role_id: '{{ vault_role_id }}'
  ansible_hashi_vault_secret_id: '{{ vault_secret_id }}'
  ansible_hashi_vault_url: '{{ vault_url }}'
```

## Ansible Execution Environment

**Source Code:** [execution-environment.yml](execution-environment.yml)

```bash
ansible-builder build --tag hashi_vault_ee --extra-build-cli-args "--platform linux/amd64"
```
