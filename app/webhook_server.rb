require 'sinatra'
require 'json'
require 'logger'
require './queue/event_queue'
require './app/services/activity_service'
require './config/environment'

begin
  $event_queue = EventQueue.new("webhooks")
rescue => e
  puts "cannot connect to EventQueue: #{e}"
  exit 1
end

class WebhookServer < Sinatra::Base

  before do
    content_type :json
    headers 'Access-Control-Allow-Origin' => '*',
      'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
  end

  set :protection, false


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

  get '/activity' do
    activity = ActivityService.get_activity
    JSON.dump(activity)
  end

end
