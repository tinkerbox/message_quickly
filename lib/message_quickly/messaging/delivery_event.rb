require "message_quickly/messaging/event"

module MessageQuickly
  module Messaging
    class DeliveryEvent < Event

      attr_reader :mids, :watermark, :seq

      def initialize(params = {})
        if params.include? :delivery
          @mids = params[:delivery][:mids]
          @watermark = params[:delivery][:watermark]
          @seq = params[:delivery][:seq]
          params.delete(:delivery)
        end
        super(params)
      end

      def webhook_name
        :message_deliveries
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
