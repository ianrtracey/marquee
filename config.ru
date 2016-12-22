require 'bundler/setup'
Bundler.require(:default)

require File.dirname(__FILE__) + "/app/webhook_server.rb"

map '/' do
  run WebhookServer
end

