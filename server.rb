require 'sinatra'
require 'json'
require_relative './queue/event_queue.rb'
require_relative './environments'

event_queue = EventQueue.new('push_events')

# Github webhook endpoint
post '/payload' do
  # TODO: sercure this endpoint using https://developer.github.com/webhooks/securing/
  push_event = request.body.read
  logger.info "EVENT: #{push_event}"
  event_queue.enqueue(push_event)
  return "OK"
end
