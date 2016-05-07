if Rails.env.production? or Rails.env.staging?

  require Rails.root.join("db/seeds_basic").to_s

else

  require 'database_cleaner'
  require 'factory_girl_rails'
  require 'ffaker'

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  require Rails.root.join("db/seeds_basic").to_s
  require Rails.root.join("db/seeds_development").to_s

end
