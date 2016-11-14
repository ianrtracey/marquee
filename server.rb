require 'sinatra'
require 'json'
require_relative './queue/event_queue.rb'
require_relative './environments'

begin
  event_queue = EventQueue.new("push_events")
rescue
  puts "cannot connect to EventQueue"
end

set :public_folder, 'public'
set :static, true

# Github webhook endpoint
get '/' do
  File.read(File.join('public', 'index.html'))
end


post '/payload' do
  # TODO: sercure this endpoint using https://developer.github.com/webhooks/securing/
  push_event = request.body.read
  logger.info "EVENT: #{push_event}"
  event_queue.enqueue(push_event)
  return "OK"
end
