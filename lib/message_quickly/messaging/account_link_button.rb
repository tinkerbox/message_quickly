module MessageQuickly
  module Messaging
    class AccountLinkButton < Button

      attr_accessor :url

      def initialize(params = {})
        params['type'] ||= 'account_link'
        super(params)
      end

      def to_hash
        { type: type, url: url }
      end

    end
  end
end

# "buttons": [{
#   "type": "account_link",
#   "url": "https://www.example.com/oauth/authorize"
# }]
