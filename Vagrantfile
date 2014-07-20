VAGRANTFILE_API_VERSION = "2"

$provision_script = <<SCRIPT
export RACK_ENV='test'
cp -r /vagrant /opt/survey-service
cd /opt/survey-service
bundle install --without development
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rackup -D -p 4567 -o 0.0.0.0 -E test config.ru
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "heroku"
 	config.vm.box_url = "https://dl.dropboxusercontent.com/s/rnc0p8zl91borei/heroku.box"
 	config.vm.network :forwarded_port, guest: 4567, host: 4567

 	config.vm.provision "shell", inline: $provision_script
end