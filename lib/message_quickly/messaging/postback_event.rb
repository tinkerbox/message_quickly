require "message_quickly/messaging/event"

module MessageQuickly
  module Messaging
    class PostbackEvent < Event

      attr_reader :payload

      def initialize(params = {})
        initialize_params(params['postback'])
        super(params)
      end

      def webhook_name
        :messaging_postbacks
      end

    end
  end
end

# {
#   "object":"page",
#   "entry":[
#     {
#       "id":PAGE_ID,
#       "time":1458692752478,
#       "messaging":[
#         {
#           "sender":{
#             "id":USER_ID
#           },
#           "recipient":{
#             "id":PAGE_ID
#           },
#           "timestamp":1458692752478,
#           "postback":{
#             "payload":"USER_DEFINED_PAYLOAD"
#           }
#         }
#       ]
#     }
#   ]
# }
