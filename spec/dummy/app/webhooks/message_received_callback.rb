class MessageReceivedCallback < MessageQuickly::Callback

  def self.webhook_name
    :messages
  end

  def initialize(event, json)
    super
  end

  def run
  end

end
