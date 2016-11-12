module MessageQuickly
  module Messaging
    class ShareButton < Base

      attr_accessor :type

      def initialize(params = {})
        params['type'] ||= 'element_share'
        super(params)
      end

      def to_hash
        { type: type }
      end

    end
  end
end

# {
#   "type":"element_share"
# }

# https://developers.facebook.com/docs/messenger-platform/send-api-reference/share-button
