module Dashing
  class EventsController < ApplicationController
    include ActionController::Live

    before_filter :set_response_headers, only: :index

    respond_to :html

    def index
      # begin
      #   loop do
      #     out = Dashing.histories.map do |id,event|
      #       "data: #{event.to_json}\n\n"
      #     end
      #     response.stream.write out.join('')
      #     sleep 1
      #   end
      # rescue IOError
      #   Rails.logger.info 'Stream closed'
      # ensure
      #   response.stream.close
      # end
    end

    def create
    end

    private

    def set_response_headers
      response.headers['Content-Type'] = 'text/event-stream'
    end

  end
end
