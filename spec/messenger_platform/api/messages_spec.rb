require 'spec_helper'

describe MessengerPlatform::Api::Messages do

  subject { MessengerPlatform::Api::Messages }

  describe '#create' do

    let(:recipient) { MessengerPlatform::Messaging::Recipient.new(id: '123') }
    let(:message) { MessengerPlatform::Messaging::Message.new(text: 'Hello') }
    let(:delivery) { MessengerPlatform::Messaging::Delivery.new(recipient: recipient, message: message) }

    context 'with valid recipient' do
      # it { expect { subject.create(delivery) }.to raise_exception(MessengerPlatform::Api::OauthException) }
      pending
    end

    context 'with invalid recipient' do
      it { expect { subject.create(delivery) }.to raise_exception(MessengerPlatform::Api::OauthException) }
    end
  end

end
