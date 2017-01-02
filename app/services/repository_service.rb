require 'httparty'
require_relative './service'
require 'yaml'

class RepositoryService < Service
  include HTTParty

  base_uri 'https://api.github.com'


  def initialize(owner, repo, max_retries=3)
    @owner = owner
    @repo = repo
    @max_retries = max_retries
    # need to check if file is there and throw an exception
    config = YAML.load_file('./config/application.yml')
    client_id = config['api']['github']['client_id']
    client_secret = config['api']['github']['client_secret']
    auth = "?client_id=#{client_id}&client_secret=#{client_secret}"
    @auth = auth
  end
# the duplication across stats and languages needs to be abstracted into a single method
  def stats
    begin
      resp = self.class.get("/repos/#{@owner}/#{@repo}/stats/contributors#{@auth}")
      if resp.code != 200 || resp.parsed_response[0].nil?
        raise RepositoryServiceError
      end
    rescue RepositoryServiceError => error
      num_retries ||=  0
      if num_retries < @max_retries
        puts "repository call went wrong, trying again..."
        num_retries += 1
        sleep 1
        retry
      else
        raise StandardError, "repository service couldnt get a response"
      end
    end
    return resp.parsed_response[0]
  end

  def languages
    begin
      resp = self.class.get("/repos/#{@owner}/#{@repo}/languages#{@auth}")
      if resp.code != 200 || resp.parsed_response.nil?
        raise RepositoryServiceError
      end
    rescue RepositoryServiceError => error
      num_retries ||=  0
      if num_retries < @max_retries
        puts "repository call went wrong, trying again..."
        num_retries += 1
        sleep 1
        retry
      else
        raise StandardError, "repository service couldnt get a response"
      end
    end
    return resp.parsed_response
  end

end

class RepositoryServiceError < StandardError
  def initialize(msg="Respository Service is unavailable")
    super
  end
end
