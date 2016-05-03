module MessageQuickly
  module Messaging
    module Receipt
      class Adjustment < MessageQuickly::Messaging::Base

        attr_accessor :name, :amount

        def to_hash
          {
            name: name,
            amount: amount
          }
        end

      end
    end
  end
end

# {
#   "name":"New Customer Discount",
#   "amount":20
# }
