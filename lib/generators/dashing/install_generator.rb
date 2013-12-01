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

      def copy_layout
        template 'layouts/dashboard.html.erb', 'app/views/layouts/dashing/dashboard.html.erb'
      end

      def copy_dashboard
        template 'dashboards/sample.html.erb', 'app/views/dashing/dashboards/sample.html.erb'
      end

      def copy_widget_manifests
        template 'widgets/index.css', 'app/assets/stylesheets/dashing/widgets/index.css'
        template 'widgets/index.js', 'app/assets/javascripts/dashing/widgets/index.js'
      end

      def copy_job
        template 'jobs/sample.rb', 'app/jobs/sample.rb'
      end

    end
  end
end
