require 'spec_helper'

describe MessengerPlatform::WebhooksController, type: :controller do

  routes { MessengerPlatform::Engine.routes }

  describe 'GET #verify' do

    context 'with valid token' do
      before { get :verify, 'hub.verify_token': ENV['FACEBOOK_MESSENGER_VERIFICATION_TOKEN'], 'hub.challenge': '123456' }
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

    context 'with an optin request' do

      let(:optin_json) { File.read("spec/fixtures/optin_request.json") }

      context 'with valid params' do
        before { post :callback, optin_json }
        it { expect(response).to have_http_status(200) }
      end

      context 'with invalid params' do
        before { post :callback, 'invalid json' }
        it { expect(response.body).to eq('Error processing callback') }
        it { expect(response).to have_http_status(500) }
      end

    end

    context 'with a delivery request' do

      let(:optin_json) { File.read("spec/fixtures/delivery_request.json") }

      context 'with valid params' do
        before { post :callback, optin_json }
        it { expect(response).to have_http_status(200) }
      end

      context 'with invalid params' do
        before { post :callback, 'invalid json' }
        it { expect(response.body).to eq('Error processing callback') }
        it { expect(response).to have_http_status(500) }
      end

    end

    context 'with a message request' do

      let(:optin_json) { File.read("spec/fixtures/message_request.json") }

      context 'with valid params' do
        before { post :callback, optin_json }
        it { expect(response).to have_http_status(200) }
      end

      context 'with invalid params' do
        before { post :callback, 'invalid json' }
        it { expect(response.body).to eq('Error processing callback') }
        it { expect(response).to have_http_status(500) }
      end

    end

    context 'with a postback request' do

      let(:optin_json) { File.read("spec/fixtures/postback_request.json") }

      context 'with valid params' do
        before { post :callback, optin_json }
        it { expect(response).to have_http_status(200) }
      end

      context 'with invalid params' do
        before { post :callback, 'invalid json' }
        it { expect(response.body).to eq('Error processing callback') }
        it { expect(response).to have_http_status(500) }
      end

    end

  end

end
