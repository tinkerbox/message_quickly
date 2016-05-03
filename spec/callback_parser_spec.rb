require 'spec_helper'

module MessageQuickly

  describe CallbackParser do
    
    context 'with a optin request' do

      let(:optin_json) { JSON.parse(File.read("spec/fixtures/optin_request.json")) }

      subject { CallbackParser.new(optin_json) }

      it { expect { |b| subject.parse(&b) }.to yield_with_args(Messaging::OptinEvent) }
      it { expect(subject.parse).not_to be_empty }

    end

    context 'with a delivery request' do

      let(:delivery_json) { JSON.parse(File.read("spec/fixtures/delivery_request.json")) }

      subject { CallbackParser.new(delivery_json) }

      it { expect { |b| subject.parse(&b) }.to yield_with_args(Messaging::DeliveryEvent) }
      it { expect(subject.parse).not_to be_empty }

    end

    context 'with a message request' do

      let(:message_json) { JSON.parse(File.read("spec/fixtures/message_request.json")) }

      subject { CallbackParser.new(message_json) }

      it { expect { |b| subject.parse(&b) }.to yield_with_args(Messaging::MessageEvent) }
      it { expect(subject.parse).not_to be_empty }

    end

    context 'with a postback request' do

      let(:postback_json) { JSON.parse(File.read("spec/fixtures/postback_request.json")) }

      subject { CallbackParser.new(postback_json) }

      it { expect { |b| subject.parse(&b) }.to yield_with_args(Messaging::PostbackEvent) }
      it { expect(subject.parse).not_to be_empty }

    end

  end

end
