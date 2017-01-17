module Dashing
  class DashboardsController < ApplicationController

    before_action :check_dashboard_name, only: :show

    rescue_from ActionView::MissingTemplate, with: :template_not_found

    def index
      render file: dashboard_path(Dashing.config.default_dashboard || Dashing.first_dashboard || ''), layout: Dashing.config.dashboard_layout_path
    end

    def show
      render file: dashboard_path(params[:name]), layout: Dashing.config.dashboard_layout_path
    end

    private

    def check_dashboard_name
      raise 'bad dashboard name' unless params[:name] =~ /\A[a-zA-z0-9_\-]+\z/
    end

    def dashboard_path(name)
      Dashing.config.dashboards_views_path.join(name)
    end

    def template_not_found
      raise "Count not find template for dashboard '#{params[:name]}'. Define your dashboard in #{dashboard_path('')}"
    end

  end
end
