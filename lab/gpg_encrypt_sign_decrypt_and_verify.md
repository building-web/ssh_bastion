## gpg encrypt, sign, decrypt and verify

### encrypt and sign by bash

```bash

$ sudo su - vagrant

$ cd ~

$ echo '{"hosts":[{"ip":"127.0.0.1","user":"ubuntu"}]}' > data.txt

$ cp data.txt /tmp/

$ cat data.txt | gpg --recipient 8CDBE8F5 --armor --encrypt > data.en.txt

$ cat data.en.txt | gpg --local-user 3A3D2A82 --armor --detach-sign > data.en.txt.sig

$ cp data.en.txt /tmp/

$ cp data.en.txt.sig /tmp/

```

### encrypt and sign by ruby

```bash

$ sudo su - vagrant

$ cd ~

$ echo '{"hosts":[{"ip":"127.0.0.1","user":"ubuntu"}]}' > data.txt

$ cp data.txt /tmp/

$ irb

> require 'gpgme'

> crypto = GPGME::Crypto.new(recipients: '8CDBE8F5', signers: '3A3D2A82', armor: true, always_trust: true)

> data = File.read('/tmp/data.txt')

> data_en = crypto.encrypt(data).read

> data_en_sig = crypto.detach_sign(data_en).read

> File.write('/tmp/data.en.txt', data_en)

> File.write('/tmp/data.en.txt.sig', data_en_sig)

```

### decrypt and verify by bash

```bash

$ sudo usermod -s /bin/bash developer

$ sudo su - developer

$ cd ~

$ gpg --local-user 3A3D2A82 --verify /tmp/data.en.txt.sig /tmp/data.en.txt 2>/dev/null

$ echo $?

$ cat /tmp/data.en.txt | gpg --local-user 8CDBE8F5 --armor --decrypt 2>/dev/null

```