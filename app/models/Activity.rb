require 'mongoid'
class Repository
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :commits, type: Integer
  field :lines_code, type: Integer
  field :repository_num, type: Integer

end
