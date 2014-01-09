module Dashing
  class << self

    delegate :scheduler, :messenger, to: :config

    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end

    def first_dashboard
      files = Dir[Rails.root.join(config.dashboards_views_path, '*')].collect { |f| File.basename(f, '.*') }
      files.sort.first
    end

    def send_event(id, data)
      messenger.publish("#{Dashing.config.messenger_namespace}.create", data.merge(id: id, updatedAt: Time.now.utc.to_i).to_json)
    end

  end
end

begin
  require 'rails'
rescue LoadError
end

$stderr.puts <<-EOC if !defined?(Rails)
warning: no framework detected.

Your Gemfile might not be configured properly.
---- e.g. ----
Rails:
    gem 'dashing-rails'

EOC

require 'dashing/messenger'
require 'dashing/messengers/redis'
require 'dashing/configuration'

if defined? Rails
  require 'dashing/engine'
  require 'dashing/railtie'
end
