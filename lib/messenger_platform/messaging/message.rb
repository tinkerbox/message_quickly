module MessengerPlatform
  module Messaging
    class Message

      attr_accessor :text, :attachment

      # REGULAR, SILENT_PUSH, NO_PUSH

      def initialize(options = {})
        options.each { |key, value| instance_variable_set("@#{key}", value) }
        yield self if block_given?
      end

    end
  end
end
