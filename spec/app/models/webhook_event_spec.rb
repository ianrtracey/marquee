require 'json'
require 'spec_helper'

RSpec.describe WebhookEvent do
  def get_raw_e
    f = File.open('./spec/event_message_sample.json', 'r')
    raw_event_message = JSON.parse(f.read)
    raw_event_message
  end

  describe "field mapping" do
    it "can map repo information" do
      incoming_event_message = get_raw_e
      webhook_event = WebhookEvent.new(:contents => incoming_event_message)
      expect(webhook_event.owner).to eq("ianrtracey")
      expect(webhook_event.repo).to eq("marquee")
    end
  end
end

