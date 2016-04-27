## Ansible

### Install Ansible 2.0+

ref http://docs.ansible.com/ansible/intro_installation.html

### Install Ansible Galaxy requirements

```bash
$ ansible-galaxy install -r requirements.yml -p roles -v -f
```

### Copy and edit some yml files

```bash
$ cp vars/settings_dev.yml.example vars/settings_dev.yml
```

```bash
$ cp playbook_dev.yml.example playbook_dev.yml
```
