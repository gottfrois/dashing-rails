module Dashing
  class Engine < ::Rails::Engine
    isolate_namespace Dashing

    config.assets.paths << 'app/dashing/'

    initializer 'add dashing jobs to path' do
      Dir[Rails.root.join('dashing', 'jobs', '**', '*.rb')].each { |file| require file }
    end
  end
end
