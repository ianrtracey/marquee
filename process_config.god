God.watch do |w|
  w.name = "WebhookEventWorker"
  w.start = 'bundle exec ruby ./workers/webhook_event_worker.rb'
end
