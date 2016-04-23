require "messenger_platform/messaging/event"

module MessengerPlatform
  module Messaging
    class MessageEvent < Event

      attr_reader :mid, :seq, :text, :attachments

      def initialize(params = {})
        initialize_params(params['message'])
        super(params)
      end

      def webhook_name
        :messages
      end

      protected

      def initialize_params(params)
        @attachments = params.delete('attachments').collect { |attachment_params| Attachment.new(attachment_params) } if params['attachments']
        super(params)
      end

    end
  end
end

# {
#   "object":"page",
#   "entry":[
#     {
#       "id":PAGE_ID,
#       "time":1458696618911,
#       "messaging":[
#         {
#           "sender":{
#             "id":USER_ID
#           },
#           "recipient":{
#             "id":PAGE_ID
#           },
#           "timestamp":1458696618268,
#           "message":{
#             "mid":"mid.1458696618141:b4ef9d19ec21086067",
#             "seq":51,
#             "attachments":[
#               {
#                 "type":"image",
#                 "payload":{
#                   "url":"IMAGE_URL"
#                 }
#               }
#             ]
#           }
#         }
#       ]
#     }
#   ]
# }
