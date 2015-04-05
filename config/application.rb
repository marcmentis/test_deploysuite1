require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)
# Get CONFIG variables differentially in dev/test and production environments
    # if Rails.env == 'test'
    if Rails.env == 'development' || Rails.env == 'test'
            CONFIG = {}

     # elsif Rails.env == 'development' || Rails.env == 'production'
    elsif Rails.env == 'production' 
    # Get paths to relevant encryption config files
        ymlfile_paths = YAML.load(File.read('/rails/.deploysuite/rails_ymlfiles.yml'))
        cipher_yml = ymlfile_paths[:paths][:cipher_yml]
        encrypted_db_yml = ymlfile_paths[:paths][:encrypted_db_yml]

        cipher_params = YAML.load(File.read(cipher_yml))
        key = cipher_params[:key]
        iv = cipher_params[:iv]
        alg =cipher_params[:alg]

        # Decode encoded db file into temp application2.yml
        decipher = OpenSSL::Cipher.new(alg)
        decipher.decrypt
        decipher.key = key
        decipher.iv = iv
        File.open(File.expand_path('../application2.yml', __FILE__), 'wb') do |dec|
            File.open(encrypted_db_yml, 'rb') do |f|
                loop do
                    r = f.read(4096)
                    break unless r
                    decoded = decipher.update(r)
                    dec << decoded
                end
            end

            dec << decipher.final
        end

    # Create CONFIG[:foo] constants from temp application2.yml
        CONFIG = YAML.load(File.read(File.expand_path('../application2.yml', __FILE__)))
        CONFIG.merge! CONFIG.fetch(Rails.env, {})
        CONFIG.symbolize_keys!

    # Delete temp application2.yml
        File.delete(File.expand_path('../application2.yml', __FILE__)) 
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
