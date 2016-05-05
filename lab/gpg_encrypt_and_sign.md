## GPG encrypt and sign

```bash

$ sudo usermod -s /bin/bash developer

$ sudo su - vagrant

$ cd ~

$ cat data.txt
{"hosts":[{"ip":"127.0.0.1","user":"ubuntu"}]}

$ cat data.txt | gpg --recipient 8CDBE8F5 --armor --encrypt > data.en.txt

$ cat data.en.txt | gpg --local-user 3A3D2A82 --armor --detach-sign > data.en.txt.sig

$ cp data.en.txt /tmp/

$ cp data.en.txt.sig /tmp/

$ sudo su - developer

$ cd ~

$ gpg --local-user 3A3D2A82 --verify /tmp/data.en.txt.sig /tmp/data.en.txt

$ cat /tmp/data.en.txt | gpg --local-user 8CDBE8F5 --armor --decrypt

```