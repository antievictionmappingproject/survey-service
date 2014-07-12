#! /bin/bash
set -e -u

REQUIRED_RUBY=ruby-2.0.0-p247

(rvm list rubies| grep $REQUIRED_RUBY) || rvm install $REQUIRED_RUBY

rvm $REQUIRED_RUBY do which -s bundler || rvm $REQUIRED_RUBY do gem install -q --no-ri --no-rdoc bundler
rvm $REQUIRED_RUBY do bundle install --quiet --path vendor/isolated_gems

time bundle exec rake $1