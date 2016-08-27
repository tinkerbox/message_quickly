class MessageReadCallback < MessageQuickly::Callback

  def self.webhook_name
    :message_reads
  end

  def initialize(event, json)
    super
  end

  def run
  end

end
