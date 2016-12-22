require 'httparty'
require_relative './service'

class RepositoryService < Service
  include HTTParty

  base_uri 'https://api.github.com'


  def initialize(owner, repo)
    @owner = owner
    @repo = repo
  end

  def stats
    resp = self.class.get("/repos/#{@owner}/#{@repo}/stats/contributors")
    if resp.code != 200
      return nil
    end
    return resp.parsed_response[0]
  end

  def languages
    resp = self.class.get("/repos/#{@owner}/#{@repo}/languages")
    if resp.code != 200
      return nil
    end
    return resp.parsed_response
  end

end
