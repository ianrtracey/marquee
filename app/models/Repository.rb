require 'mongoid'
class Repository
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  has_many :webhook_events
  embeds_one :commit_stat

  field :owner, type: String
  field :name, type: String
  field :languages, type: Hash

end

# currently not used
class CommitStat
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  embedded_in :repository

  field :total, type: Integer
  field :weeks, type: Array

  def total_lines
    self.weeks.reduce(0) do |sum, commit|
      sum += commit["a"] # number of additions
      sum += -commit["d"] # number of delections
      sum
    end
  end
  def num_commits
    self.total
  end
end
