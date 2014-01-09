module Dashing
  class Messenger

    attr_reader :options, :messenger

    def initialize(options = {})
      @options    = options
      @messenger  = messenger_class.new(options)
    end

    def subscribe(channel = '')
      raise 'you must implement this public method'
    end

    def publish(channel, data)
      raise 'you must implement this public method'
    end

    def quit
      raise 'you must implement this public method'
    end

    def namespace
      "#{Dashing.config.messenger_namespace}.create"
    end

    private

    def messenger_class
      raise 'you must implement this private method'
    end

  end
end
