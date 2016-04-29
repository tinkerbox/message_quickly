class ProcessMessengerCallbackJob < ActiveJob::Base

  queue_as :messaging

  def perform(json)
    MessengerPlatform::CallbackParser.new(json.deep_dup).parse do |event|
      callback_handler = MessengerPlatform::CallbackRegistry.handler_for(event.webhook_name)
      return unless callback_handler.present?
      callback_handler.new.run(event, json)
    end
  end

end
