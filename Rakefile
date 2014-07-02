require 'sinatra/activerecord/rake'
require './app'

desc "Start Postgres service"
task :start_postgres do
	sh 'pg_ctl -D /opt/boxen/homebrew/var/postgres start'
end

desc "Stop Postgres service"
task :stop_postgres do
	sh 'pg_ctl -D /opt/boxen/homebrew/var/postgres stop -s -m fast'
end

desc "Start survey service"
task :start do
	ruby 'service.rb'
end

desc "Stop survey service"
task :stop do
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
