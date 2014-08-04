ENV['RACK_ENV'] = 'development'

require './app'
require 'rspec'
require 'rack/test'
require 'json'

describe 'Survey Service' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def base_url
    'http://example.org'
  end

  it 'return status code 200 (ok) for GET on root resource' do
    get '/'
    expect(last_response).to be_ok 
    expect(last_response.content_type).to eq('application/json')

    hash = JSON.parse(last_response.body)
    expect(hash['_links']['self']['href']).to eq(base_url)
    expect(hash['_links']['surveys']['href']).to eq("#{base_url}/surveys")
  end

  it 'return status code 200 (ok) for GET on surveys resource' do
    surveys = []
    allow(SurveyResponse).to receive(:all).and_return(surveys)

    get '/surveys'

    expect(last_response).to be_ok 
    expect(last_response.content_type).to eq('application/json')

    hash = JSON.parse(last_response.body)
    expect(hash['_links']['self']['href']).to eq("#{base_url}/surveys")
  end

  it 'return status code 200 (ok) for GET on surveys resource when surveys exist' do
    one = SurveyResponse.new()
    one.id = SecureRandom.uuid
    two = SurveyResponse.new()
    two.id = SecureRandom.uuid
    surveys = [one, two]
    allow(SurveyResponse).to receive(:all).and_return(surveys)

    get '/surveys'
   
    expect(last_response).to be_ok 
    expect(last_response.content_type).to eq('application/json')

    hash = JSON.parse(last_response.body)
    expect(hash['_embedded']['surveys'][0]['_links']['self']['href']).to eq("#{base_url}/surveys/#{one.id}")
    expect(hash['_embedded']['surveys'][1]['_links']['self']['href']).to eq("#{base_url}/surveys/#{two.id}")
  end

  it 'return status code 404 (not found) for GET on survey that does not exist' do
    id = SecureRandom.uuid

    allow(SurveyResponse).to receive(:find_by).with(id: id).and_return(nil)
   
    get "/surveys/#{id}"
    expect(last_response).to be_not_found 
  end

  it 'return status code 200 (ok) for GET on survey that exists' do
    id = SecureRandom.uuid    
    survey = SurveyResponse.new()
    survey.id = id
    survey.first_name = 'first'
    survey.last_name = 'last'
    survey.street_1 = 'line 1'
    survey.street_2 = 'line 2'
    survey.city = 'city'
    survey.state = 'state'
    survey.zip_code = 'zip'

    allow(SurveyResponse).to receive(:find_by).with(id: id).and_return(survey)
   
    get "/surveys/#{id}"
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq('application/json')

    hash = JSON.parse(last_response.body)
    expect(hash['_links']['self']['href']).to eq("#{base_url}/surveys/#{id}")
    expect(hash['first_name']).to eq('first')
    expect(hash['last_name']).to eq('last')
    expect(hash['address_line_1']).to eq('line 1')
    expect(hash['address_line_2']).to eq('line 2')
    expect(hash['address_city']).to eq('city')
    expect(hash['address_state']).to eq('state')
    expect(hash['address_zip_code']).to eq('zip')
  end

  it 'return status code 200 (ok) for POST on surveys resource' do
    request = SurveyRequestRepresentation.new('first', 'last', 'line 1', 'line 2', 'city', 'state', 'zip')

    SurveyResponse.any_instance.stub(:save).and_return(true)
  
    post '/surveys', request.to_json, "CONTENT_TYPE" => "application/json"  
    
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq('application/json')

    hash = JSON.parse(last_response.body)
    expect(hash['first_name']).to eq('first')
    expect(hash['last_name']).to eq('last')
    expect(hash['address_line_1']).to eq('line 1')
    expect(hash['address_line_2']).to eq('line 2')
    expect(hash['address_city']).to eq('city')
    expect(hash['address_state']).to eq('state')
    expect(hash['address_zip_code']).to eq('zip')
  end
end