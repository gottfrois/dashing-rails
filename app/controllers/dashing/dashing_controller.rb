module Dashing
  class DashingController < ApplicationController
    include ActionController::Live

    before_filter :set_response_headers,  only: :events
    before_filter :check_dashbord_name,   only: :dashboard
    before_filter :check_widget_name,     only: :widget

    # rescue_from ActionView::MissingTemplate, with: :template_not_found

    respond_to :html

    def index
    end

    def events
      begin
        loop do
          out = Dashing.histories.map { |id,event| "data: #{event.to_json}\n\n" }
          response.stream.write out.join('')
          sleep 1
        end
      rescue IOError
        Rails.info 'Stream closed'
      ensure
        response.stream.close
      end
    end

    def dashboard
      render file: dashboard_path, layout: 'dashboard'
    end

    def widget
      render file: widget_path
    end

    private

    def template_not_found
      raise "Count not find template for #{params[:dashboard] || params[:widget]}"
    end

    def check_dashbord_name
      raise 'bad dashboard name' unless params[:dashboard] =~ /\A[a-zA-z0-9_\-]+\z/
    end

    def check_widget_name
      raise 'bad widget name' unless params[:widget] =~ /\A[a-zA-z0-9_\-]+\z/
    end

    def set_response_headers
      response.headers['Content-Type'] = 'text/event-stream'
    end

    def widget_path
      Rails.root.join('app', 'dashing', 'widgets', params[:widget])
    end

    def dashboard_path
      Rails.root.join('app', 'dashing', 'dashboards', params[:dashboard])
    end
  end
end
