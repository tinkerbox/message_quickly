require 'spec_helper'

describe MessengerPlatform::WebhooksController, type: :controller do

  routes { MessengerPlatform::Engine.routes }

  describe 'GET #verify' do

    context 'with valid token' do
      before { get :verify, 'hub.verify_token': '<validation_token>', 'hub.challenge': '123456' }
      it { expect(response.body).to eq('123456') }
      it { expect(response).to have_http_status(200) }
    end

    context 'with invalid token' do
      before { get :verify, 'hub.verify_token': '<invalid token>', 'hub.challenge': '123456' }
      it { expect(response.body).to eq('Wrong validation token') }
      it { expect(response).to have_http_status(500) }
    end
    
  end

  describe 'POST #callback' do

    context 'with valid params' do
      before { post :callback, valid: true }
      it { expect(response).to have_http_status(200) }
    end

    context 'with invalid params' do
      before { post :callback, valid: false }
      it { expect(response.body).to eq('Error processing callback') }
      it { expect(response).to have_http_status(500) }
    end

  end

end
