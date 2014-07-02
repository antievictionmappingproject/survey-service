require 'sinatra/activerecord/rake'
require './app'

desc "Run survey service"
task :run do
	ruby 'service.rb'
end

desc "Run integration tests against a locally deployed instance"
task :test do
	sh "rspec --color specs/survey_spec.rb"
end

desc "Run a local VM"
task :boot do
	sh "vagrant up"
end

desc "Destroy the local VM and delete all files"
task :destroy do
	sh "vagrant destroy -f"
end
