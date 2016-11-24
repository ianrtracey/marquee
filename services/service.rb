require 'json'

class Service

  def self.before_request_actions
    @before_request_actions ||= []
  end

  def self.after_request_actions
    @after_request_actions ||= []
  end

  def self.before_request(callback)
    before_request_actions << callback
  end

  def self.after_request(callback)
    after_request_actions << callback
  end

  def self.inherited(child_class)
    before_request_actions.each { |f| child_class.before_request_actions << f }
    after_request_actions.each { |f| child_class.after_request_actions << f }
  end

  def request(action)
    self.class.before_request_actions.each { |callback| send(callback) }
    send(action)
    self.class.after_request_actions.each { |callback| send(callback) }
  end

  def get(action)
    response = send(action)
    JSON.parse(response.body)
  end
end
