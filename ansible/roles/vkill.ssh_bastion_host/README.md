SSH bastion host
=========

ssh bastion host.

Requirements
------------

Tested on:

* Ubuntu trusty

Role Variables
--------------

TODO

Dependencies
------------

[willshersystems.sshd](https://github.com/willshersystems/ansible-sshd)

Example Playbook
----------------

```yaml
- hosts: servers
  roles:
     - role: vkill.ssh_bastion_host
```

License
-------

BSD

MIT

Author Information
------------------

vkill <vkill.net@gmail.com>

&copy; 2016
