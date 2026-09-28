require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)
module CarePath
  class Application < Rails::Application
    config.load_defaults 7.2
    config.active_job.queue_adapter = :sidekiq
    config.generators.system_tests = nil
  end
end
