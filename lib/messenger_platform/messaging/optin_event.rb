require "messenger_platform/messaging/event"

module MessengerPlatform
  module Messaging
    class OptinEvent < Event

      attr_reader :ref

      def initialize(params = {})
        initialize_params(params['optin'])
        super(params)
      end

      def webhook_name
        :messaging_optins
      end

    end
  end
end

# {
#   "object":"page",
#   "entry":[
#     {
#       "id":PAGE_ID,
#       "time":12341,
#       "messaging":[
#         {
#           "sender":{
#             "id":USER_ID
#           },
#           "recipient":{
#             "id":PAGE_ID
#           },
#           "timestamp":1234567890,
#           "optin":{
#             "ref":"PASS_THROUGH_PARAM"
#           }
#         }
#       ]
#     }
#   ]
# }
