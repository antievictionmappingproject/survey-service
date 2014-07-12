#! /bin/bash
set -e -u

cd /vagrant
RACK_ENV="production"; export RACK_ENV
bundle install --without development:test --path vendor/bundle