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
      repository = Repository.new(:owner => webhook_event.owner, :name => webhook_event.repo)
      expect(repository.name).to eq("marquee")
      expect(repository.owner).to eq("ianrtracey")
      repo_service = RepositoryService.new(repository.owner, repository.name)
      repository.stats = repo_service.stats
      repository.languages = {}
      repository.save
      binding.pry
      expect(Repository.count).to eq(1)
      expect(Repository.first.stats.keys.size).to_not eq(0)
    end
  end
end

