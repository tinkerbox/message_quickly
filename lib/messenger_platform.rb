require "messenger_platform/api/client"
require "messenger_platform/api/base"
require "messenger_platform/api/messages"
require "messenger_platform/api/facebook_api_exception"
require "messenger_platform/api/oauth_exception"
require "messenger_platform/api/graph_method_exception"
require "messenger_platform/api/no_matching_user_exception"
require "messenger_platform/api/not_permitted_exception"
require "messenger_platform/api/send_message_exception"
require "messenger_platform/api/thread_settings"
require "messenger_platform/api/user_profile"

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
