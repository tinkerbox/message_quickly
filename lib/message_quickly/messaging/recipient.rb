module MessageQuickly
  module Messaging
    class Recipient < User

      attr_accessor :phone_number

      def to_hash
        if id.present?
          { id: id }
        else
          { phone_number: phone_number }
        end
      end

    end
  end
end
