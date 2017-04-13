require_relative 'boot'

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

module Fred654
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    config.i18n.default_locale = :ru
    config.autoload_paths += Dir[ Rails.root.join('app', 'models', "commands") ]
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* )
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
  

  # ======================================================
  #  Mailer settings
  # ======================================================
  config.action_mailer.default_url_options = { host: Settings.mailer.host }

  if Settings.mailer.service == 'smtp'
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.raise_delivery_errors = true
  
    config.action_mailer.smtp_settings = {
        address: Settings.mailer.smtp.address,
        domain:  Settings.mailer.smtp.domain,
        port:    Settings.mailer.smtp.port,
      
        user_name: Settings.mailer.smtp.email,
        password:  Settings.mailer.smtp.password,
      
        authentication: Settings.mailer.smtp.authentication,
        enable_starttls_auto: true
    }
  elsif Settings.mailer.service == 'sandmail'
    config.action_mailer.raise_delivery_errors = true
  
    config.action_mailer.sendmail_settings = {
        location:  Settings.mailer.sandmail.location,
        arguments: Settings.mailer.sandmail.arguments
    }
  else
    config.action_mailer.delivery_method = :test
    config.action_mailer.raise_delivery_errors = false
  end
  # ======================================================
  #  ~ Mailer settings
  # ======================================================
  end
end
