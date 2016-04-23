require "spec_helper"

RSpec.describe ApplicationHelper, :type => :helper do

  describe "#send_to_messenger" do
    it { expect(helper.send_to_messenger).to eq("<div class=\"fb-send-to-messenger\" messenger_app_id=\"#{ENV['FACEBOOK_APP_ID']}\" data-ref=\"PASS_THROUGH_PARAM\" color=\"blue\" size=\"standard\"></div>") }
  end

  describe "#message_us" do
    it { expect(helper.message_us).to eq("<div class=\"fb-messengermessageus\" messenger_app_id=\"#{ENV['FACEBOOK_APP_ID']}\" color=\"blue\" size=\"standard\"></div>") }
  end

end
