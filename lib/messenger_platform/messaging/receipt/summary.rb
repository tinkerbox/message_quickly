module MessengerPlatform
  module Messaging
    module Receipt
      class Summary < MessengerPlatform::Messaging::Base

        attr_accessor :subtotal, :shipping_cost, :total_tax, :total_cost

        def to_hash
          {
            subtotal: subtotal,
            shipping_cost: shipping_cost,
            total_tax: total_tax,
            total_cost: total_cost
          }
        end

      end
    end
  end
end

# "summary":{
#   "subtotal":75.00,
#   "shipping_cost":4.95,
#   "total_tax":6.19,
#   "total_cost":56.14
# }
