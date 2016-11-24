require './queue/worker'
require './queue/event_queue'
require './services/repository_service'
require 'mongo'
require 'json'

def update_repo_stats(msg)
  puts "saving message"
  parsed_event_message = JSON.parse(msg)
  event_message = EventMessage.new(parsed_event_message)
  owner = event_message.owner
  repo = event_message.repo
  repo_service = RepositoryService.new(owner, repo)
  # update or create

  client = Mongo::Client.new('mongodb://127.0.0.1:27017/marquee')
  collection = client[:repos]

  result = collection.update({:owner => owner, :repo => repo},{upsert: true})
  puts result.n
end

def send_message_to_processor(msg)
  puts "sending message to processor"
end

worker = Worker.new('repo_update_events')
worker.set_callback(method(:update_repo_stats))
worker.observe

