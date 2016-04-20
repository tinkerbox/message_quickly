require 'json'

require "messenger_platform/messaging/attachment"
require "messenger_platform/messaging/event"
require "messenger_platform/messaging/entry"
require "messenger_platform/messaging/recipient"
require "messenger_platform/messaging/sender"

require "messenger_platform/messaging/optin_event"
require "messenger_platform/messaging/delivery_event"
require "messenger_platform/messaging/message_event"
require "messenger_platform/messaging/postback_event"

module MessengerPlatform
  class CallbackParser

    def initialize(json)
      @json = json
    end

    WEBHOOK_LOOKUP = {
      optin: MessengerPlatform::Messaging::OptinEvent,
      postback: MessengerPlatform::Messaging::PostbackEvent,
      delivery: MessengerPlatform::Messaging::DeliveryEvent,
      message: MessengerPlatform::Messaging::MessageEvent
    }

    def parse
      events = []
      process_entry_json(@json['entry']) do |params|
        WEBHOOK_LOOKUP.keys.each do |key|
          if params[:messaging][key.to_s]
            events << WEBHOOK_LOOKUP[key].new(params[:messaging])
            break
          end
        end
      end
      events.each { |event| yield event if block_given? }
      events
    end

    private

    def process_entry_json(json)
      json.each do |entry_json|
        entry = Messaging::Entry.new(entry_json)
        entry_json['messaging'].each do |event_json|
          sender = Messaging::Sender.new(event_json['sender'])
          recipient = Messaging::Recipient.new(event_json['recipient'])
          timestamp = event_json['timestamp']
          yield callback_params(entry, sender, recipient, timestamp, event_json)
        end
      end
    end

    def callback_params(entry, sender, recipient, timestamp, event_json)
      {
        entry: entry,
        sender: sender,
        recipient: recipient,
        timestamp: timestamp,
        messaging: event_json
      }
    end

  end
end
