module MessengerPlatform
  module Messaging
    class Event

      attr_reader :entry, :sender, :recipient, :timestamp

      def initialize(params = {})
        @sender = Sender.new(params.delete("sender"))
        @recipient = Recipient.new(params.delete("recipient"))
        params.each { |key, value| instance_variable_set("@#{key}", value) }
      end

    end
  end
end
