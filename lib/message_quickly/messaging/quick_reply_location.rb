module MessageQuickly
  module Messaging
    class QuickReplyLocation < QuickReply

      def initialize(params = {})
        params['content_type'] ||= 'location'
        super(params)
      end

      def to_hash
        { content_type: content_type }
      end

    end
  end
end

# {
#   "recipient":{
#     "id":"USER_ID"
#   },
#   "message":{
#     "text":"Please share your location:",
#     "quick_replies":[
#       {
#         "content_type":"location",
#       }
#     ]
#   }
# }
