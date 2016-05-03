module MessageQuickly

  class Engine < ::Rails::Engine

    isolate_namespace MessageQuickly

    initializer 'message_quickly.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper MessageQuickly::ApplicationHelper
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
    end

  end
end
