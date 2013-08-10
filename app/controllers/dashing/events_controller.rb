module Dashing
  class EventsController < ApplicationController
    include ActionController::Live

    respond_to :html

    def index
      response.headers['Content-Type'] = 'text/event-stream'

      redis = Redis.new
      redis.psubscribe("#{Dashing.config.redis_namespace}.*") do |on|
        on.pmessage do |pattern, event, data|
          response.stream.write("data: #{data}\n\n")
        end
      end
    rescue IOError
      logger.info "[Dashing][#{Time.now.utc.to_s}] Stream closed"
    ensure
      redis.quit
      response.stream.close
    end

    def create
      response.headers['Content-Type'] = 'text/javascript'

      Dashing.redis.publish("#{Dashing.config.redis_namespace}.create", event_params[:data].to_json)
    end

    private

    def event_params
      params.require(:event).permit(:data)
    end

  end
end
