module MessengerPlatform
  module Messaging
    class User < Base

      attr_reader :id, :first_name, :last_name, :profile_pic

      def first_name
        pull_profile if @first_name.nil?
      end

      def last_name
        pull_profile if @last_name.nil?
      end

      private

      def pull_profile
        
      end

    end
  end
end
