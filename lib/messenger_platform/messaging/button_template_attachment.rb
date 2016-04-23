module MessengerPlatform
  module Messaging
    class ButtonTemplateAttachment < TemplateAttachment

      attr_accessor :text, :buttons

      def initialize(params = {})
        self.buttons ||= []
        params['template_type'] ||= 'button'
        super(params)
      end

      def build_button(button_type)
        case button_type
        when :web_url
          button = WebUrlButton.new
        when :postback
          button = PostbackButton.new
        end
        buttons << button.tap { |button| yield button }
      end

      def to_hash
        {
          type: type,
          payload: {
            template_type: template_type,
            text: text,
            buttons: buttons.collect { |button| button.to_hash }
          }
        }
      end

    end
  end
end

# "attachment":{
#   "type":"template",
#   "payload":{
#     "template_type":"button",
#     "text":"What do you want to do next?",
#     "buttons":[
#       {
#         "type":"web_url",
#         "url":"https://petersapparel.parseapp.com",
#         "title":"Show Website"
#       },
#       {
#         "type":"postback",
#         "title":"Start Chatting",
#         "payload":"USER_DEFINED_PAYLOAD"
#       }
#     ]
#   }
# }
