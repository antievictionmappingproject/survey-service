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
    survey = SurveyResponse.new()
    survey.id = SecureRandom.uuid
    surveys = [survey]

    allow(SurveyResponse).to receive(:all).and_return(surveys)

    get '/surveys'
    expect(last_response).to be_ok 
    expect(last_response.content_type).to eq('application/json')

    hash = JSON.parse(last_response.body)
    expect(hash['_links']['self']['href']).to eq("#{base_url}/surveys")
    expect(hash['_links']['items'][0]['href']).to eq("#{base_url}/surveys/#{survey.id}")
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

    allow(SurveyResponse).to receive(:find_by).with(id: id).and_return(survey)
   
    get "/surveys/#{id}"
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq('application/json')
  end
end