#!/bin/bash

su - deploy -c "( cd $1 ; bundle install RAILS_ENV=production )"
su - deploy -c "( cd $1 ; bundle exec rake db:migrate RAILS_ENV=production )"
su - deploy -c "( cd $1 ; bundle exec rake db:seed RAILS_ENV=production )"
su - deploy -c "( cd $1 ; bundle exec rake assets:precompile RAILS_ENV=production )"
