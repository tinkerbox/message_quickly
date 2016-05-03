module MessageQuickly
  module Messaging
    class Event < Base

      attr_reader :entry, :sender, :recipient, :timestamp

      def initialize(params = {})
        @sender = Sender.new(params.delete("sender"))
        @recipient = Recipient.new(params.delete("recipient"))
        super(params)
      end

      protected

      def initialize_params(params)
        params.each { |key, value| instance_variable_set("@#{key}", value) }
      end

    end
  end
end
