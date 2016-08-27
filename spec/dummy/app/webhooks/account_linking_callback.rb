class AccountLinkingCallback < MessageQuickly::Callback

  def self.webhook_name
    :account_linking
  end

  def initialize(event, json)
    super
  end

  def run
  end

end
