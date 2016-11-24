require 'httparty'
require_relative './service'

class RepositoryService < Service
  include HTTParty

  base_uri 'https://api.github.com'

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
