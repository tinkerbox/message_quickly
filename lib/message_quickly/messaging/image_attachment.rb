module MessageQuickly
  module Messaging
    class ImageAttachment < Attachment

      attr_accessor :url, :file, :file_type

      def initialize(params = {})
        params['type'] ||= 'image'
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
#     "type":"image",
#     "payload":{
#       "url":"IMAGE_URL"
#     }
#   }
# ]

# curl  \
#   -F recipient='{"id":"USER_ID"}' \
#   -F message='{"attachment":{"type":"image", "payload":{}}}' \
#   -F filedata=@/tmp/testpng.png \
#   "https://graph.facebook.com/v2.6/me/messages?access_token=PAGE_ACCESS_TOKEN"
