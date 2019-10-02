require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require 'carrierwave'
require 'carrierwave/orm/activerecord'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AutoAssistant
  class Application < Rails::Application
    config.load_defaults 5.2
    config.require_master_key = true
    config.generators.system_tests = nil
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :ru, :es]
    config.i18n.default_locale = :ru
    config.i18n.fallbacks = [I18n.default_locale]
    config.active_job.queue_adapter = :sidekiq
  end
end
