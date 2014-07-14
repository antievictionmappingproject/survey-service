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

desc "Run migration scripts"
task :migrate => 'db:migrate' do
end

desc "Start survey service"
task :start do
	ruby 'service.rb'
end

desc "Stop survey service"
task :stop do
end

desc "Run unit tests"
task :test do
	sh "rspec --color spec"
end

desc "Run integration tests against a locally deployed instance"
task :acceptance do
	sh "rspec --color specs/survey_spec.rb"
end

desc "Boot local virtual machine"
task :boot do
	sh "vagrant up --no-provision"
end

desc "Install service on the virtual machine"
task :install do
	sh "vagrant provision"
end

desc "Deploy the service to the virtual machine"
task :deploy => [:boot, :install] do
end

desc "Destroy the local VM and delete all files"
task :destroy do
	sh "vagrant destroy -f"
end

desc "Run all validations"
task :pre_commit => [:test, :boot, :acceptance] do
end
