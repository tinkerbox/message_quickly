module MessengerPlatform
  module Messaging
    class Recipient < User

      attr_accessor :phone_number

      def to_hash
        if phone_number
          { phone_number: phone_number }
        else
          { id: id }
        end
      end

    end
  end
end
