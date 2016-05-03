require 'json'

module MessageQuickly
  class CallbackRegistry

    module ClassMethods

      attr_reader :callbacks

      def register(klass)
        @callbacks[klass.new.callback_name] = klass.to_s
      end

      def handler_for(webhook_name)
        @callbacks[webhook_name]&.constantize
      end

    end

    extend ClassMethods

  end

  CallbackRegistry.class_eval do
    @callbacks = {}
  end

end
