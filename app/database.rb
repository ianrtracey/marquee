require 'mongo'

module Database
  URI = '127.0.0.1:27017'
  DB_NAME = 'test'

  def self.get_client
   Mongo::Client.new([ URI ], :database => DB_NAME)
  end

  def self.save(doc, collection_name)
    puts "attempting to save #{doc.inspect} #{collection_name}"
    client = get_client
    collection = client[collection_name]
    result = collection.insert_one(doc)
    result.n
  end

  def collection_name
    self.class.name.downcase.to_sym
  end

  def find(attrs, collection)
    client = get_client
    collection = client[collection]
    collection.find(attrs).first
  end

end
