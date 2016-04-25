require "faraday"

module MessengerPlatform
  module Api
    class Base

      def self.client
        @@client ||= Client.new do |client|
          client.page_access_token = ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN']
          client.page_id = ENV['FACEBOOK_MESSENGER_PAGE_ID']
        end
      end

      def initialize(override_client = nil)
        @client = override_client || self.class.client
      end

    end
  end
end
