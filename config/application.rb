require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Forums
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # add custom validators path
		config.autoload_paths += %W["#{config.root}/app/validators/"]

		config.time_zone = 'Sydney'
 		config.active_record.default_timezone = :local

 		config.active_job.queue_adapter = :delayed_job
  end
end
