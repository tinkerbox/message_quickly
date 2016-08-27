require 'spec_helper'

describe MessageQuickly::Api::AccountLink do

  subject { MessageQuickly::Api::AccountLink }

  describe '#page_scoped_id' do

    let(:account_linking_token) { "token expires, so can't use it for testing" }

    context 'with own client' do
      let(:client) { MessageQuickly::Api::Client.new(page_access_token: ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN'], page_id: ENV['FACEBOOK_MESSENGER_PAGE_ID']) }
      # it { expect(subject.new(client).page_scoped_id(account_linking_token)).to eq(true) }
      it { expect { subject.page_scoped_id(account_linking_token) }.to raise_exception(MessageQuickly::Api::OauthException) }
    end

    context 'with valid params' do
      # it { expect(subject.page_scoped_id(account_linking_token)).to eq(true) }
      it { expect { subject.page_scoped_id(account_linking_token) }.to raise_exception(MessageQuickly::Api::OauthException) }
    end

    context 'with invalid params' do
      before { stub_const('ENV', ENV.to_hash.merge('FACEBOOK_MESSENGER_PAGE_ID' => 'invalid')) }
      it { expect { subject.page_scoped_id(account_linking_token) }.to raise_exception(MessageQuickly::Api::OauthException) }
    end

  end

  describe '#unlink_account' do

    let(:page_scoped_id) { ENV['FACEBOOK_MESSENGER_USER_ID'] }

    context 'with own client' do
      let(:client) { MessageQuickly::Api::Client.new(page_access_token: ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN'], page_id: ENV['FACEBOOK_MESSENGER_PAGE_ID']) }
      it { expect(subject.new(client).unlink_account(page_scoped_id)).to eq(true) }
    end

    context 'with valid params' do
      it { expect(subject.unlink_account(page_scoped_id)).to eq(true) }
    end

    context 'with invalid params' do
      before { stub_const('ENV', ENV.to_hash.merge('FACEBOOK_MESSENGER_PAGE_ID' => 'invalid')) }
      it { expect { subject.unlink_account('') }.to raise_exception(MessageQuickly::Api::OauthException) }
    end

  end

end
