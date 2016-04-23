module MessengerPlatform
  module Messaging
    class Button

      attr_accessor :type, :title

      def initialize(params = {})
        params.each { |key, value| instance_variable_set("@#{key}", value) }
      end

    end
  end
end