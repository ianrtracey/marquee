require_relative './WebhookEvent'

class Repository
  include MongoMapper::Document
  many :webhook_events
  many :commits

  key :owner, String
  key :name, String
  key :languages, Object
  key :stats, Object
  timestamps!
end


class Commits
  include MongoMapper::EmbeddedDocument

  key :total, Integer
  key :weeks, Array
end
