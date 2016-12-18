require 'httparty'
require_relative './service'

class RepositoryService < Service
  include HTTParty

  base_uri 'https://api.github.com'


  def initialize(event_message)
    @owner = event_message.owner["name"]
    @repo = event_message.repo["name"]
  end


  def stats
    self.class.get("/repos/#{@owner}/#{@repo}/stats/contributors").parsed_response[0]
  end

  def languages
    self.class.get("/repos/#{@owner}/#{@repo}/languages").parsed_response
  end

end
