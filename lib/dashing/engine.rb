module Dashing
  class Engine < ::Rails::Engine
    isolate_namespace Dashing

    # TODO add to asset pipeline
    config.assets.paths << Dashing::Engine.root.join('app', 'assets', 'fonts')
    config.assets.paths << Dashing::Engine.root.join('app', 'views', 'dashing')
    config.assets.paths << Dashing.config.view_path

    initializer 'require dashing jobs' do
      Dir[Rails.root.join(Dashing.config.jobs_path, '**', '*.rb')].each { |file| require file }
    end
  end
end
