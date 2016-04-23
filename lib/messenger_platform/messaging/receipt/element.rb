module MessengerPlatform
  module Messaging
    module Receipt
      class Element < MessengerPlatform::Messaging::Element

        attr_accessor :quantity, :price, :currency

        def initialize(params = {})
          params.each { |key, value| instance_variable_set("@#{key}", value) }
        end

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
