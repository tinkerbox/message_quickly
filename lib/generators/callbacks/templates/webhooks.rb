Rails.application.eager_load!

MessengerPlatform::Callback.subclasses.each do |callback|
  MessengerPlatform::CallbackRegistry.register(callback)
end
