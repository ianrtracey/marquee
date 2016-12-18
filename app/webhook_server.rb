require 'sinatra'
require 'json'
require 'logger'

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

  Dir.mkdir('logs') unless File.exists?('logs')
  $logger = Logger.new('logs/event_messages.log')

  get '/' do
    File.read(File.join('public', 'index.html'))
  end


  post '/payload' do
    # # TODO: sercure this endpoint using https://developer.github.com/webhooks/securing/
    push_event = request.body.read
    # $logger.info(push_event)
    # # puts "EVENT: #{push_event}"
    # # # saves event - just in case
    # event_message = EventMessage.new(push_event)
    # event_message.save
    # # call to update repo
    # RepositoryService.update_repo(event_message)
    # event_queue.enqueue(push_event)
    # # process repo stats
    # repo_update_queue.enqueue(push_event)

    return "OK"
  end
end
