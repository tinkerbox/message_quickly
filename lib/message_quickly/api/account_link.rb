module MessageQuickly
  module Api
    class AccountLink < Base

      def self.page_scoped_id(account_linking_token)
        # curl -X GET "https://graph.facebook.com/v2.6/me?access_token=PAGE_ACCESS_TOKEN \
        #   &fields=recipient \
        #   &account_linking_token=ACCOUNT_LINKING_TOKEN"

        # {
        #   "id": "PAGE_ID",
        #   "recipient": "PSID"
        # }
        AccountLink.new.page_scoped_id(account_linking_token)
      end

      def page_scoped_id(account_linking_token)
        json = @client.get("me", { fields: 'recipient', account_linking_token: account_linking_token })
        json['recipient']
      end

      def self.unlink_account(page_scoped_id)
        # curl -X POST -H "Content-Type: application/json" -d '{
        #    "psid":"PSID"
        # }' "https://graph.facebook.com/v2.6/me/unlink_accounts?access_token=PAGE_ACCESS_TOKEN"

        # {
        #   "result": "unlink account success"
        # }
        AccountLink.new.unlink_account(page_scoped_id)
      end

      def unlink_account(page_scoped_id)
        json = @client.post("me/unlink_accounts", { psid: page_scoped_id })
        json['result'] == "unlink account success"
      end

    end
  end
end

