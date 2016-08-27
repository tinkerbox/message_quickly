module MessageQuickly
  module Messaging
    class VideoAttachment < Attachment

      attr_accessor :url, :file, :file_type

      def initialize(params = {})
        params['type'] ||= 'video'
        super(params)
      end

      def file?
        file.present? && file_type.present?
      end

      def to_hash
        if file?
          { type: type, payload: { url: '' } } # cannot send empty hash
        else
          { type: type, payload: { url: url } }
        end
      end

    end
  end
end

# "attachments":[
#   {
#     "type":"video",
#     "payload":{
#       "url":"https://petersapparel.com/bin/clip.mp4"
#     }
#   }
# ]

# curl  \
#   -F recipient='{"id":"USER_ID"}' \
#   -F message='{"attachment":{"type":"video", "payload":{}}}' \
#   -F filedata=@/tmp/clip.mp4;type=video/mp4 \
#   "https://graph.facebook.com/v2.6/me/messages?access_token=PAGE_ACCESS_TOKEN"
