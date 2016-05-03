module MessageQuickly
  module Api
    class UserProfile < Base

      def self.find(id)
        # curl -X GET "https://graph.facebook.com/v2.6/<USER_ID>?fields=first_name,last_name,profile_pic&access_token=<PAGE_ACCESS_TOKEN>"
        # {
        #   "first_name": "Peter",
        #   "last_name": "Chang",
        #   "profile_pic": "https://fbcdn-profile-a.akamaihd.net/hprofile...70ec9c19b18"
        # }
        UserProfile.new.find(id)
      end

      def find(id)
        json = @client.get(id, { fields: 'first_name,last_name,profile_pic' })
        Messaging::User.new(json)
      end

    end
  end
end
