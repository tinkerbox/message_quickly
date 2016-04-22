[![Code Climate](https://codeclimate.com/github/tinkerbox/messenger_platform/badges/gpa.svg)](https://codeclimate.com/github/tinkerbox/messenger_platform)
[![Test Coverage](https://codeclimate.com/github/tinkerbox/messenger_platform/badges/coverage.svg)](https://codeclimate.com/github/tinkerbox/messenger_platform/coverage)
[![Circle CI](https://circleci.com/gh/tinkerbox/messenger_platform.svg?style=svg)](https://circleci.com/gh/tinkerbox/messenger_platform)

# Messenger Platform

By [Tinkerbox Studios](https://www.tinkerbox.com.sg).

This gem is a lightweight solution to integrate [Facebook's messenger platform](https://developers.facebook.com/products/messenger/) into your rails app, allowing you to create bots to facilitate conversations with people on Facebook Messenger. It includes a mountable rails engine to handle [webhooks](https://developers.facebook.com/docs/messenger-platform/webhook-reference), and a simple client to talk to the [Send API](https://developers.facebook.com/docs/messenger-platform/send-api-reference).

We also have an [accompanying demo app](https://github.com/tinkerbox/messenger_platform_demo).

## Installation

Add this to your Gemfile, and then `bundle install`:

    gem 'messenger_platform'

Generate the callback files:

    rails generate callbacks

Mount the engine in your `routes.rb` (`\webhook` is used in the examples):

    mount MessengerPlatform::Engine, at: "/webhook"

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

    rail server

Use something like [Burrow](https://burrow.io/) to provide access to your localhost:

![Create Tunnel on Burrow](https://cloud.githubusercontent.com/assets/19878/14728394/da5f99e4-0866-11e6-8b9c-dc788af4f296.png)

Go to your Facebook App page in the developer portal, and use the above verification token like so:

![New Page Subscription](https://cloud.githubusercontent.com/assets/19878/14728285/d1eaacaa-0865-11e6-98a6-dba8d62c1953.png)

Facebook will then verify with the mounted engine, and you're all set.

## Usage

There are two parts to this gem: handling [webhooks](https://developers.facebook.com/docs/messenger-platform/webhook-reference) (which is what the rails engine is for), and calling the [Send API](https://developers.facebook.com/docs/messenger-platform/send-api-reference).

### Webhooks

When you run `rails generate callbacks`, four files will be created for you. They look something like this:

```
class AuthenticationCallback < MessengerPlatform::Callback

  def callback_name
    :messaging_optins
  end

  def run(event)
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
messaging_postbacks | PostbackCallback | Subscribes to postback callbacks

### Send API

By default, the API client will be created for you, and is accessible at:

    MessengerPlatform::Api::Base.client

This makes use of the environment variables `FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN` and `FACEBOOK_MESSENGER_PAGE_ID`.

You can also create your own instances like so:

```
@send_api_client = MessengerPlatform::Api::Client.new do |client|
  client.page_access_token = '<page access token goes here>'
  client.page_id = '<page id goes here>'
end
```

This is still a work in progress, and further documentation will be provided.

## Development & Contributing

Set up your `.env` file like so:

    FACEBOOK_MESSENGER_VERIFICATION_TOKEN=my_voice_is_my_password_verify_me
    FACEBOOK_MESSENGER_PAGE_ACCESS_TOKEN=<generate this on the developer portal>
    FACEBOOK_MESSENGER_PAGE_ID=<your facebook page id>
    FACEBOOK_MESSENGER_USER_ID=<your own facebook profile id>

You will need your own profile id if you are to run the specs. Run them now with:

    rake

Things on the roadmap include:

* simplify usage of the Send API
* support for structured templates
* improve on exception handling
* helpers for generating [messenger plugins](https://developers.facebook.com/docs/messenger-platform/plugin-reference)
* support for customer matching

## Credits

This gem was created by [Jaryl Sim](http://github.com/jaryl). See [MIT-LICENSE](MIT-LICENSE) for details.
