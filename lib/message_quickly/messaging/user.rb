module MessageQuickly
  module Messaging
    class User < Base

      attr_reader :id, :first_name, :last_name, :profile_pic, :locale, :timezone, :gender

      def first_name
        @first_name || user_profile.first_name
      end

      def last_name
        @last_name || user_profile.last_name
      end

      private

      def user_profile
        @user_profile ||= MessageQuickly::Api::UserProfile.find(id)
      end

    end
  end
end
