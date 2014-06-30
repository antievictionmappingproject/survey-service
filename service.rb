require 'sinatra'
require 'json'

get '/survey/:id' do |id|
  content_type :json
  { :id => id, :address => '409B Duncan Street' }.to_json
end