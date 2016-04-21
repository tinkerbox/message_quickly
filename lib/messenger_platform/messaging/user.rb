module MessengerPlatform
  module Messaging
    class User

      attr_reader :id

      def initialize(params = {})
        params.each { |key, value| instance_variable_set("@#{key}", value) }
      end

    end
  end
end
