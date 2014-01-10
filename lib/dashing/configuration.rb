require 'rufus-scheduler'
require 'connection_pool'

module Dashing
  class Configuration

    attr_accessor :messenger_class, :messenger_namespace, :messenger_url, :messenger_host, :messenger_port, :messenger_password
    attr_accessor :auth_token, :devise_allowed_models
    attr_accessor :jobs_path
    attr_accessor :default_dashboard, :dashboards_views_path, :dashboard_layout_path
    attr_accessor :widgets_views_path, :widgets_js_path, :widgets_css_path
    attr_accessor :engine_path, :scheduler

    # Deprecated. Keep for retro-compatibility only
    alias :redis_host         :messenger_host
    alias :redis_port         :messenger_port
    alias :redis_password     :messenger_password
    alias :redis_namespace    :messenger_namespace

    def initialize
      @engine_path            = '/dashing'
      @scheduler              = ::Rufus::Scheduler.new

      # Messenger (ex: redis)
      @messenger_class        = ::Dashing::Messengers::Redis
      @messenger_namespace    = 'dashing_events'
      @messenger_url          = 'redis://localhost:6379/'
      @messenger_host         = '127.0.0.1'
      @messenger_port         = '6379'
      @messenger_password     = nil

      # Authorization
      @auth_token             = nil
      @devise_allowed_models  = []

      # Jobs
      @jobs_path              = 'app/jobs/'

      # Dashboards
      @default_dashboard      = nil
      @dashboards_views_path  = 'app/views/dashing/dashboards/'
      @dashboard_layout_path  = 'dashing/dashboard'

      # Widgets
      @widgets_views_path     = 'app/views/dashing/widgets/'
      @widgets_js_path        = 'app/assets/javascripts/dashing'
      @widgets_css_path       = 'app/assets/stylesheets/dashing'
    end

    def messenger
      @messenger ||= ::ConnectionPool::Wrapper.new(size: request_thread_count, timeout: 3) { new_messenger_connection }
    end

    private

    def new_messenger_connection
      messenger_class.new(messenger_options)
    end

    def messenger_options
      {
        url: messenger_url
      }
    end

    def request_thread_count
      if defined?(::Puma) && ::Puma.respond_to?(:cli_config)
        ::Puma.cli_config.options.fetch(:max_threads, 5).to_i
      else
        5
      end
    end
  end
end
