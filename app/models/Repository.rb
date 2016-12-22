require 'mongoid'
class Repository
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  has_many :webhook_events
  embeds_many :commits

  field :owner, type: String
  field :name, type: String
  field :languages, type: Hash
  field :stats, type: Hash

  attr_accessor :owner, :name, :languages, :stats
end

# currently not used
class Commit
  include Mongoid::Document
  embedded_in :repository

  field :total, type: Integer
  field :weeks, type: Array
end
