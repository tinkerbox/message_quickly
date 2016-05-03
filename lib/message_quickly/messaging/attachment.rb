module MessageQuickly
  module Messaging
    class Attachment < Base

      attr_reader :type, :payload

      def file?
        false
      end

    end
  end
end

