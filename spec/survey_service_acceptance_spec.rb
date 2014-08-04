require 'rspec'
require 'rest_client'
require './representations/survey_request_representation'
require './representations/survey_response_representation'
require 'json'

surveys_endpoint = 'http://localhost:4567/surveys'
survey_endpoint = 'http://localhost:4567/surveys/survey'

describe 'survey service' do

  it 'returns 404 when requested survey response does not exist', :acceptance do
    id = SecureRandom.uuid
    RestClient.get("#{survey_endpoint}/#{id}") { |response, request, result| 
      expect(response.code).to eq(404)
    }
  end

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

    id = "undefined"

    RestClient.post(surveys_endpoint, survey_request.to_json, :content_type => :json, :accept => :json) { |response, request, result| 
      expect(response.code).to eq(200)
      survey_response = SurveyResponseRepresentation.from_json(response.body)

      expect(survey_response.first_name).to eq(first_name)
      expect(survey_response.last_name).to eq(last_name)
      expect(survey_response.address_line_1).to eq(address_line_1)
      expect(survey_response.address_line_2).to eq(address_line_2)
      expect(survey_response.address_city).to eq(city)
      expect(survey_response.address_state).to eq(state)
      expect(survey_response.address_zip_code).to eq(zip_code)

      id = survey_response.id
    }

    RestClient.get("#{surveys_endpoint}/#{id}") { |response, request, result| 
      expect(response.code).to eq(200)
    }
  end
end