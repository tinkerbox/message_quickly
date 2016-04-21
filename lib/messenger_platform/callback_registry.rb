require 'json'

module MessengerPlatform
  class CallbackRegistry

    module ClassMethods

      attr_reader :callbacks

      def register(klass)
        callback = klass.new
        @callbacks[callback.callback_name] = callback.method(:run)
      end

      def find_by_callback_name(callback_name)
        @callbacks[callback_name]
      end

      def process_request(raw)
        json = JSON.parse(raw)
        CallbackParser.new(json).parse do |event|
          @callbacks[event.webhook_name].call(event)
        end
        true
      rescue JSON::ParserError => e
        false
      end

    end

    extend ClassMethods

  end

  CallbackRegistry.class_eval do
    @callbacks = {}
  end

end
