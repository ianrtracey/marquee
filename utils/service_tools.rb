require 'securerandom'
require 'json'

module ServiceTools
  def request_to_hash(function)
    guid = SecureRandom.uuid
    define_method("#{guid}") do |*args, &block|
      result = __send__("#{guid}_#{function}", *args, &block)
      JSON.parse(result.body)
    end
    alias_method "#{guid}_#{function}", function
    alias_method event, "#{guid}"
  end
end
