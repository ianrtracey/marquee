require 'bunny'
require_relative './broker'

class Worker < Broker
  def initialize(name)
    super(name)
    @channel.prefetch(1)
    @callback = nil
  end

  def set_callback(callback)
    @callback = callback
  end

  def observe
    begin
      @queue.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
        puts body
        @channel.ack(delivery_info.delivery_tag)
      end
    rescue Interrupt => _
      conn.close
    end
  end
end
