require 'sinatra/activerecord/rake'
require './app'

desc "Run unit tests"
task :test => ['db:migrate'] do
	sh "rspec --tag ~acceptance --color spec --format documentation"
end

desc "Start the service"
task :start => ['db:migrate'] do
	sh "rackup config.ru -s thin -p 4567 -E development -D -P tmp/pids/private_pub.pid"
end

desc "Stop the service"
task :stop do
	sh "if [ -f tmp/pids/private_pub.pid ]; then kill -9 `cat tmp/pids/private_pub.pid`; fi"
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

desc "Run acceptance tests against the deployed service"
task :acceptance do
	sh "rspec --tag acceptance --color spec --format documentation"
end

desc "Run all validations"
task :pre_commit => [:test, :deploy, :acceptance] do
end