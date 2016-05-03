module MessageQuickly
  module Messaging
    class Base

      def initialize(params = {})
        params.each { |key, value| instance_variable_set("@#{key}", value) }
        self
      end

    end
  end
end
