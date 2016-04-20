require 'json'

# TODO: turn into singleton

module MessengerPlatform
  class CallbackRegistry

    @callbacks = {}

    def register(webhook_name, &block)
      @callbacks[webhook_name.to_sym] = block
    end

    def deregister(webhook_name)
      @callbacks.delete(webhook_name.to_sym)
    end

    def process_request(raw)
      json = JSON.parse(raw)
      CallbackParser.new(json).parse do |webhook, event|
        @callbacks[webhook].call(event)
      end
    end

  end
end
