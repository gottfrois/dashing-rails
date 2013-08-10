module Dashing
  class << self

    delegate :scheduler, :redis, to: :config

    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config
    end

    def send_event(id, data)
      redis.publish("#{Dashing.config.redis_namespace}.create", data.merge(id: id, updatedAt: Time.now.utc.to_i).to_json)
    end

  end
end

require 'dashing/configuration'
require 'dashing/engine'
