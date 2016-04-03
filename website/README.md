## README

* System dependencies

https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit

* How to run

$ cp .versions.conf.example .versions.conf

$ cd .

$ cp .env.example .env

$ cp config/database.yml.example config/database.yml

$ rake db:create && rake db:migrate && rake db:seed

* How to run test

$ rake parallel:create

$ rake parallel:prepare

$ rake parallel:setup

$ rake parallel:spec




