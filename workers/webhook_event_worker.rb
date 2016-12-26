require 'json'
require './queue/worker'
require './config/environment'
require  './app/models/Repository'
require  './app/models/WebhookEvent'
require './app/services/repository_service'

class WebhookEventWorker < Worker
  def initialize(queue_name = "webhooks")
    super(queue_name)
    set_callback(method(:create_or_update_repo))
  end

  def create_or_update_repo(msg)
    puts "creating or updating repo"
    doc = JSON.parse(msg)
    event_message = WebhookEvent.new(:contents => doc)
    owner = event_message.owner
    repo = event_message.repo
    puts "#{owner} #{repo}"
    repository_service = RepositoryService.new(owner, repo)

    repository = Repository.where(owner: owner, name: repo)
      if repository.exists?
        puts "found existing repo"
        stats = repository_service.stats
        repository.update(stats: stats)
      else
        puts "new repo"
        binding.pry
        stats = repository_service.stats
        Repository.create(:owner => owner, :name => repo, :stats => stats)
      end
  end

  def observe
    puts "starting WebhookEventWorker"
    super
  end
end

webhook_event_worker = WebhookEventWorker.new
webhook_event_worker.observe


