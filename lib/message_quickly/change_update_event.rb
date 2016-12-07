module MessageQuickly
  class ChangeUpdateEvent

    attr_reader :changes

    def initialize(params = {})
      @object_id = params[:entry].id
      @time = params[:entry].time
      @changes = params[:changes]
    end

    def webhook_name
      :changes
    end

  end
end

# {
#   "object":"page",
#   "entry":[
#       {
#         "id":"PAGE_ID",
#         "time":1476077449,
#         "changes":[
#             {
#               "field":"conversations",
#               "value":{
#                 "thread_id":"CONVERSATION_ID",
#                 "page_id":"PAGE_ID"
#               }
#             }
#           ]
#       }
#     ]
# }
