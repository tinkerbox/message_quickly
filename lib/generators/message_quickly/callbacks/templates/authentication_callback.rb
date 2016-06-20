class AuthenticationCallback < MessageQuickly::Callback

  def self.webhook_name
    :messaging_optins
  end

  def initialize(event, json)
    super
  end

  def run
  end

end
