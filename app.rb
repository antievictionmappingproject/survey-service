require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './config/environments'
require './representations/survey_request_representation'
require './representations/survey_response_representation'
require './models/model'
require './models/survey_response'

get '/' do 
	content_type :json
    erb :root_resource
end

post '/submit' do
    @model = Model.new(params[:model])
    if @model.save
        redirect '/models'
    else
        "Sorry, there was an error!"
    end
end

get '/models' do
    @models = Model.all
    erb :models
end

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