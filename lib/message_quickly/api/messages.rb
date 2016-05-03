module MessageQuickly
  module Api
    class Messages < Base

      def self.create(recipient = nil, delivery = nil, &block)
        # curl -X POST -H "Content-Type: application/json" -d '{
        #   "recipient":{
        #       "id":"USER_ID"
        #   },
        #   "message":{
        #       "text":"hello, world!"
        #   }
        # }' "https://graph.facebook.com/v2.6/me/messages?access_token=PAGE_ACCESS_TOKEN"

        # {
        #   "recipient_id": "1008372609250235",
        #   "message_id": "mid.1456970487936:c34767dfe57ee6e339"
        # }
        Messages.new.create(recipient, delivery, &block)
      end

      def create(recipient = nil, delivery = nil, &block)
        delivery ||= MessageQuickly::Messaging::Delivery.new(recipient: recipient)
        block.call(delivery.message) if block
        delivery.id = perform_call(delivery.to_hash)
        delivery
      end

      def self.create_from_hash(hash)
        Messages.new.create_from_hash(hash)
      end

      def create_from_hash(hash)
        perform_call(hash)
      end

      private

      def perform_call(hash)
        json = @client.post("me/messages", hash)
        json['message_id']
      end

    end
  end
end
