require 'rspec'
require 'rest_client'

base_url = 'http://localhost:4567/survey/blee'

describe 'survey service' do
   it "serves up json data" do
    response = RestClient.get base_url
    expect(response.code).to eq(200)
    expect(response.body).to eq('{"id":"blee","address":"409B Duncan Street"}')
  end
end