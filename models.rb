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
    repo["owner"]
  end

  def repo
    @contents["repository"]
  end

end


class Repository < Model
  attr_accessor :stats, :languages

  def initialize(stats=nil, languages=nil)
    @stats = stats
    @languages = languages
  end
end

