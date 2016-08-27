require "message_quickly/messaging/event"

module MessageQuickly
  module Messaging
    class ReadEvent < Event

      attr_reader :watermark, :seq

      def initialize(params = {})
        if params.include? :read
          @watermark = params[:read][:watermark]
          @seq = params[:read][:seq]
          params.delete(:read)
        end
        super(params)
      end

      def webhook_name
        :message_reads
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
#                "timestamp":1458668856463,
#                "read":{
#                   "watermark":1458668856253,
#                   "seq":38
#                }
#             }
#          ]
#       }
#    ]
# }
