module MessageQuickly
  module Messaging
    class WebUrlButton < Button

      attr_accessor :url, :webview_height_ratio

      def initialize(params = {})
        params['type'] ||= 'web_url'
        super(params)
      end

      def to_hash
        { type: type, url: url, title: title, webview_height_ratio: webview_height_ratio }
      end

    end
  end
end

# {
#   "type":"web_url",
#   "url":"https://petersapparel.parseapp.com",
#   "title":"Show Website",
#   "webview_height_ratio": "compact"
# }
