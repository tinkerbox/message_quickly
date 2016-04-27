require 'json'

module MessengerPlatform
  class CallbackRegistry

    module ClassMethods

      attr_reader :callbacks

      def register(klass)
        @callbacks[klass.new.callback_name] = klass.to_s
      end

      def process_request(raw)
        json = JSON.parse(raw)
        CallbackParser.new(json.deep_dup).parse do |event|
          @callbacks[event.webhook_name].constantize.new.run(event, json.deep_dup) if @callbacks[event.webhook_name]
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
