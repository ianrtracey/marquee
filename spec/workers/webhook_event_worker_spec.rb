require 'json'
require 'spec_helper'

RSpec.describe WebhookEventWorker do
  def get_raw_e
    f = File.open('./spec/event_message_sample.json', 'r')
    raw_event_message = JSON.parse(f.read)
    raw_event_message
  end


  describe "worker responding to incoming webhook events" do
    it "can save the associated repo information from a webhook event" do
      event_queue = EventQueue.new("webhooks")
      webhook_event_worker = WebhookEventWorker.new
      # this needs to be nonblocking in order to test this
      webhook_event_worker.observe
      msg = get_raw_e
      event_queue.enqueue(msg)
    end
  end
end

