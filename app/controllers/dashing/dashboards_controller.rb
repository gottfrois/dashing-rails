module Dashing
  class DashboardsController < ApplicationController

    before_filter :check_dashboard_name, only: :show

    rescue_from ActionView::MissingTemplate, with: :template_not_found

    def index
    end

    def show
      render file: dashboard_path, layout: Dashing.config.dashboard_layout
    end

    private

    def check_dashboard_name
      raise 'bad dashboard name' unless params[:name] =~ /\A[a-zA-z0-9_\-]+\z/
    end

    def dashboard_path
      Rails.root.join(Dashing.config.dashboards_path, params[:name])
    end

    def template_not_found
      raise "Count not find template for dashboard #{params[:name]}. Define your dashboard in #{dashboard_path}"
    end

  end
end
