ENV['RACK_ENV'] = 'development'

require './app'
require 'rspec'
require 'rack/test'

describe 'Survey Service' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'has a root resource to describe itself' do
    get '/'
    expect(last_response).to be_ok 
    expect(last_response.content_type).to eq('application/json')
    expect(last_response.body).to include('self')
    expect(last_response.body).to include('surveys')
  end
end