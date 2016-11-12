module MessageQuickly
  module Messaging
    class QuickReply < Base

      attr_accessor :content_type, :title, :payload, :image_url

      def initialize(params = {})
        params['content_type'] ||= 'text'
        super(params)
      end

      def to_hash
        { content_type: content_type, title: title, payload: payload, image_url: image_url }
      end

    end
  end
end

# "message":{
#   "text":"Pick a color:",
#   "quick_replies":[
#     {
#       "content_type":"text",
#       "title":"Red",
#       "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED"
#     },
#     {
#       "content_type":"text",
#       "title":"Green",
#       "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_GREEN"
#     }
#   ]
# }
