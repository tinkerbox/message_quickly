module MessengerPlatform
  class WebhooksController < ApplicationController

    def verify
      if params['hub.verify_token'] == '<validation_token>'
        render plain: params['hub.challenge'], status: 200
      else
        render plain: 'Wrong validation token', status: 500
      end
    end

    def callback
      if params[:valid] == true # MessengerPlatform::process_raw(request.body.read)
        render nothing: true, status: 200
      else
        render plain: 'Error processing callback', status: 500
      end
      
    end

  end
end
