module MessengerPlatform

  class Engine < ::Rails::Engine

    isolate_namespace MessengerPlatform

    initializer 'messenger_platform.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper MessengerPlatform::ApplicationHelper
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
    end

  end
end
