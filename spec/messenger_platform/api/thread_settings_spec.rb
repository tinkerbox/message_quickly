require 'spec_helper'

describe MessengerPlatform::Api::ThreadSettings do

  subject { MessengerPlatform::Api::ThreadSettings }

  describe '#create' do

    let(:message) { MessengerPlatform::Messaging::Message.new(text: 'Hello') }

    context 'with valid params' do
      pending
      # it { expect(subject.create(message)).to be_truthy }
    end

    context 'with invalid params' do
      before { stub_const('ENV', ENV.to_hash.merge('FACEBOOK_MESSENGER_PAGE_ID' => 'invalid')) }
      it { expect { subject.create(message) }.to raise_exception(MessengerPlatform::Api::OauthException) }
    end

  end

  describe '#delete' do
    pending
    # it { expect(subject.delete).to be_truthy }
  end

end
