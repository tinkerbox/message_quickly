module MessageQuickly
  module Messaging
    class LocationAttachment < Attachment

      attr_accessor :latitude, :longitude

      def initialize(params = {})
        params['type'] ||= 'location'
        super(params)
      end

      def to_hash
        { type: type, payload: { coordinates: { lat: latitude, long: longitude } } }
      end

    end
  end
end

# "attachments":[
#   {
#     "type":"location",
#     "payload":{
#       "coordinates":{
#         "lat":123123123,
#         "long":123123123
#       }
#     }
#   }
# ]
