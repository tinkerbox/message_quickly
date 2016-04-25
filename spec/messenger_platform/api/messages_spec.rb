require 'spec_helper'

describe MessengerPlatform::Api::Messages do

  subject { MessengerPlatform::Api::Messages }

  let(:recipient) { MessengerPlatform::Messaging::Recipient.new(id: ENV['FACEBOOK_MESSENGER_USER_ID']) }

  describe '#create' do

    context 'with own client' do

      let(:client) { MessengerPlatform::Api::Client.new(page_access_token: ENV['FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN'], page_id: ENV['FACEBOOK_MESSENGER_PAGE_ID']) }

      it 'should be able to send text' do
        delivery = subject.new(client).create(recipient) do |message|
          message.text = 'Hello'
        end
        expect(delivery.id).not_to be_nil
      end

    end

    context 'with invalid recipient' do

      let(:recipient) { MessengerPlatform::Messaging::Recipient.new(id: 'invalid') }

      it 'should raise an exception' do
        expect do
          subject.create(recipient) do |message|
            message.text = 'Hello'
          end
        end.to raise_exception(MessengerPlatform::Api::OauthException)
      end

    end

    context 'with a valid recipient' do

      it 'should be able to send text' do
        delivery = subject.create(recipient) do |message|
          message.text = 'Hello'
        end
        expect(delivery.id).not_to be_nil
      end

      it 'should be able to send with an image url attachment' do
        delivery = subject.create(recipient) do |message|
          message.build_attachment(:image) { |attachment| attachment.url = 'http://placehold.it/350x150' }
        end
        expect(delivery.id).not_to be_nil
      end

      it 'should be able to send with an image file attachment' do
        delivery = subject.create(recipient) do |message|
          message.build_attachment(:image) do |attachment|
            attachment.file = "spec/fixtures/12057251_909506139117248_2059695706_n.png"
            attachment.file_type = 'image/png'
          end
        end
        expect(delivery.id).not_to be_nil
      end

      it 'should be able to send with a generic template attachment' do
        delivery = subject.create(recipient) do |message|
          message.build_attachment(:generic_template) do |template|

            template.build_element do |element|

              element.title = "Classic White T-Shirt"
              element.image_url = 'http://petersapparel.parseapp.com/img/item100-thumb.png'
              element.subtitle = 'Soft white cotton t-shirt is back in style'

              element.build_button(:web_url) do |button|
                button.url = "https://petersapparel.parseapp.com/view_item?item_id=100"
                button.title = "View Item"
              end

              element.build_button(:web_url) do |button|
                button.url = "https://petersapparel.parseapp.com/buy_item?item_id=100"
                button.title = "Buy Item"
              end

              element.build_button(:postback) do |button|
                button.payload = "USER_DEFINED_PAYLOAD_FOR_ITEM100"
                button.title = "Bookmark Item"
              end

            end

            template.build_element do |element|

              element.title = "Classic Grey T-Shirt"
              element.image_url = 'http://petersapparel.parseapp.com/img/item101-thumb.png'
              element.subtitle = 'Soft gray cotton t-shirt is back in style'

              element.build_button(:web_url) do |button|
                button.url = "https://petersapparel.parseapp.com/view_item?item_id=101"
                button.title = "View Item"
              end

              element.build_button(:web_url) do |button|
                button.url = "https://petersapparel.parseapp.com/buy_item?item_id=101"
                button.title = "Buy Item"
              end

              element.build_button(:postback) do |button|
                button.payload = "USER_DEFINED_PAYLOAD_FOR_ITEM101"
                button.title = "Bookmark Item"
              end

            end

          end
        end
        expect(delivery.id).not_to be_nil
      end

      it 'should be able to send with a button template attachment' do
        delivery = subject.create(recipient) do |message|
          message.build_attachment(:button_template) do |template|

            template.text = 'How are you doing today?'

            template.build_button(:web_url) do |button|
              button.url = 'https://petersapparel.parseapp.com'
              button.title = 'Show Website'
            end

            template.build_button(:postback) do |button|
              button.payload = 'USER_DEFINED_PAYLOAD'
              button.title = 'Start Chatting'
            end

          end
        end
        expect(delivery.id).not_to be_nil
      end

      it 'should be able to send with a receipt template attachment' do
        delivery = subject.create(recipient) do |message|
          message.build_attachment(:receipt_template) do |template|

            template.recipient_name = 'Stephane Crozatier'
            template.order_number = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
            template.currency = 'USD'
            template.payment_method = 'Visa 2345'
            template.order_url = 'http://petersapparel.parseapp.com/order?order_id=123456'
            template.timestamp = '1428444852'

            template.build_element do |element|
              element.title = 'Classic White T-Shirt'
              element.subtitle = '100% Soft and Luxurious Cotton'
              element.quantity = 2
              element.price = 50
              element.currency = 'USD'
              element.image_url = 'http://petersapparel.parseapp.com/img/whiteshirt.png'
            end

            template.build_element do |element|
              element.title = 'Classic Gray T-Shirt'
              element.subtitle = '100% Soft and Luxurious Cotton'
              element.quantity = 1
              element.price = 25
              element.currency = 'USD'
              element.image_url = 'http://petersapparel.parseapp.com/img/grayshirt.png'
            end

            template.build_address do |address|
              address.street_1 = "1 Hacker Way"
              address.street_2 = ""
              address.city = "Menlo Park"
              address.postal_code = "94025"
              address.state = "CA"
              address.country = "US"
            end

            template.build_summary do |summary|
              summary.subtotal = 75.00
              summary.shipping_cost = 4.95
              summary.total_tax = 6.19
              summary.total_cost = 56.14
            end

            template.build_adjustment do |adjustment|
              adjustment.name = "New Customer Discount"
              adjustment.amount = 20
            end

            template.build_adjustment do |adjustment|
              adjustment.name = "$10 Off Coupon"
              adjustment.amount = 10
            end

          end
        end
        expect(delivery.id).not_to be_nil
      end

    end

  end

end
