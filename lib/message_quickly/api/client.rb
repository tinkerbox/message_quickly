require "faraday"

module MessageQuickly
  module Api
    class Client

      attr_accessor :page_access_token, :page_id

      def initialize(options = {})
        options.each { |key, value| instance_variable_set("@#{key}", value) }
        yield self if block_given?
      end

      def get(request_string, params = {})
        params[:access_token] = page_access_token
        response = connection.get(request_string, params)
        parse_json(response)
      end

      def post(request_string, params = {})
        params[:access_token] = page_access_token
        response = connection.post(request_string) do |request|
          if params[:filedata].present?
            request.headers['Content-Type'] = 'multipart/form-data'
            request.body = params
          else
            request.headers['Content-Type'] = 'application/json'
            request.body = JSON.generate(params)
          end
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
          else
            raise FacebookApiException.new(json['error'])
          end
        end
        json
      end

      def connection(params = {})
        @connection ||= Faraday.new(:url => "https://graph.facebook.com/#{MessageQuickly::FB_MESSENGER_VERSION}") do |faraday|
          faraday.request :multipart # if params[:multipart]
          faraday.request  :url_encoded # form-encode POST params
          faraday.response :logger unless Rails.env.test? # log requests to STDOUT
          faraday.adapter Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

    end
  end
end
