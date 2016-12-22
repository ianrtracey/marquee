require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

Mongoid.load!(File.expand_path('mongoid.yml', './config'))

require "active_support/deprecation"
require "active_support/all"
