require 'sinatra/activerecord/rake'
require './app'

desc "Run unit tests"
task :test do
	sh "rspec --tag ~acceptance --color spec --format documentation"
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