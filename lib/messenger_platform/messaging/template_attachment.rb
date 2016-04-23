module MessengerPlatform
  module Messaging
    class TemplateAttachment < Attachment

      attr_accessor :template_type

      def initialize(params = {})
        params['type'] ||= 'template'
        super(params)
      end

    end
  end
end
