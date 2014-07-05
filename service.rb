require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './representations/survey'
require './models/survey_response'

get '/surveys/survey/:id' do |id|
	content_type :json
	survey = Survey.new(id, '1234 California Street')
	survey.to_json
end

post '/surveys' do
	content_type :json
	survey = Survey.new('blah', '543 test street')
	@response = SurveyResponse.new
	@response.address_1 = '543 test street'
	@response.save

	survey.to_json
end