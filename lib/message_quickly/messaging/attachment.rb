module MessageQuickly
  module Messaging
    class Attachment < Base

      attr_reader :type, :payload

      def file?
        false
      end

      def to_hash
        { type: type, payload: payload }
      end

    end
  end
end

