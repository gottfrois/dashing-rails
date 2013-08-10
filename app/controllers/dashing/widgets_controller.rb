module Dashing
  class WidgetsController < ApplicationController

    respond_to :html

    before_filter :check_widget_name,   only: :show
    before_filter :prepend_view_paths,  only: :show

    rescue_from ActionView::MissingTemplate, with: :template_not_found

    def show
      render file: withdet_path
    end

    private

    def check_widget_name
      raise 'bad widget name' unless params[:name] =~ /\A[a-zA-z0-9_\-]+\z/
    end

    def withdet_path
      "#{params[:name]}/#{params[:name]}"
    end

    def prepend_view_paths
      prepend_view_path engine_view_path
      prepend_view_path main_app_view_path
    end

    def engine_view_path
      Dashing::Engine.root.join('app', 'views', 'dashing', 'default_widgets')
    end

    def main_app_view_path
      Rails.root.join('app', 'views', 'dashing', 'widgets')
    end

    def template_not_found
      raise "Count not find template for widget #{params[:name]}. Define your widget in #{main_app_view_path}"
    end

  end
end
