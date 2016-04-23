module MessengerPlatform
  module Messaging
    class ImageAttachment < Attachment

      attr_accessor :url

      def initialize(params = {})
        params['type'] ||= 'image'
        super(params)
      end

      def to_hash
        { type: type, payload: { url: url } }
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
