require 'rspec'
require 'rest_client'
require './representations/survey_request_representation'
require './representations/survey_response_representation'
require 'json'

def surveys_endpoint
  value = 'http://localhost:4567/surveys'
  if ENV['RACK_ENV'] == 'production'
     value = 'http://surveys-aemp.herokuapp.com/surveys'
  end

  value
end

describe 'survey service' do

  it 'saves a representation of a survey response', :acceptance do
    first_name = 'Robert'
    last_name = 'Smith'
    address_line_1 = '1234 Test Street'
    address_line_2 = 'Apartment 100'
    city = 'San Francisco'
    state = 'CA'
    zip_code = '9000'

    survey_request = SurveyRequestRepresentation.new(first_name,
      last_name,
      address_line_1,
      address_line_2,
      city,
      state,
      zip_code)

    survey_link = ''

    RestClient.post(surveys_endpoint, survey_request.to_json, :content_type => :json, :accept => :json) { |response, request, result| 
      expect(response.code).to eq(200)

      hash = JSON.parse(response.body)
      survey_link = hash['_links']['self']['href']

      expect(hash['first_name']).to eq(first_name)
      expect(hash['last_name']).to eq(last_name)
      expect(hash['address_line_1']).to eq(address_line_1)
      expect(hash['address_line_2']).to eq(address_line_2)
      expect(hash['address_city']).to eq(city)
      expect(hash['address_state']).to eq(state)
      expect(hash['address_zip_code']).to eq(zip_code)
    }

    RestClient.get(survey_link) { |response, request, result| 
       expect(response.code).to eq(200)

       hash = JSON.parse(response.body)
      survey_link = hash['_links']['self']['href']

      expect(hash['first_name']).to eq(first_name)
      expect(hash['last_name']).to eq(last_name)
      expect(hash['address_line_1']).to eq(address_line_1)
      expect(hash['address_line_2']).to eq(address_line_2)
      expect(hash['address_city']).to eq(city)
      expect(hash['address_state']).to eq(state)
      expect(hash['address_zip_code']).to eq(zip_code)
    }
  end
end