require 'spec_helper'

describe MessageQuickly::Api::ThreadSettings do

  subject { MessageQuickly::Api::ThreadSettings }

  describe '#greeting' do

    let(:text) { 'Hello' }

    context 'with own client' do
      let(:client) { MessageQuickly::Api::Client.new(page_access_token: ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN'], page_id: ENV['FACEBOOK_MESSENGER_PAGE_ID']) }
      it { expect(subject.new(client).greeting(text)).to eq(true) }
    end

    context 'with valid params' do
      it { expect(subject.greeting(text)).to eq(true) }
    end

    context 'with invalid params' do
      before { stub_const('ENV', ENV.to_hash.merge('FACEBOOK_MESSENGER_PAGE_ID' => 'invalid')) }
      it { expect { subject.greeting(text) }.to raise_exception(MessageQuickly::Api::OauthException) }
    end

  end

  describe '#get_started_button' do

    let(:payload) { 'Payload 1' }

    context 'with own client' do
      let(:client) { MessageQuickly::Api::Client.new(page_access_token: ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN'], page_id: ENV['FACEBOOK_MESSENGER_PAGE_ID']) }
      it { expect(subject.new(client).get_started_button(payload)).to eq(true) }
    end

    context 'with valid params' do
      it { expect(subject.get_started_button(payload)).to eq(true) }
    end

    context 'with invalid params' do
      before { stub_const('ENV', ENV.to_hash.merge('FACEBOOK_MESSENGER_PAGE_ID' => 'invalid')) }
      it { expect { subject.get_started_button(payload) }.to raise_exception(MessageQuickly::Api::OauthException) }
    end

  end

  describe '#remove_get_started_button' do

    context 'with own client' do
      let(:client) { MessageQuickly::Api::Client.new(page_access_token: ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN'], page_id: ENV['FACEBOOK_MESSENGER_PAGE_ID']) }
      it { expect(subject.new(client).remove_get_started_button).to eq(true) }
    end

    context 'with valid params' do
      it { expect(subject.remove_get_started_button).to eq(true) }
    end

    context 'with invalid params' do
      before { stub_const('ENV', ENV.to_hash.merge('FACEBOOK_MESSENGER_PAGE_ID' => 'invalid')) }
      it { expect { subject.remove_get_started_button }.to raise_exception(MessageQuickly::Api::OauthException) }
    end

  end

  describe '#persistent_menu' do

    let(:payloads) { [
      { type: 'postback', title: 'Help', payload: 'DEVELOPER_DEFINED_PAYLOAD_FOR_HELP' },
      { type: 'postback', title: 'Start a New Order', payload: 'DEVELOPER_DEFINED_PAYLOAD_FOR_START_ORDER' },
      { type: 'web_url', title: 'View Website', url: 'http://petersapparel.parseapp.com/' }
    ] }

    context 'with own client' do
      let(:client) { MessageQuickly::Api::Client.new(page_access_token: ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN'], page_id: ENV['FACEBOOK_MESSENGER_PAGE_ID']) }
      it { expect(subject.new(client).persistent_menu(payloads)).to eq(true) }
    end

    context 'with valid params' do
      it { expect(subject.persistent_menu(payloads)).to eq(true) }
    end

    context 'with invalid params' do
      before { stub_const('ENV', ENV.to_hash.merge('FACEBOOK_MESSENGER_PAGE_ID' => 'invalid')) }
      it { expect { subject.persistent_menu(payloads) }.to raise_exception(MessageQuickly::Api::OauthException) }
    end

  end

  describe '#remove_persistent_menu' do

    context 'with own client' do
      let(:client) { MessageQuickly::Api::Client.new(page_access_token: ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN'], page_id: ENV['FACEBOOK_MESSENGER_PAGE_ID']) }
      it { expect(subject.new(client).remove_persistent_menu).to eq(true) }
    end

    context 'with valid params' do
      it { expect(subject.remove_persistent_menu).to eq(true) }
    end

    context 'with invalid params' do
      before { stub_const('ENV', ENV.to_hash.merge('FACEBOOK_MESSENGER_PAGE_ID' => 'invalid')) }
      it { expect { subject.remove_persistent_menu }.to raise_exception(MessageQuickly::Api::OauthException) }
    end

  end

end
