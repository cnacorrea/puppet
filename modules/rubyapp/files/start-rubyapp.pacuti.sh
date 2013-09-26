#!/bin/bash

# $1 => path where ruby applications are stored in this system
# $2 => application directory (appname.domain)
# $3 => git repository for download

service redis start

su - deploy -c "( cd /var/www/pacuti.h.unimedrj.com.br ; export URL_HOST=pacuti.h.unimedrj.com.br ; bundle exec rake resque:work QUEUE=* RAILS_ENV=production & )"
su - deploy -c "( cd /var/www/pacuti.h.unimedrj.com.br ; export URL_HOST=pacuti.h.unimedrj.com.br ; bundle exec passenger start -e production -a 127.0.0.1 -p 3006 -d )"

