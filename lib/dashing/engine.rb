module Dashing
  class Engine < ::Rails::Engine
    isolate_namespace Dashing

    config.assets.paths.unshift       Dashing::Engine.root.join('vendor', 'assets', 'fonts', 'dashing')
    config.assets.paths.unshift       Dashing::Engine.root.join('vendor', 'assets', 'javascripts', 'dashing')
    config.assets.paths.unshift       Dashing::Engine.root.join('vendor', 'assets', 'stylesheets', 'dashing')
    config.assets.paths.unshift       Dashing.config.widgets_js_path
    config.assets.paths.unshift       Dashing.config.widgets_css_path

    config.paths['app/views'].unshift Dashing::Engine.root.join('app', 'views', 'dashing', 'widgets')

    initializer 'require dashing jobs' do
      Dir[Rails.root.join(Dashing.config.jobs_path, '**', '*.rb')].each { |file| require file }
    end
  end
end
