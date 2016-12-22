require 'sinatra'
require 'json'
require 'logger'
require './queue/event_queue'

begin
  $event_queue = EventQueue.new("webhooks")
rescue => e
  puts "cannot connect to EventQueue: #{e}"
  exit 1
end

class WebhookServer < Sinatra::Base

  Dir.mkdir('logs') unless File.exists?('logs')
  $logger = Logger.new('logs/event_messages.log')

  get '/' do
    return 'OK'
  end


  post '/payload' do
    # # TODO: sercure this endpoint using https://developer.github.com/webhooks/securing/
    push_event = request.body.read
    $logger.info(push_event)
    $event_queue.enqueue(push_event)
    return "OK"
  end
end
