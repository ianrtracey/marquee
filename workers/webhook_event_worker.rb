require 'json'
require './queue/worker'
require  './app/models/Repository'
require './app/services/repository_service'

class WebhookEventWorker < Worker
  def initialize(queue_name = "webhooks")
    super(queue_name)
    set_callback(method(:create_or_update_repo))
  end

  def create_or_update_repo(msg)
    puts "creating or updating repo"
    doc = JSON.parse(msg)
    event_message = EventMessage.new(doc)
    owner = event_message.owner
    repo = event_message.repo
    repository_service = RepositoryService.new(owner, repo)

    repository = Repository.where(owner: owner, repo: repo)
      if repository.exist?
        stats = repository_service.stats
        repository.update(stats: stats)
      else
        stats = repository_service.stats
        Repository.create(:owner => owner, :name => repo, :stats => stats)
      end
  end

  def observe
    puts "starting WebhookEventWorker"
    super
  end

end
