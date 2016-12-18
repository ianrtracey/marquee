require 'json'
require 'spec_helper'

RSpec.describe EventMessage do
  def get_raw_e
    f = File.open('./spec/event_message_sample.json', 'r')
    raw_event_message = JSON.parse(f.read)
    raw_event_message
  end

  describe "field mappings" do
    it "can map owner information" do
      incoming_event_message = get_raw_e
      event_message = EventMessage.new(incoming_event_message)
      expect(event_message.owner.keys).to include("email")
      expect(event_message.owner.keys).to include("name")
    end
    it "can map repo information" do
      incoming_event_message = get_raw_e
      event_message = EventMessage.new(incoming_event_message)
      p event_message.repo
      expect(event_message.repo.keys.count).to_not eq(0)
    end
  end
end

