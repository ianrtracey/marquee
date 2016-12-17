require 'sinatra'
require 'json'
require_relative './queue/event_queue.rb'
require_relative './environments'

# begin
#   event_queue = EventQueue.new("push_events")
#   repo_update_queue = EventQueue.new("repo_update_events")
# rescue
#   puts "cannot connect to EventQueue"
#   exit 1
# end

class WebhookServer < Sinatra::Base
  set :public_folder, 'public'
  set :static, true

  get '/' do
    File.read(File.join('public', 'index.html'))
  end


  post '/payload' do
    # # TODO: sercure this endpoint using https://developer.github.com/webhooks/securing/
    push_event = request.body.read
    # puts "EVENT: #{push_event}"
    # # saves event - just in case
    # event_queue.enqueue(push_event)
    # # process repo stats
    # repo_update_queue.enqueue(push_event)

    return "OK"
  end
end
