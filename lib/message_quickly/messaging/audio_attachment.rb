module MessageQuickly
  module Messaging
    class AudioAttachment < Attachment

      attr_accessor :url, :file, :file_type

      def initialize(params = {})
        params['type'] ||= 'audio'
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
#     "type":"audio",
#     "payload":{
#       "url":"https://petersapparel.com/bin/clip.mp3"
#     }
#   }
# ]

# curl  \
#   -F recipient='{"id":"USER_ID"}' \
#   -F message='{"attachment":{"type":"audio", "payload":{}}}' \
#   -F filedata=@/tmp/clip.mp3;type=audio/mp3 \
#   "https://graph.facebook.com/v2.6/me/messages?access_token=PAGE_ACCESS_TOKEN"
