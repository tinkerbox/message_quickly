module MessengerPlatform
  module Messaging
    class User

      attr_reader :id

      def initialize(params = {})
        @id = params['id']
      end

    end
  end
end
