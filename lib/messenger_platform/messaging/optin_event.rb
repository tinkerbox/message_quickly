module MessengerPlatform
  module Messaging
    class OptinEvent < Event

      attr_reader :ref

      def initialize(params = {})
        initialize_params(params[:messaging])
        super(params[:entry], params[:sender], params[:recipient], params[:timestamp])
      end

      private

      def initialize_params(messaging_params)
        @ref = params['ref']
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
