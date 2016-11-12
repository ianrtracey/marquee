require 'bunny'
require_relative './broker'

class EventQueue < Broker

  def initialize(name)
    super(name)
  end

  def enqueue(message)
    @queue.publish(message, :persistent => true)
  end

  def close
    @connection.close
  end
end
