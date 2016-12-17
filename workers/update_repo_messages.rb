require './models'
require './queue/worker'
require './queue/event_queue'
require './services/repository_service'
require 'mongo'
require 'json'
require 'pry'

def update_repo_stats(msg)
  puts "updating repos"
  parsed_event_message = JSON.parse(msg)
  event_message = EventMessage.new(parsed_event_message)
  owner = event_message.owner["name"]
  repo = event_message.repo["name"]
  repo_service = RepositoryService.new(owner, repo)
  # update or create

  client = Mongo::Client.new('mongodb://127.0.0.1:27017/marquee')
  collection = client[:repos]

  result = collection.update_one({:owner => owner, :repo => repo},{upsert: true})
  puts result.n
end


worker = Worker.new('repo_update_events')
worker.set_callback(method(:update_repo_stats))
worker.observe

