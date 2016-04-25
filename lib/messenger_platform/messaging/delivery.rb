module MessengerPlatform
  module Messaging
    class Delivery

      attr_accessor :id, :recipient, :message
      attr_accessor :notification_type # must be of values: REGULAR, SILENT_PUSH, NO_PUSH

      def initialize(options = {})
        self.message ||= MessengerPlatform::Messaging::Message.new
        options.each { |key, value| instance_variable_set("@#{key}", value) }
        yield self if block_given?
      end

      def to_hash
        hash = {}
        hash.merge!(recipient: recipient.to_hash) if recipient
        hash.merge!(message: message.to_hash) if message
        hash.merge!(notification_type: notification_type) if notification_type
        hash.merge!(filedata: Faraday::UploadIO.new(message.attachment.file, message.attachment.file_type)) if message.attachment && message.attachment.file?
        hash
      end

    end 
  end
end
