require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './config/environments'
require './representations/survey_request_representation'
require './representations/survey_response_representation'
require './representations/surveys_response_representation'
require './models/model'
require './models/survey_response'

def base_url
	@base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
end

get '/' do 
	@base_url = base_url
	content_type :json
    erb :root_resource
end

get '/surveys' do
	@surveys = SurveyResponse.all

	survey_representations = @surveys.map { |survey| SurveyResponseRepresentation.new(base_url, survey) }
	@representation = SurveysResponseRepresentation.new(base_url, survey_representations)

	content_type :json
	erb :surveys_resource
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

get '/surveys/:id' do |id|
	if (SurveyResponse.find_by id: id).nil?
		halt 404, 'this is not the survey you are looking for'
	end

	survey = SurveyResponse.find_by id: id
	@representation = SurveyResponseRepresentation.new(base_url, survey)

	content_type :json	
	erb :survey_resource
end

post '/surveys' do
	survey_request = SurveyRequestRepresentation.from_json(request.body.read)
	
	survey = SurveyResponse.new
	survey.id = SecureRandom.uuid
	survey.first_name = survey_request.first_name
	survey.last_name = survey_request.last_name
	survey.street_1 = survey_request.address_line_1
	survey.street_2 = survey_request.address_line_2
	survey.city = survey_request.address_city
	survey.state = survey_request.address_state
	survey.zip_code = survey_request.address_zip_code
	survey.save

	@representation = SurveyResponseRepresentation.new(base_url, survey)

	content_type :json
	erb :survey_resource
end