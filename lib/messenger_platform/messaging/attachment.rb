module MessengerPlatform
  module Messaging
    class Attachment

      attr_reader :type, :payload

      def initialize(params = {})
        @type = params['type']
        @payload = params['payload']
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
