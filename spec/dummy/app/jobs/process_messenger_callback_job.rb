class ProcessMessengerCallbackJob < ActiveJob::Base

  queue_as :messaging

  def perform(json)
    MessageQuickly::CallbackParser.new(json.deep_dup).parse do |event|
      callback_handler = MessageQuickly::CallbackRegistry.handler_for(event.webhook_name)
      if callback_handler
        callback = callback_handler.new(event, json.deep_dup)
        callback.run
      end
    end
  end

end
