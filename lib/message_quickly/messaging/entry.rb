module MessageQuickly
  module Messaging
    class Entry

      attr_accessor :id, :time

      def initialize(params = {})
        @id = params['id']
        @time = params['time']
      end

    end
  end
end
