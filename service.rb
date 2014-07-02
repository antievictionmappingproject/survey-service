require 'sinatra'
require 'json'
require './models/survey'

get '/surveys/survey/:id' do |id|
	content_type :json
	survey = Survey.new(id, '1234 California Street')
	survey.to_json
end

post '/surveys' do
	content_type :json
	survey = Survey.new('blah', '543 test street')
	survey.to_json
end