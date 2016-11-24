require 'mongo'
require 'json'


client = Mongo::Client.new('mongodb://127.0.0.1:27017/marquee')
collection = client[:repos]
collection.find.each do |repo|
p repo
end

