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

  it 'return status code 200 (successful) for GET on root resource' do
    get '/'
    expect(last_response).to be_ok 
    expect(last_response.content_type).to eq('application/json')

    hash = JSON.parse(last_response.body)
    expect(hash['_links']['self']['href']).to eq(base_url)
    expect(hash['_links']['surveys']['href']).to eq("#{base_url}/surveys")
  end

  it 'return status code 200 (successful) for GET on surveys resource' do
    get '/surveys'
    expect(last_response).to be_ok 
    expect(last_response.content_type).to eq('application/json')
  end

  it 'return status code 404 (not found) for GET on non existant survey' do
    id = SecureRandom.uuid
    get "/surveys/#{id}"
    expect(last_response).to be_not_found 
  end
end