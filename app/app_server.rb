require 'sinatra'
require 'json'
require 'logger'

require './services/activity_service'


class AppServer < Sinatra::Base

  Dir.mkdir('logs') unless File.exists?('logs')
  $logger = Logger.new('logs/app_server.log')

  get '/' do
    return 'OK'
  end

  get '/activity' do
    activity = ActivityService.get_activity
    JSON.dump(activity)
  end

end
