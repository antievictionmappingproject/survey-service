#! /bin/bash
set -e -u

cp -r /vagrant temp
cd temp

echo 'Running in test mode'
RACK_ENV="test"; export RACK_ENV

bundle install --without development --path vendor/bundle

echo 'Creating database'
bundle exec rake db:create

echo 'Running migrations'
bundle exec rake db:migrate

echo 'Starting app'
bundle exec ruby service.rb -o 0.0.0.0