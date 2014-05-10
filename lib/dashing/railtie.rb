module Dashing
  class Railtie < ::Rails::Railtie
    initializer 'require dashing jobs' do
      Dir[Dashing.config.jobs_path.call.join('**', '*.rb')].each { |file| require file }
    end
  end
end
