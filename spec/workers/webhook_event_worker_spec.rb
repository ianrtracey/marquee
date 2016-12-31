require 'json'
require 'spec_helper'

# RSpec.describe WebhookEventWorker do
#   def get_webhook_event
#     f = File.open('./spec/event_message_sample.json', 'r')
#     f.read
#   end
#
#
#   describe "worker responding to incoming webhook events" do
#     xit "can save the associated repo information from a webhook event" do
#       expect(Repository.count).to eq(0)
#       webhook_event_worker = WebhookEventWorker.new
#       msg = get_webhook_event
#       webhook_event_worker.create_or_update_repo(msg)
#       expect(Repository.count).to eq(1)
#     end
#
#     # need to work to test queueing and async events
#     xit "can respond to EventQueue messages" do
#       expect(Repository.count).to eq(0)
#       webhook_event_worker = WebhookEventWorker.new
#       Process.spawn { webhook_event_worker.observe }
#       event_queue = EventQueue.new("webhooks")
#       webhook_event = get_webhook_event
#       msg = JSON.dump(webhook_event)
#       event_queue.enqueue(msg)
#     end
#   end
# end
#
