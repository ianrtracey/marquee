require 'sinatra'
require 'json'

# Github webhook endpoint
post '/payload' do
  push = JSON.parse(request.body.read)
  puts "I got some JSON: #{push.inspect}"
  return "success"
end
