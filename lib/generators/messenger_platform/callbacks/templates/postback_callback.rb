class PostbackCallback < MessengerPlatform::Callback

  def callback_name
    :messaging_postbacks
  end

  def run(event, json)
  end

end
