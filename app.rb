require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'

get '/' do 
    erb :index
end

post '/s/take' do
    redirect '/'
end