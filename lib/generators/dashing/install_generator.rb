module Dashing
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a Dashing initializer for your application.'

      def install
        route 'mount Dashing::Engine, at: Dashing.config.engine_path'
      end

      def copy_initializer
        template 'initializer.rb', 'config/initializers/dashing.rb'
      end

    end
  end
end
