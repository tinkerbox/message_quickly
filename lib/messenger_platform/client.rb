module MessengerPlatform
  class Client

    attr_reader :callback_registry

    def initialize
      @callback_registry = CallbackRegistry.new
    end

  end
end
