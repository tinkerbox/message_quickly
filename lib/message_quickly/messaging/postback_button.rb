module MessageQuickly
  module Messaging
    class PostbackButton < Button

      attr_accessor :payload

      def initialize(params = {})
        params['type'] ||= 'postback'
        super(params)
      end

      def to_hash
        { type: type, title: title, payload: payload }
      end

    end
  end
end

# {
#   "type":"postback",
#   "title":"Start Chatting",
#   "payload":"USER_DEFINED_PAYLOAD"
# }
