require "message_quickly/messaging/event"

module MessageQuickly
  module Messaging
    class OptinEvent < Event

      attr_reader :ref

      def initialize(params = {})
        if params.include? :optin
          @ref = params[:optin][:ref]
          params.delete(:optin)
        end
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
