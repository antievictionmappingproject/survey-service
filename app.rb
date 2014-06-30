require 'sinatra'

get '/' do 
    erb :index
end

post '/s/take' do
    redirect '/'
end
