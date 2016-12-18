require 'json'
require 'spec_helper'

RSpec.describe RepositoryService do
  def get_raw_e
    f = File.open('./spec/event_message_sample.json', 'r')
    raw_event_message = JSON.parse(f.read)
    raw_event_message
  end

  describe "repo stats" do
    it "can get repo stats from github" do
      incoming_event_message = get_raw_e
      event_message = EventMessage.new(incoming_event_message)
      repository_service = RepositoryService.new(event_message)
      repo_stats = repository_service.stats
      expect(repo_stats.keys).to include("total")
      expect(repo_stats.keys).to include("weeks")
    end

    it "can get language stats from github" do
      incoming_event_message = get_raw_e
      event_message = EventMessage.new(incoming_event_message)
      repository_service = RepositoryService.new(event_message)
      languages = repository_service.languages
      expect(languages.keys).to_not eq(0)
    end
  end
end
