module MessengerPlatform
  module Api
    class Base

      protected

      def fb_version
        MessengerPlatform::FB_MESSENGER_VERSION
      end

      def page_access_token
        '123123'
      end

      def page_id
        '123123'
      end

      def endpoint
        "https://graph.facebook.com/#{}/#{page_id}/thread_settings?access_token=#{page_access_token}"
      end

      private

      def connection
        @connection = Faraday.new(:url => 'https://graph.facebook.com') do |faraday|
          faraday.request  :url_encoded # form-encode POST params
          faraday.response :logger # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

    end
  end
end
