module MessengerPlatform
  module Messaging
    class Event

      attr_reader :entry, :sender, :recipient, :timestamp

      def initialize(entry, sender, recipient, timestamp)
        @entry = entry
        @sender = sender
        @recipient = recipient
        @timestamp = timestamp
      end

    end
  end
end
