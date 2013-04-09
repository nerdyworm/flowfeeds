require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Flowfeeds
  class Application < Rails::Application
    config.autoload_paths += %W(
      #{config.root}/app/workers/
      #{config.root}/lib/
    )

    config.assets.precompile += %w(
      admin.js
      admin.css
    )
  end
end
