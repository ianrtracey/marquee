require 'sinatra'
require 'sinatra/activerecord'
require './environments'

class Repo < ActiveRecord::Base
end

# class that is used in the response to the dashboard
class Activity
  attr_accessor :total_commits, :total_additions, :recent_commiters
end
