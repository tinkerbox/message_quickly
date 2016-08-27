module MessageQuickly
  module Messaging
    class AccountUnlinkButton < Button

      attr_accessor :url

      def initialize(params = {})
        params['type'] ||= 'account_unlink'
        super(params)
      end

      def to_hash
        { type: type }
      end

    end
  end
end

# "buttons": [{
#   "type": "account_link"
# }]
