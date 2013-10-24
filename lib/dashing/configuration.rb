require 'rufus-scheduler'
require 'redis'
require 'connection_pool'

module Dashing
  class Configuration

    attr_accessor :scheduler, :redis, :view_path, :jobs_path, :redis_namespace,
                  :engine_path, :dashboards_path, :dashboard_layout,
                  :widgets_path, :default_dashboard, :auth_token, :devise_allowed_models,
                  :redis_host, :redis_port, :redis_password

    def initialize
      @scheduler              = ::Rufus::Scheduler.new
      @redis_host             = '127.0.0.1'
      @redis_port             = '6379'
      @redis_password         = nil
      @redis                  = ::ConnectionPool::Wrapper.new(size: request_thread_count, timeout: 3) { ::Redis.new(host: redis_host, port: redis_port, password: redis_password) }
      @redis_namespace        = 'dashing_events'
      @view_path              = 'app/views/dashing/'
      @jobs_path              = 'app/jobs/'
      @engine_path            = '/dashing'
      @dashboards_path        = 'app/views/dashing/dashboards/'
      @dashboard_layout       = 'dashing/dashboard'
      @widgets_path           = 'app/views/dashing/widgets/'
      @default_dashboard      = nil
      @auth_token             = nil
      @devise_allowed_models  = []
    end

    private

    def request_thread_count
      if defined?(::Puma) && ::Puma.respond_to?(:cli_config)
        ::Puma.cli_config.options.fetch(:max_threads, 5).to_i
      else
        5
      end
    end
  end
end
