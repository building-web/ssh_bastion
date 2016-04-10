## README

* System dependencies

https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit

* How to run

```bash
$ cp .versions.conf.example .versions.conf

$ cd .

$ cp .env.example .env

$ cp config/database.yml.example config/database.yml

$ RAILS_ENV=development rake db:environment:set && rake db:drop:all && rake db:create && rake db:migrate && rake db:seed

$ touch config/settings.local.yml

# create a GPG key, refer to https://fedoraproject.org/wiki/Creating_GPG_Keys#Creating_GPG_Keys_Using_the_Command_Line

$ vim config/settings.local.yml

website_GPG_key_ID: 7E4A6A09

```

* How to run test

```bash

$ RAILS_ENV=test rake db:drop && RAILS_ENV=test rake db:create && RAILS_ENV=test rake db:schema:load

$ rspec # or guard

```

or

```bash
$ rake parallel:setup

$ rake parallel:spec

```
