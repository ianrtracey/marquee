class WebhookEvent
  include Mongoid::Document
  belongs_to :respository

  field :contents, type: Hash

  def owner
    self.contents['repository']['owner']['name']
  end

  def repo
    self.contents['repository']['name']
  end


end
