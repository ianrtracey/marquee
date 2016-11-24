require 'httparty'
require './utils/service_tools.rb'

class RepositoryService
  include HTTParty
  extend  ServiceTools

  base_uri 'https://api.github.com'

  request_to_hash :languages

  def initialize(owner=nil, repo=nil)
    @owner = owner
    @repo = repo
  end

  def stats
    self.class.get("/repos/#{@owner}/#{@repo}/stats/contributors")
  end

  def languages
    self.class.get("/repos/#{@owner}/#{@repo}/languages")
  end

end
