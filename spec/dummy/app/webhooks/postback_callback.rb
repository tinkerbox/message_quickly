class PostbackCallback < MessageQuickly::Callback

  def self.webhook_name
    :messaging_postbacks
  end

  def initialize(event, json)
    super
  end

  def run
  end

end
