module Dashing
  class Engine < ::Rails::Engine
    isolate_namespace Dashing

    config.assets.paths << Dashing::Engine.root.join('app', 'assets', 'fonts')
    config.assets.paths << Dashing::Engine.root.join('app', 'views', 'dashing')

    initializer 'add dashing jobs to path' do
      Dir[Rails.root.join('app', 'jobs', '**', '*.rb')].each { |file| require file }
    end
  end
end
