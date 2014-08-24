require 'batman-rails'

module Dashing
  class Engine < ::Rails::Engine
    isolate_namespace Dashing

    paths['app/views'].unshift Dashing::Engine.root.join('app', 'views', 'dashing', 'widgets')
  end
end
