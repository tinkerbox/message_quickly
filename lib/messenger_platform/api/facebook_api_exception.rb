module MessengerPlatform
  module Api
    class FacebookApiException < StandardError

      attr_reader :code, :error_data, :fbtrace_id

      def initialize(params = {})
        @message = params['message']
        @code = params['code']
        @error_data = params['error_data']
        @fbtrace_id = params['fbtrace_id']
        super(message)
      end

      def message
        "#{@message}: #{@error_data}"
      end

    end
  end
end

# {
#    "error":{
#       "message":"Invalid parameter",
#       "type":"FacebookApiException",
#       "code":100,
#       "error_data":"No matching user found.",
#       "fbtrace_id":"D2kxCybrKVw"
#    }
# }
