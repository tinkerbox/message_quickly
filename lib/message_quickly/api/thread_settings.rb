module MessageQuickly
  module Api
    class ThreadSettings < Base

      def self.greeting(text)
        # curl -X POST -H "Content-Type: application/json" -d '{
        #   "setting_type":"greeting",
        #   "greeting":{
        #       "text":"Welcome to My Company!"
        #   }
        # }' "https://graph.facebook.com/v2.6/<PAGE_ID>/thread_settings?access_token=<PAGE_ACCESS_TOKEN>"
        ThreadSettings.new.greeting(text)
      end

      def self.get_started_button(payload)
        # curl -X POST -H "Content-Type: application/json" -d '{
        #   "setting_type":"call_to_actions",
        #   "thread_state":"new_thread",
        #   "call_to_actions":[
        #     {
        #       "payload":"USER_DEFINED_PAYLOAD"
        #     }
        #   ]
        # }' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=PAGE_ACCESS_TOKEN"
        ThreadSettings.new.get_started_button(payload)
      end

      def self.remove_get_started_button
        # curl -X DELETE -H "Content-Type: application/json" -d '{
        #   "setting_type":"call_to_actions",
        #   "thread_state":"new_thread"
        # }' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=PAGE_ACCESS_TOKEN"
        ThreadSettings.new.remove_get_started_button
      end

      def self.persistent_menu(payloads = [])
        # curl -X POST -H "Content-Type: application/json" -d '{
        #   "setting_type" : "call_to_actions",
        #   "thread_state" : "existing_thread",
        #   "call_to_actions":[
        #     {
        #       "type":"postback",
        #       "title":"Help",
        #       "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_HELP"
        #     },
        #     {
        #       "type":"postback",
        #       "title":"Start a New Order",
        #       "payload":"DEVELOPER_DEFINED_PAYLOAD_FOR_START_ORDER"
        #     },
        #     {
        #       "type":"web_url",
        #       "title":"View Website",
        #       "url":"http://petersapparel.parseapp.com/"
        #     }
        #   ]
        # }' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=PAGE_ACCESS_TOKEN"
        ThreadSettings.new.persistent_menu(payloads)
      end

      def self.remove_persistent_menu
        ThreadSettings.new.remove_persistent_menu
      end

      def greeting(text)
        json = @client.post(request_string, { setting_type: 'greeting', greeting: { text: text } })
        json['result'] == "Successfully updated greeting"
      end

      def get_started_button(payload)
        json = @client.post(request_string, { setting_type: 'call_to_actions', thread_state: 'new_thread', call_to_actions: [payload: payload] })
        json['result'] == "Successfully added new_thread's CTAs"
      end

      def remove_get_started_button
        json = @client.delete(request_string, { setting_type: 'call_to_actions', thread_state: 'new_thread' })
        json['result'] == "Successfully deleted all new_thread's CTAs"
      end

      def persistent_menu(payloads = [])
        json = @client.post(request_string, { setting_type: 'call_to_actions', thread_state: 'existing_thread', call_to_actions: payloads })
        json['result'] == "Successfully added structured menu CTAs"
      end

      def remove_persistent_menu(payloads = [])
        json = @client.delete(request_string, { setting_type: 'call_to_actions', thread_state: 'existing_thread' })
        json['result'] == "Successfully deleted structured menu CTAs"
      end

      private

      def request_string
        "#{ENV['FACEBOOK_MESSENGER_PAGE_ID']}/thread_settings"
      end

    end
  end
end
