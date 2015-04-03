require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)
# Get CONFIG variables differentially in dev/test and production environments
# if Rails.env == 'test'
    if Rails.env == 'development' || Rails.env == 'test'
        # Create CONFIG[:foo] constants from application.yml file
            # CONFIG = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
            # CONFIG.merge! CONFIG.fetch(Rails.env, {})
            # CONFIG.symbolize_keys!

    # elsif Rails.env == 'development' || Rails.env == 'production'
    elsif Rails.env == 'production' 

        # Create CONFIG[:foo] constants from application.yml file
            CONFIG = YAML.load(File.read('/rails/temp_db_config.yml'))
            CONFIG.merge! CONFIG.fetch(Rails.env, {})
            CONFIG.symbolize_keys!

        # Delete the temporary application.yml file
            # File.delete('/rails/temp_db_config.yml')  
    end

module TestDeploysuite1
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
