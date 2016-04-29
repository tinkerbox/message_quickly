class SendMessengerDeliveryJob < ActiveJob::Base

  queue_as :messaging

  def perform(hash)
    MessengerPlatform::Api::Client.create_from_hash(hash)
  end

  # To use this:

  # recipient = MessengerPlatform::Messaging::Recipient.new(id: '<facebook page specific id here>')
  # delivery = MessengerPlatform::Messaging::Delivery.new(recipient: recipient) do |delivery|
  #   delivery.build_message do |message|
  #     message.text = 'Hello'
  #   end
  # end
  #
  # SendMessengerDeliveryJob.perform_later(delivery.to_hash)

end
