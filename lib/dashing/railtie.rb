module Dashing
  class Railtie < ::Rails::Railtie

    initializer 'configure assets' do |app|
      app.configure do
        config.assets.paths.unshift       Dashing::Engine.root.join('vendor', 'assets', 'fonts', 'dashing')
        config.assets.paths.unshift       Dashing::Engine.root.join('vendor', 'assets', 'javascripts', 'dashing')
        config.assets.paths.unshift       Dashing::Engine.root.join('vendor', 'assets', 'stylesheets', 'dashing')
        config.assets.paths.unshift       Dashing.config.widgets_js_path
        config.assets.paths.unshift       Dashing.config.widgets_css_path

        config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
      end
    end

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
