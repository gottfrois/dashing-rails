module Dashing
  class EventsController < ApplicationController
    include ActionController::Live

    respond_to :html

    def index
      response.headers['Content-Type']      = 'text/event-stream'
      response.headers['X-Accel-Buffering'] = 'no'

      messenger = Dashing.messenger
      messenger.stream(response)
    rescue IOError
      logger.info "[Dashing][#{Time.now.utc.to_s}] Stream closed"
    ensure
      messenger.quit
      response.stream.close
    end

  end
end
