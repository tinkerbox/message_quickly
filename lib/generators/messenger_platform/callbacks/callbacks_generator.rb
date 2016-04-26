module MessengerPlatform
  module Generators
    class CallbacksGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def copy_webhooks
        copy_file "webhooks.rb", "config/initializers/webhooks.rb"
        copy_file "authentication_callback.rb", "app/webhooks/authentication_callback.rb"
        copy_file "message_delivered_callback.rb", "app/webhooks/message_delivered_callback.rb"
        copy_file "message_received_callback.rb", "app/webhooks/message_received_callback.rb"
        copy_file "postback_callback.rb", "app/webhooks/postback_callback.rb"
      end

    end
  end
end