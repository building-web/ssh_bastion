require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SshBastion
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    Config::Integration::Rails::Railtie.preload
    if ENV['VAGRANT'].to_s == '1'
      Settings.add_source!(Rails.root.join('config', 'settings', "vagrant_#{Rails.env}.local.yml").to_s)
      Settings.reload!
    end

    config.time_zone = Settings.time_zone

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:en, 'zh-CN']

    config.generators do |g|
      g.assets false
      g.helper false
    end

    config.action_mailer.default_url_options = { host: Settings.web_url.host, port: Settings.web_url.port }

  end
end
