MessageQuickly::Engine.routes.draw do
  get '/' => 'webhooks#verify'
  post '/' => 'webhooks#callback'
end
