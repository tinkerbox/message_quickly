module MessageQuickly
  module Messaging
    class ReceiptTemplateAttachment < TemplateAttachment

      attr_accessor :recipient_name, :order_number, :currency, :payment_method, :order_url, :timestamp, :elements, :address, :summary, :adjustments

      def initialize(params = {})
        self.elements ||= []
        self.address ||= Receipt::Address.new
        self.summary ||= Receipt::Summary.new
        self.adjustments ||= []
        params['template_type'] ||= 'receipt'
        super(params)
      end

      def build_element
        elements << Receipt::Element.new.tap { |element| yield element }
      end

      def build_address
        yield address
      end

      def build_summary
        yield summary
      end

      def build_adjustment
        adjustments << Receipt::Adjustment.new.tap { |adjustment| yield adjustment }
      end

      def to_hash
        {
          type: type,
          payload: {
            template_type: template_type,
            recipient_name: recipient_name,
            order_number: order_number,
            currency: currency,
            payment_method: payment_method,
            order_url: order_url,
            timestamp: timestamp,
            elements: elements.collect { |element| element.to_hash },
            address: address.to_hash,
            summary: summary.to_hash,
            adjustments: adjustments.collect { |adjustment| adjustment.to_hash }
          }
        }
      end

    end
  end
end

# "attachment":{
#   "type":"template",
#   "payload":{
#     "template_type":"receipt",
#     "recipient_name":"Stephane Crozatier",
#     "order_number":"12345678902",
#     "currency":"USD",
#     "payment_method":"Visa 2345",        
#     "order_url":"http://petersapparel.parseapp.com/order?order_id=123456",
#     "timestamp":"1428444852", 
#     "elements":[
#       {
#         "title":"Classic White T-Shirt",
#         "subtitle":"100% Soft and Luxurious Cotton",
#         "quantity":2,
#         "price":50,
#         "currency":"USD",
#         "image_url":"http://petersapparel.parseapp.com/img/whiteshirt.png"
#       },
#       {
#         "title":"Classic Gray T-Shirt",
#         "subtitle":"100% Soft and Luxurious Cotton",
#         "quantity":1,
#         "price":25,
#         "currency":"USD",
#         "image_url":"http://petersapparel.parseapp.com/img/grayshirt.png"
#       }
#     ],
#     "address":{
#       "street_1":"1 Hacker Way",
#       "street_2":"",
#       "city":"Menlo Park",
#       "postal_code":"94025",
#       "state":"CA",
#       "country":"US"
#     },
#     "summary":{
#       "subtotal":75.00,
#       "shipping_cost":4.95,
#       "total_tax":6.19,
#       "total_cost":56.14
#     },
#     "adjustments":[
#       {
#         "name":"New Customer Discount",
#         "amount":20
#       },
#       {
#         "name":"$10 Off Coupon",
#         "amount":10
#       }
#     ]
#   }
# }