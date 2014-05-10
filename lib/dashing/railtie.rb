module Dashing
  class Railtie < ::Rails::Railtie
    initializer 'require dashing jobs' do
      Dir[Dashing.config.jobs_path.call.join('**', '*.rb')].each { |file| require file }
    end

    initializer 'fix redis child connection' do
      if defined?(::PhusionPassenger)
        ::PhusionPassenger.on_event(:starting_worker_process) do |forked|
          if forked
            ::Dashing.redis.client.disconnect
            ::Dashing.redis.client.connect
          end
        end
      end
    end
  end
end
