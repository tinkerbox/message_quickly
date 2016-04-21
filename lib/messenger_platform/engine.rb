module MessengerPlatform

  mattr_accessor :app_root

  class Engine < ::Rails::Engine

    isolate_namespace MessengerPlatform

    initializer "messenger_platform.load_app_root" do |app|
      MessengerPlatform.app_root = app.root
      Dir[MessengerPlatform.app_root + 'app/webhooks/*.rb'].each { |file| load file }
      Callback.subclasses.each do |callback|
        CallbackRegistry.register(callback)
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      # g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

  end
end
