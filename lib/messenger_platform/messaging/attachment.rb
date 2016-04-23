module MessengerPlatform
  module Messaging
    class Attachment

      attr_reader :type, :payload

      def initialize(params = {})
        params.each { |key, value| instance_variable_set("@#{key}", value) }
      end

      protected

      def initialize_params(attributes, params = {})
        attributes.each { |key| instance_variable_set("@#{key}", params.delete(key)) if params[key] }
      end

    end
  end
end

