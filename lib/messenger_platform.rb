require "messenger_platform/engine"

require "messenger_platform/callback_parser"
require "messenger_platform/callback_registry"

module MessengerPlatform

  # mount MessengerPlatform::Engine => "/webhook"

  # client = MessengerPlatform::Client.new do |client|
  #   client.token = '<token goes here>'
  # end

  # client.callback_registry.register(:messaging_optins) do |event|
  #   puts event.inspect
  # end

  # MessengerPlatform::Engine.callback_registry = MessengerPlatform::CallbackRegistry.new

end
