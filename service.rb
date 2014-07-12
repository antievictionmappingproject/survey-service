require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './representations/survey_request_representation'
require './representations/survey_response_representation'
require './models/survey_response'

get '/surveys/survey/:id' do |id|
	if (SurveyResponse.find_by id: id).nil?
		halt 404, 'this is not the survey you are looking for'
	end

	@survey = SurveyResponse.find(id)

	content_type :json
	survey.to_json
end

post '/surveys' do
	content_type :json

	survey_request = SurveyRequestRepresentation.json_create(JSON.parse(request.body.read))
	survey_response = SurveyResponseRepresentation.new(SecureRandom.uuid, 
		survey_request.first_name, 
		survey_request.last_name, 
		survey_request.address_line_1, 
		survey_request.address_line_2,
		survey_request.city, 
		survey_request.state, 
		survey_request.zip_code)

	#survey = Survey.new('blah', '543 test street')
	# @response = SurveyResponse.new
	# @response.address_1 = '543 test street'
	# @response.save

	survey_response.to_json
end