module MessageQuickly
  module Api
    class GraphMethodException < StandardError

      attr_reader :code, :error_subcode, :fbtrace_id

      def initialize(params = {})
        @message = params['message']
        @code = params['code']
        @error_subcode = params['error_subcode']
        @fbtrace_id = params['fbtrace_id']
        super(message)
      end

      def message
        @message
      end

    end
  end
end

# https://developers.facebook.com/docs/messenger-platform/send-api-reference#errors
