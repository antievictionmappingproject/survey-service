require 'sinatra/activerecord/rake'
require './app'

desc "Run survey service"
task :run do
	ruby 'service.rb'
end

desc "Run a local VM"
task :boot do
	sh "vagrant up"
end

desc "Destroy the local VM and delete all files"
task :destroy do
	sh "vagrant destroy -f"
end
