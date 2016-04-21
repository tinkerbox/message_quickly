require "messenger_platform/messaging/event"

module MessengerPlatform
  module Messaging
    class DeliveryEvent < Event

      attr_reader :mids, :watermark, :seq

      def initialize(params = {})
        initialize_params(params['delivery'])
        super(params)
      end

      def webhook_name
        :message_deliveries
      end

      private

      def initialize_params(messaging_params)
        @mids = messaging_params['mids']
        @watermark = messaging_params['watermark']
        @seq = messaging_params['seq']
      end

    end
  end
end

# {
#    "object":"page",
#    "entry":[
#       {
#          "id":PAGE_ID,
#          "time":1458668856451,
#          "messaging":[
#             {
#                "sender":{
#                   "id":USER_ID
#                },
#                "recipient":{
#                   "id":PAGE_ID
#                },
#                "delivery":{
#                   "mids":[
#                      "mid.1458668856218:ed81099e15d3f4f233"
#                   ],
#                   "watermark":1458668856253,
#                   "seq":37
#                }
#             }
#          ]
#       }
#    ]
# }
