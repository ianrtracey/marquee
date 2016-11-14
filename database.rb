require 'mongo'

module Database
  URI = '127.0.0.1:27017'
  DB_NAME = 'test'

  def self.save(doc, collection_name)
   client = Mongo::Client.new([ URI ], :database => DB_NAME)
    collection = client[collection_name]
    result = collection.insert_one(doc)
    result.n
  end

  def collection_name
    self.class.name.downcase.to_sym
  end

end
