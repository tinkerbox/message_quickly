module MessengerPlatform
  module Messaging
    module Receipt
      class Address < MessengerPlatform::Messaging::Base

        attr_accessor :street_1, :street_2, :city, :postal_code, :state, :country

        def to_hash
          {
            street_1: street_1,
            street_2: street_2,
            city: city,
            postal_code: postal_code,
            state: state,
            country: country
          }
        end

      end
    end
  end
end

# "address":{
#   "street_1":"1 Hacker Way",
#   "street_2":"",
#   "city":"Menlo Park",
#   "postal_code":"94025",
#   "state":"CA",
#   "country":"US"
# }
