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

    end
  end
end
