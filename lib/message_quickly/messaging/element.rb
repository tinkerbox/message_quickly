module MessageQuickly
  module Messaging
    class Element < MessageQuickly::Messaging::Base

      attr_accessor :title, :image_url, :subtitle, :buttons

      def initialize(params = {})
        self.buttons ||= []
        super(params)
      end

      def build_button(button_type)
        case button_type
        when :web_url
          button = WebUrlButton.new
        when :postback
          button = PostbackButton.new
        when :account_link
          button = AccountLinkButton.new
        when :share_button
          button = ShareButton.new
        end
        buttons << button.tap { |button| yield button if block_given? }
      end

      def to_hash
        {
          title: title,
          image_url: image_url,
          subtitle: subtitle,
          buttons: buttons.collect { |button| button.to_hash }
        }
      end

    end
  end
end
