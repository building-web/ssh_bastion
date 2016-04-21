## Create development system

### Install Vagrant

ref https://www.vagrantup.com/docs/installation/

#### Arch Linux

```bash
$ pacman -Syu virtualbox vagrant
```

#### Mac

```bash
$ brew cask install virtualbox vagrant
```

TODO

### Up Vagrant with ubuntu 14.04

```bash

$ cd ubuntu-14.04

$ cp Vagrantfile.example Vagrantfile

$ wget -nc http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box

$ wget -nc https://github.com/mailhog/MailHog/releases/download/v0.2.0/MailHog_linux_amd64

$ vagrant up --no-provision

$ vagrant provision

$ open http://127.0.0.1:3000 #access website

$ open http://127.0.0.1:8025 #access mailhog web ui

$ open http://127.0.0.1:9000 #access graylog web ui, default username is 'admin', password is 'admin'.

```
