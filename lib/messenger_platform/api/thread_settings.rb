module MessengerPlatform
  module Api
    class ThreadSettings < Base

      def self.create(message)
        # curl -X POST -H "Content-Type: application/json" -d '{
        #   "setting_type":"call_to_actions",
        #   "thread_state":"new_thread",
        #   "call_to_actions":[
        #     {
        #       "message":{
        #         "text":"Welcome to My Company!"
        #       }
        #     }
        #   ]
        # }' "https://graph.facebook.com/v2.6/<PAGE_ID>/thread_settings?access_token=<PAGE_ACCESS_TOKEN>"
        ThreadSettings.new.create(message)
      end

      def self.delete
        # curl -X POST -H "Content-Type: application/json" -d '{
        #   "setting_type":"call_to_actions",
        #   "thread_state":"new_thread",
        #   "call_to_actions":[]
        # }' "https://graph.facebook.com/v2.6/<PAGE_ID>/thread_settings?access_token=<PAGE_ACCESS_TOKEN>"
        ThreadSettings.new.delete
      end

      def create(message)
        request_string = "#{ENV['FACEBOOK_MESSENGER_PAGE_ID']}/thread_settings"
        json = @client.post(request_string, { setting_type: 'call_to_actions', thread_state: 'new_thread', call_to_actions: [{ message: { text: message } }] })
        json['result'] == "Successfully added new_thread's CTAs"
      end

      def delete
        request_string = "#{ENV['FACEBOOK_MESSENGER_PAGE_ID']}/thread_settings"
        json = @client.post(request_string, { setting_type: 'call_to_actions', thread_state: 'new_thread', call_to_actions: [] })
        json['result'] == "Successfully removed all new_thread's CTAs"
      end

    end
  end
end
