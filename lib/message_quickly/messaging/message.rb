module MessageQuickly
  module Messaging
    class Message

      attr_accessor :text, :attachment, :quick_replies

      def initialize(options = {})
        options.each { |key, value| instance_variable_set("@#{key}", value) }
        yield self if block_given?
      end

      def build_attachment(attachment_type)
        case attachment_type
        when :image
          self.attachment = MessageQuickly::Messaging::ImageAttachment.new
        when :audio
          self.attachment = MessageQuickly::Messaging::AudioAttachment.new
        when :video
          self.attachment = MessageQuickly::Messaging::VideoAttachment.new
        when :generic_template
          self.attachment = MessageQuickly::Messaging::GenericTemplateAttachment.new
        when :button_template
          self.attachment = MessageQuickly::Messaging::ButtonTemplateAttachment.new
        when :receipt_template
          self.attachment = MessageQuickly::Messaging::ReceiptTemplateAttachment.new
        end
        yield attachment if block_given?
      end

      def build_quick_reply
        @quick_replies ||= []
        new_quick_reply = MessageQuickly::Messaging::QuickReply.new
        quick_replies << new_quick_reply
        yield new_quick_reply
      end

      def to_hash
        if attachment
          hash_buffer = { attachment: attachment.to_hash }
        else
          hash_buffer = { text: text }
        end
        hash_buffer.merge!({ quick_replies: quick_replies.collect { |quick_reply| quick_reply.to_hash } }) if quick_replies.present?
        hash_buffer
      end

    end
  end
end
