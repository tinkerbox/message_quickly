module MessengerPlatform
  module Api
    class Messages < Base

      def self.create(delivery)
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

        request_string = "me/messages"
        json = client.post(request_string, { recipient: { id: delivery.recipient.id }, message: { text: delivery.message.text } })
        delivery.id = json['message_id']
        delivery
      end

      private

    end
  end
end
