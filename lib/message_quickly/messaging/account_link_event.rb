require "message_quickly/messaging/event"

module MessageQuickly
  module Messaging
    class AccountLinkEvent < Event

      attr_reader :status, :authorization_code

      def initialize(params = {})

        if params.include? :account_linking
          @status = params[:account_linking][:status]
          @authorization_code = params[:account_linking][:authorization_code]
          params.delete(:account_linking)
        end

        super(params)

      end

      def webhook_name
        :account_linking
      end

    end
  end
end

# {
#   "sender":{
#     "id":"USER_ID"
#   },
#   "recipient":{
#     "id":"PAGE_ID"
#   },
#   "timestamp":1234567890,
#   "account_linking":{
#     "status":"linked",
#     "authorization_code":"PASS_THROUGH_AUTHORIZATION_CODE"
#   }
# }
