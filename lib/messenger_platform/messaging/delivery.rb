module MessengerPlatform
  module Messaging
    class Delivery

      attr_accessor :id, :recipient, :message, :notification_type

      # REGULAR, SILENT_PUSH, NO_PUSH

      def initialize(options = {})
        options.each { |key, value| instance_variable_set("@#{key}", value) }
        yield self if block_given?
      end

      def build_message
        self.message = MessengerPlatform::Messaging::Message.new
        yield message if block_given?
      end

      def to_hash
        hash = { recipient: { id: recipient.id } }
        hash.merge(message: message.to_hash) if message
      end

    end
  end
end
