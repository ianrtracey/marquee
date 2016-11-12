class Broker
  attr_reader :connection, :channel, :queue

  def initialize(name)
    conn = Bunny.new
    conn.start
    @connection = conn
    @channel = conn.create_channel
    @queue = @channel.queue(name, :durable => true)
  end

end
