class MessageDeliveredCallback < MessageQuickly::Callback

  def self.webhook_name
    :message_deliveries
  end

  def initialize(event, json)
    super
  end

  def run
  end

end
