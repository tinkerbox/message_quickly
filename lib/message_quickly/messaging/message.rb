module MessageQuickly
  module Messaging
    class Message

      attr_accessor :text, :attachment

      def initialize(options = {})
        options.each { |key, value| instance_variable_set("@#{key}", value) }
        yield self if block_given?
      end

      def build_attachment(attachment_type)
        case attachment_type
        when :image
          self.attachment = MessageQuickly::Messaging::ImageAttachment.new
        when :generic_template
          self.attachment = MessageQuickly::Messaging::GenericTemplateAttachment.new
        when :button_template
          self.attachment = MessageQuickly::Messaging::ButtonTemplateAttachment.new
        when :receipt_template
          self.attachment = MessageQuickly::Messaging::ReceiptTemplateAttachment.new
        end
        yield attachment if block_given?
      end

      def to_hash
        if attachment
          { attachment: attachment.to_hash }
        else
          { text: text }
        end
      end

    end
  end
end
