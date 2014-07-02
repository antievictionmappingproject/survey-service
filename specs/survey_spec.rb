require 'rspec'
require 'rest_client'
require './models/survey'
require 'json'

surveys_endpoint = 'http://localhost:4567/surveys'
survey_endpoint = 'http://localhost:4567/surveys/survey/blee'

describe 'survey service' do

	it "serves up json data" do
		response = RestClient.get survey_endpoint
		expect(response.code).to eq(200)

		survey = Survey.json_create(JSON.parse(response.body))
		expected_survey = Survey.new('blee', '1234 California Street')
		expect(survey).to eq(expected_survey)
	end

	it "saves survey data posted to the surveys endpoint" do
		expected_survey = Survey.new('one', '321 test street')
		RestClient.post surveys_endpoint, { 'x' => 1 }.to_json, :content_type => :json, :accept => :json

		response = RestClient.get survey_endpoint
		expect(response.code).to eq(200)

		survey = Survey.json_create(JSON.parse(response.body))
		expect(survey).to eq(expected_survey)
	end
end