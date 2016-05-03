module MessageQuickly
  module Messaging
    class WebUrlButton < Button

      attr_accessor :url

      def initialize(params = {})
        params['type'] ||= 'web_url'
        super(params)
      end

      def to_hash
        { type: type, url: url, title: title }
      end

    end
  end
end

# {
#   "type":"web_url",
#   "url":"https://petersapparel.parseapp.com",
#   "title":"Show Website"
# }
