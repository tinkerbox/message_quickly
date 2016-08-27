require "message_quickly/messaging/event"

module MessageQuickly
  module Messaging
    class MessageEvent < Event

      attr_reader :mid, :seq, :text, :attachments, :quick_reply

      def initialize(params = {})

        @attachments = params[:message].delete(:attachments).collect { |attachment_params| Attachment.new(attachment_params) } if params.dig(:message, :attachments)
        @attachments ||= []

        @quick_reply = QuickReply.new(params[:message][:quick_reply]) if params.dig(:message, :quick_reply)

        if params.include? :message
          @mid = params[:message][:mid]
          @seq = params[:message][:seq]
          @is_echo = params[:message][:is_echo]
          @text = params[:message][:text]
          params.delete(:message)
        end

        super(params)

      end

      def webhook_name
        :messages
      end

      def is_echo?
        @is_echo
      end

    end
  end
end

# message with attachment

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

# message with quick reply

# {
#   "sender":{
#     "id":"USER_ID"
#   },
#   "recipient":{
#     "id":"PAGE_ID"
#   },
#   "timestamp":1458692752478,
#   "message":{
#     "mid":"mid.1457764197618:41d102a3e1ae206a38",
#     "seq":73,
#     "text":"hello, world!",
#     "quick_reply": {
#       "payload": "DEVELOPER_DEFINED_PAYLOAD"
#     }
#   }
# }
