require 'redis'

module Dashing
  module Messengers
    class Redis < ::Dashing::Messenger

      def subscribe(*args, &block)
        messenger.psubscribe(*args, &block)
      end

      def publish(*args)
        messenger.publish(*args)
      end

      def stream(response)
        subscribe(namespace) do |on|
          on.pmessage do |pattern, event, data|
            response.stream.write("data: #{data}\n\n")
          end
        end
      end

      def quit
        messenger.quit
      end

      def namespace
        "#{Dashing.config.messenger_namespace}.*"
      end

      private

      def messenger_class
        ::Redis
      end

    end
  end
end
