module MessageQuickly
  module Messaging
    module Receipt
      class Element < MessageQuickly::Messaging::Element

        attr_accessor :quantity, :price, :currency

        def to_hash
          {
            title: title,
            subtitle: subtitle,
            quantity: quantity,
            price: price,
            currency: currency,
            image_url: image_url
          }
        end

      end
    end
  end
end
