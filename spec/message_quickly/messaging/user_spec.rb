require 'spec_helper'

describe MessageQuickly::Messaging::User do

  subject { MessageQuickly::Messaging::User.new(id: ENV['FACEBOOK_MESSENGER_USER_ID']) }

  it { expect(subject.first_name).to eq(ENV['FACEBOOK_MESSENGER_USER_FIRST_NAME']) }
  it { expect(subject.last_name).to eq(ENV['FACEBOOK_MESSENGER_USER_LAST_NAME']) }

end
