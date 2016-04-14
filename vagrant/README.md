## Create development system

### Install Vagrant

#### Arch Linux

```bash
$ pacman -Syu virtualbox vagrant
```

TODO

### Up Vagrant with ubuntu 14.04

```bash

$ cd ubuntu-14.04

$ cp Vagrantfile.example Vagrantfile

$ wget -nc http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box

$ vagrant up

$ vagrant provision

```
