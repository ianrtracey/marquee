require './database'

class Model
  include Database
end

class EventMessage < Model
  attr_accessor :contents

  def initialize(contents)
    @contents = contents
  end

  def owner
  end

  def repo
  end

end
