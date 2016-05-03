module MessageQuickly
  module Api
    class OauthException < StandardError

      attr_reader :code, :fbtrace_id

      def initialize(params = {})
        @message = params['message']
        @code = params['code']
        @fbtrace_id = params['fbtrace_id']
        super(message)
      end

      def message
        @message
      end

    end
  end
end