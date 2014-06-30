require 'rspec'
require 'rest_client'
require './models/survey'
require 'json'

base_url = 'http://localhost:4567/survey/blee'

describe 'survey service' do
   it "serves up json data" do
    response = RestClient.get base_url
    expect(response.code).to eq(200)
   
    survey = Survey.json_create(JSON.parse(response.body))
    expected_survey = Survey.new('blee', '1234 California Street')
    expect(survey).to eq(expected_survey)
  end
end