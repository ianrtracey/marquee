require 'json'
require 'spec_helper'

RSpec.describe Repository do
  def get_raw_e
    f = File.open('./spec/event_message_sample.json', 'r')
    raw_event_message = JSON.parse(f.read)
    raw_event_message
  end

  describe "persistence" do
    it "can save repository stats data" do
      incoming_event_message = get_raw_e
      expect(Repository.count).to eq(0)
      webhook_event = WebhookEvent.new(:contents => incoming_event_message)
      repo_service = RepositoryService.new(webhook_event.owner, webhook_event.repo)
      repository = Repository.new(:owner => webhook_event.owner, :name => webhook_event.repo)
      repository.languages = repo_service.languages
      stats = repo_service.stats
      commit_stats = CommitStat.new(:total => stats["total"], :weeks => stats["weeks"])
      repository.commit_stat = commit_stats
      repository.webhook_events << webhook_event
      repository.save
      expect(Repository.count).to eq(1)
      binding.pry
      repository = Repository.last
      expect(repository.name).to eq("marquee")
      expect(repository.owner).to eq("ianrtracey")
      expect(repository.webhook_events.size).to eq(1)
      expect(repository.commit_stat.keys).to eq(2)
      expect(repository.languages.keys).to_not eq(0)
    end
  end
end

