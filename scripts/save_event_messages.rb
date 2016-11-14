require './queue/worker'
require 'mongo'

def save_message(msg)
  puts "saving message"
  client = Mongo::Client.new('mongodb://127.0.0.1:27017/marquee')
  collection = client[:eventmessage]
  result = collection.insert_one({:contents => msg})
  puts result.n
end

worker = Worker.new('push_events')
worker.set_callback(method(:save_message))
worker.observe


