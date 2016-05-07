# basic
require 'capybara/rspec'

# driver
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist

# Capybara.javascript_driver = :selenium
# Capybara.default_driver = :selenium

