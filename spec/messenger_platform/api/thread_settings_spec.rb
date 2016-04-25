require 'spec_helper'

describe MessengerPlatform::Api::ThreadSettings do

  subject { MessengerPlatform::Api::ThreadSettings }

  describe '#create' do

    let(:message) { MessengerPlatform::Messaging::Message.new(text: 'Hello') }

    context 'with own client' do
      let(:client) { MessengerPlatform::Api::Client.new(page_access_token: ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN'], page_id: ENV['FACEBOOK_MESSENGER_PAGE_ID']) }
      it { expect(subject.new(client).create(message)).to eq(true) }
    end

    context 'with valid params' do
      it { expect(subject.create(message)).to eq(true) }
    end

    context 'with invalid params' do
      before { stub_const('ENV', ENV.to_hash.merge('FACEBOOK_MESSENGER_PAGE_ID' => 'invalid')) }
      it { expect { subject.create(message) }.to raise_exception(MessengerPlatform::Api::OauthException) }
    end

  end

  describe '#delete' do
    it { expect(subject.delete).to eq(true) }
  end

end
