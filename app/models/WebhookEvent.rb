class WebhookEvent
  include Mongoid::Document
  belongs_to :repository

  field :contents, type: Hash

  def ping_event?
    self.contents.has_key? 'hook_id'
  end

  def owner
    result = self.contents['repository']['owner']['name']
    result ||= self.contents['repository']['owner']['login']
    return result
  end

  def repo
    self.contents['repository']['name']
  end


end
