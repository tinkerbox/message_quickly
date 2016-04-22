module MessengerPlatform
  module ApplicationHelper

    def send_to_messenger(params = {})
      params[:class] = 'fb-send-to-messenger'
      params[:messenger_app_id] = ENV['FACEBOOK_APP_ID']
      params[:page_id] = ENV['FACEBOOK_PAGE_ID']
      params[:data] ||= {}
      params[:data][:ref] ||= 'PASS_THROUGH_PARAM'
      params[:color] ||= 'blue'
      params[:size] ||= 'standard'
      content_tag(:div, '', params)
    end

    def message_us(params = {})
      params[:class] = 'fb-messengermessageus'
      params[:messenger_app_id] = ENV['FACEBOOK_APP_ID']
      params[:page_id] = ENV['FACEBOOK_PAGE_ID']
      params[:color] ||= 'blue'
      params[:size] ||= 'standard'
      content_tag(:div, '', params)
    end

  end
end
