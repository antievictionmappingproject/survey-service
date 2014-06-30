require 'sinatra'
require 'json'
require './models/survey'

get '/survey/:id' do |id|
  content_type :json
  survey = Survey.new(id, '1234 California Street')
  survey.to_json
end