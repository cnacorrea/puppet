#!/bin/bash

su - deploy -c "( cd /var/www/pacuti.h.unimedrj.com.br ; export URL_HOST=pacuti.h.unimedrj.com.br ; bundle exec passenger stop -p 3006 ; kill -15 `ps -ef | grep resque | grep -v grep | awk '{ print $2; }'` )"

service redis stop

