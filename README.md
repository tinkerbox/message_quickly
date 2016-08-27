[![Code Climate](https://codeclimate.com/github/tinkerbox/message_quickly/badges/gpa.svg)](https://codeclimate.com/github/tinkerbox/message_quickly)
[![Test Coverage](https://codeclimate.com/github/tinkerbox/message_quickly/badges/coverage.svg)](https://codeclimate.com/github/tinkerbox/message_quickly/coverage)
[![Circle CI](https://circleci.com/gh/tinkerbox/message_quickly.svg?style=svg)](https://circleci.com/gh/tinkerbox/message_quickly)

# MessageQuickly

By [Tinkerbox Studios](https://www.tinkerbox.com.sg).

This gem is a lightweight solution to integrate [Facebook's Messenger Platform](https://developers.facebook.com/products/messenger/) into your rails app, allowing you to create bots to facilitate conversations with people on Facebook Messenger. It includes a mountable rails engine to handle [webhooks](https://developers.facebook.com/docs/messenger-platform/webhook-reference), and a simple client to talk to the [Send API](https://developers.facebook.com/docs/messenger-platform/send-api-reference).

We also have an [accompanying demo app](https://github.com/tinkerbox/messenger_platform_demo).

## Installation

Add this to your Gemfile, and then `bundle install`:

    gem 'message_quickly'

Generate the page access token on the [developer portal](https://developers.facebook.com), which will allow you to start using the APIs:

![Generate Page Access Token](https://cloud.githubusercontent.com/assets/19878/14728362/682e3ba0-0866-11e6-9b68-fe9d2a220d56.png)

With the token, make sure to run this:

    curl -ik -X POST "https://graph.facebook.com/v2.6/me/subscribed_apps?access_token=<page access token>"

Create the following environment variables:

    FACEBOOK_APP_ID=<facebook app id goes here>
    FACEBOOK_PAGE_ID=<your facebook page id>

    FACEBOOK_MESSENGER_VERIFICATION_TOKEN=my_voice_is_my_password_verify_me
    FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN=<generate this on the developer portal>

You will need to run your app, and make it accessible to the developer portal now, so run your server:

    rails server

Use something like [Burrow](https://burrow.io/) to provide access to your localhost:

![Create Tunnel on Burrow](https://cloud.githubusercontent.com/assets/19878/14728394/da5f99e4-0866-11e6-8b9c-dc788af4f296.png)

Go to your Facebook App page in the developer portal, and use the above verification token like so:

![New Page Subscription](https://cloud.githubusercontent.com/assets/19878/14728285/d1eaacaa-0865-11e6-98a6-dba8d62c1953.png)

Facebook will then verify with the mounted engine, and you're all set.

### Notes

Messenger Platform is designed to handle webhooks in background jobs on ActiveJob, so you should set up a queuing backend (e.g. Sidekiq) and configure ActiveJob to use it.

Your app is required to be served over HTTPS. When working locally, I used the default WEBrick server as it supports HTTPS connections out of the box.

## Usage

There are two parts to this gem: handling [webhooks](https://developers.facebook.com/docs/messenger-platform/webhook-reference) (which is what the rails engine is for), and calling the [Send API](https://developers.facebook.com/docs/messenger-platform/send-api-reference).

Additionally, there are some helpers for working with [messenger plugins](https://developers.facebook.com/docs/messenger-platform/plugin-reference).

### Webhooks

Webhooks allow the Facebook Messenger Platform to talk to your app. For example, you will receive a request on your webhook when a user authenticates or messages your Facebook page/app.

Mount the engine in your `routes.rb` (`/webhook` is used in the examples):

    mount MessageQuickly::Engine, at: "/webhook"

Generate the callback files:

    rails generate message_quickly:callbacks

When you run `rails generate callbacks`, four files will be created for you. They look something like this:

```ruby
class AuthenticationCallback < MessageQuickly::Callback

  def callback_name
    :messaging_optins
  end

  def run(event, json)
    # for e.g.
    # puts event.text
  end

end
```

All you need to do is make sure your app is available publicly, and to fill up the `run` method. All the four callbacks defined in the platform are supported this way:

Webhook Name | Callback Class | Description
-------------|----------------|------------
messaging_optins | AuthenticationCallback | Subscribes to authentication callbacks via the Send-to-Messenger Plugin
messages | MessageReceivedCallback | Subscribes to message-received callbacks
message_deliveries | MessageDeliveredCallback | Subscribes to message-delivered callbacks
message_reads | MessageReadCallback | Subscribes to message read callbacks
messaging_postbacks | PostbackCallback | Subscribes to postback callbacks
account_linking | AccountLinkingCallback | Subscribes to account linking callbacks

### Send API

By default, the API client will be created for you, and is accessible at:

    MessageQuickly::Api::Base.client

This makes use of the environment variables `FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN` and `FACEBOOK_MESSENGER_PAGE_ID`.

If you would like to use different sets of credentials in the app, you can create your own clients like so:

```ruby
send_api_client = MessageQuickly::Api::Client.new do |client|
  client.page_access_token = '<page access token goes here>'
  client.page_id = '<page id goes here>'
end

MessageQuickly::Api::UserProfile.new(send_api_client).find('<fb page specific user id here>')
```

#### Looking up a user's profile

Do note that we are using the default client, which is loaded automatically by default.

```ruby
MessageQuickly::Api::UserProfile.find('<fb page specific user id here>')
```

#### Creating a recipient object

You can create a recipient with either an `id`, or a `phone_number`. If both are provided, messages will be sent via the `id`.

```ruby
recipient = MessageQuickly::Messaging::Recipient.new(id: '123')
recipient = MessageQuickly::Messaging::Recipient.new(id: '123', phone_number: '+1(212)555-2368')
```

#### Sending a simple text message

```ruby
delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
  message.text = 'Hello'
end
```

#### Sending image attachments

![Image attachments](https://cloud.githubusercontent.com/assets/19878/14765512/92b33ac6-0a17-11e6-8673-164b7802c102.png)

You can either send an image attachment as a URL:

```ruby
delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
  message.build_attachment(:image) { |attachment| attachment.url = 'http://placehold.it/350x150' }
end
```

Or you can send it as a file:

```ruby
delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
  message.build_attachment(:image) do |attachment|
    attachment.file = "spec/fixtures/12057251_909506139117248_2059695706_n.png"
    attachment.file_type = 'image/png'
  end
end
```

#### Sending a generic template attachment

![Generic template attachment](https://cloud.githubusercontent.com/assets/19878/14765514/9bd0ec48-0a17-11e6-8988-bb3652213285.png)

```ruby
delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
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
```

#### Sending a button template attachment

```ruby
delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
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
```

#### Sending an account linking button

```ruby
delivery = MessageQuickly::Api::Messages.create(recipient) do |message|

  message.build_attachment(:button_template) do |template|

    template.text = 'Please log in'

    template.build_button(:account_link) do |button|
      button.url = 'https://www.example.com/oauth/authorize'
    end

  end
end
```

#### Sending a receipt template attachment

![Receipt template attachment](https://cloud.githubusercontent.com/assets/19878/14765517/ab69af46-0a17-11e6-8700-17ae8b7d1e53.png)

```ruby
delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
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
```

#### Sending quick replies

```ruby
delivery = MessageQuickly::Api::Messages.create(recipient) do |message|

  message.text = "Pick a color:"

  message.build_quick_reply do |quick_reply|
    quick_reply.title = 'Green'
    quick_reply.payload = 'DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_GREEN'
  end

  message.build_quick_reply do |quick_reply|
    quick_reply.title = 'Red'
    quick_reply.payload = 'DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED'
  end

end
```

### Plugins

This is optional, and only necessary if you want to add the 'Send to Messenger' or 'Message Us' [buttons](https://developers.facebook.com/docs/messenger-platform/plugin-reference) to your app, shown here:

![Messenger plugins](https://cloud.githubusercontent.com/assets/19878/14765515/a16c57a0-0a17-11e6-8fec-b9798610b8bf.png)

Firstly, add the javascript require to your manifest file:

    //= require message_quickly

Then, in your view templates (presumably slim), add:

    = send_to_messenger
    = message_us

You can also customize them as such:

    = send_to_messenger(size: 'large')
    = message_us(size: 'xlarge', color: 'white')

For size, supported values include `standard`, `large` and `xlarge`, while color supports `blue` and `white` only.

## Development & Contributing

Set up your `.env` file like so:

    FACEBOOK_MESSENGER_VERIFICATION_TOKEN=my_voice_is_my_password_verify_me
    FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN=<generate this on the developer portal>
    FACEBOOK_MESSENGER_PAGE_ID=<your facebook page id>
    FACEBOOK_MESSENGER_USER_ID=<your own facebook profile id>
    FACEBOOK_MESSENGER_USER_FIRST_NAME=<your own facebook profile's first name>
    FACEBOOK_MESSENGER_USER_LAST_NAME=<your own facebook profile's last name>
    FACEBOOK_APP_ID=<your facebook app id>

You will need your own Facebook profile id if you are to run the specs. Run them now with:

    rake

Things on the roadmap include:

* simplify callback names
* catch FacebookApiException errors, can't generate one in the wild yet
* support for customer matching (US-based page required), done but not tested yet
* support for more complex welcome messages
* use webmock to disallow remote requests in specs

## Credits

This gem was created by [Jaryl Sim](http://github.com/jaryl). See [MIT-LICENSE](MIT-LICENSE) for details.
