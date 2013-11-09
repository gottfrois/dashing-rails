module Dashing
  class Railtie < ::Rails::Railtie
    initializer 'require dashing jobs' do
      Dir[Rails.root.join(Dashing.config.jobs_path, '**', '*.rb')].each { |file| require file }
    end
  end
end
