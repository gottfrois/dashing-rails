module Dashing
  module Generators
    class WidgetGenerator < ::Rails::Generators::NamedBase

      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a new Dashing widget.'

      def widget
        template 'widgets/new.html',    "#{Dashing.config.widgets_views_path}#{file_name}.html"
        template 'widgets/new.scss',    "#{Dashing.config.widgets_css_path}/widgets/#{file_name}.scss"
        template 'widgets/new.coffee',  "#{Dashing.config.widgets_js_path}/widgets/#{file_name}.coffee"
      end

    end
  end
end
