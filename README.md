# Yeah, this repo has secrets in it. Yeah, that isn't a good idea. The secrets are for a throw away lab environment. 🤷

## Credential Type

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
