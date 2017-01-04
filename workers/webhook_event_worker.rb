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
    p event_message
    owner = event_message.owner
    repo = event_message.repo
    repository_service = RepositoryService.new(owner, repo)
    repository = Repository.find_or_create_by(:owner => owner, :name => repo)
    if not event_message.ping_event?
      repository.languages = repository_service.languages
      stats = repository_service.stats

      commit_stat = CommitStat.new(:total => stats["total"], :weeks => stats["weeks"])
      repository.commit_stat = commit_stat
    end
    repository.webhook_events << event_message
    repository.save
  end

  def observe
    puts "starting WebhookEventWorker"
    super
  end
end

webhook_event_worker = WebhookEventWorker.new
webhook_event_worker.observe


