class ProcessMessengerCallbackJob < ActiveJob::Base

  queue_as :messaging

  def perform(json)
    CallbackParser.new(json.deep_dup).parse do |event|
      callback_handler = CallbackRegistry.handler_for(event.webhook_name)
      return unless callback_handler.present?
      callback_handler.new.run(json.deep_dup)
    end
  end

end
