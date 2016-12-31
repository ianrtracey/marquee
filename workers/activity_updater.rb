require 'json'
require './queue/worker'
require './config/environment'
require  './app/models/Repository'
require  './app/models/WebhookEvent'
require './app/services/repository_service'

class ActivityUpdater < Worker
  def initialize(queue_name = "activity_updates")
    super(queue_name)
    set_callback(method(:aggegrate_activity))
  end

  def aggregate_activity
  end
end
