class WebhookEvent
  include MongoMapper::Document
  belongs_to :repository

  key :contents
  timestamps!
end
