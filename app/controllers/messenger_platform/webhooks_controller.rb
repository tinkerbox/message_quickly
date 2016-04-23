module MessengerPlatform
  class WebhooksController < ApplicationController

    skip_before_action :verify_authenticity_token

    def verify
      if params['hub.verify_token'] == ENV['FACEBOOK_MESSENGER_VERIFICATION_TOKEN']
        render plain: params['hub.challenge'], status: 200
      else
        render plain: 'Wrong validation token', status: 500
      end
    end

    def callback
      if MessengerPlatform::CallbackRegistry.process_request(request.body.read)
        render nothing: true, status: 200
      else
        render plain: 'Error processing callback', status: 500
      end
    end

  end
end
