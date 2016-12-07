class ChangeUpdateCallback < MessageQuickly::Callback

  def self.webhook_name
    :changes
  end

  def initialize(event, json)
    super
  end

  def run
  end

end
