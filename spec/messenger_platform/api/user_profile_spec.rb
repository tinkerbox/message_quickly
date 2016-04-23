require 'spec_helper'

describe MessengerPlatform::Api::UserProfile do

  subject { MessengerPlatform::Api::UserProfile }

  describe '#find' do

    context 'with matching user' do
      it { expect(subject.find('1043180089111188')).to be_kind_of(MessengerPlatform::Messaging::User) }
      it { expect(subject.find('1043180089111188').first_name).to eq(ENV['FACEBOOK_MESSENGER_USER_FIRST_NAME']) }
    end

    context 'with no matching user' do
      it { expect { subject.find('091283908123') }.to raise_exception(MessengerPlatform::Api::GraphMethodException) }
    end

  end

end
