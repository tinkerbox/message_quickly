module MessageQuickly
  module Messaging
    class Event < Base

      attr_reader :entry, :sender, :recipient, :timestamp

      def initialize(params = {})
        params.deep_symbolize_keys!
        @sender = Sender.new(params.delete(:sender)) if params.include?(:sender)
        @recipient = Recipient.new(params.delete(:recipient)) if params.include?(:recipient)
        super
      end

    end
  end
end
