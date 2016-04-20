require "faraday"

module MessengerPlatform
  module Api
    class Client

      attr_accessor :page_access_token, :page_id

      def initialize(options = {})
        options.each { |key, value| instance_variable_set("@#{key}", value) }
        yield self if block_given?
      end

      def get(request_string, params = {})
        params[:access_token] = page_access_token
        response = connection.get request_string, params
        parse_json(response)
      end

      def post(request_string, params = {})
        params[:access_token] = page_access_token
        response = connection.post request_string do |request|
          request.headers['Content-Type'] = 'application/json'
          request.body = JSON.generate(params)
        end
        parse_json(response)
      end

      private

      def parse_json(response)
        json = JSON.parse(response.body)
        if json['error']
          case json['error']['type']
          when 'OAuthException'
            raise OauthException.new(json['error'])
          when 'GraphMethodException'
            raise GraphMethodException.new(json['error'])
          end
        end
        json
      end

      def connection
        @connection ||= Faraday.new(:url => "https://graph.facebook.com/#{MessengerPlatform::FB_MESSENGER_VERSION}") do |faraday|
          faraday.request  :url_encoded # form-encode POST params
          faraday.response :logger unless Rails.env.test? # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

    end
  end
end
