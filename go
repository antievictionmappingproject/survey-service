#!/bin/bash
set -e -u

REQUIRED_RUBY=ruby-2.0.0-p247

(rvm list rubies| grep $REQUIRED_RUBY) || rvm install $REQUIRED_RUBY

rvm $REQUIRED_RUBY do which -s bundler || rvm $REQUIRED_RUBY do gem install -q --no-ri --no-rdoc bundler
rvm $REQUIRED_RUBY do bundle install --without production --quiet --path vendor/isolated_gems

function run() {
	rvm $REQUIRED_RUBY do bundle exec rake $* 2>&1
}

function task_list() {
		run -T | sed 's/rake/.\/go/'
		exit 0
}

case "$@" in
	tasks|help|-T|"")
		task_list
		;;

	*) 
		;;

esac

run $@