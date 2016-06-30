## README

* System dependencies

[PhantomJS](https://github.com/teampoltergeist/poltergeist#installing-phantomjs)

* How to run

```bash
$ cp .versions.conf.example .versions.conf

$ cd .

$ touch config/settings.local.yml

$ chmod +x bin/*

$ ./bin/setup

$ rails s -b 0.0.0.0 -p 3000

```

* How to run test

```bash

$ RAILS_ENV=test rake db:environment:set && RAILS_ENV=test rake db:drop && RAILS_ENV=test rake db:create && RAILS_ENV=test rake db:schema:load

$ rspec # or guard

```

or

```bash

$ RAILS_ENV=test rake parallel:setup

$ rake parallel:spec

```
