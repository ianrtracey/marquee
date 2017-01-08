require 'mongoid'
require 'singleton'

class Meta
  include Singleton
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  field :last_recent_commiter_query, type: DateTime

  def self.instance
    if Meta.count == 0
      return self.create
    end
    return self.first
  end
end
