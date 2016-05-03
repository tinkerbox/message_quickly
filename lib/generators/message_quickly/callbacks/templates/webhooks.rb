Rails.application.eager_load!

MessageQuickly::Callback.subclasses.each do |callback|
  MessageQuickly::CallbackRegistry.register(callback)
end
