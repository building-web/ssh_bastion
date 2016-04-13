## Setup

### Install vagrant

#### Arch Linux

```bash
$ pacman -Syu virtualbox vagrant
```

TODO

### Create a vagrant base box with ubuntu 14.04

```bash

$ wget http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box

$ vagrant init ssh_bastion_development trusty-server-cloudimg-amd64-vagrant-disk1.box

$ vagrant up

```
