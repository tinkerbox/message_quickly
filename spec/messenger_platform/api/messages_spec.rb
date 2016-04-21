require 'spec_helper'

describe MessengerPlatform::Api::Messages do

  subject { MessengerPlatform::Api::Messages }

  describe '#create' do

    let(:recipient) { MessengerPlatform::Messaging::Recipient.new(id: ENV['FACEBOOK_MESSENGER_USER_ID']) }
    let(:message) { MessengerPlatform::Messaging::Message.new(text: 'Hello') }
    let(:delivery) { MessengerPlatform::Messaging::Delivery.new(recipient: recipient, message: message) }

    context 'with valid recipient' do
      it { expect { subject.create(delivery) }.not_to raise_exception }
      it { expect { subject.create(delivery) }.to change { delivery.id }.from(nil) }
    end

    context 'with invalid recipient' do
      let(:recipient) { MessengerPlatform::Messaging::Recipient.new(id: 'invalid') }
      it { expect { subject.create(delivery) }.to raise_exception(MessengerPlatform::Api::OauthException) }
    end
  end

end
