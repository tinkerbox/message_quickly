require "message_quickly/messaging/event"

module MessageQuickly
  module Messaging
    class MessageEvent < Event

      attr_reader :mid, :seq, :text, :attachments

      def initialize(params = {})

        @attachments = params[:message].delete(:attachments).collect { |attachment_params| Attachment.new(attachment_params) } if params.dig(:message, :attachments)
        @attachments ||= []

        if params.include? :message
          @mid = params[:message][:mid]
          @seq = params[:message][:seq]
          @text = params[:message][:text]
          params.delete(:message)
        end

        super(params)

      end

      def webhook_name
        :messages
      end

      protected

      def initialize_params(params)
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
