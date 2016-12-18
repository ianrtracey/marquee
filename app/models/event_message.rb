class EventMessage
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

