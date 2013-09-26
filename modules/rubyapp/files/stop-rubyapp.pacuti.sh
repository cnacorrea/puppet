#!/bin/bash

# $1 => path where ruby applications are stored in this system
# $2 => application directory (appname.domain)
# $3 => git repository for download

su - deploy -c "( cd ${1}/${2} ; export URL_HOST=pacuti.h.unimedrj.com.br ; bundle exec passenger stop -p ${3} ; kill -15 `ps -ef | grep resque | grep -v grep | awk '{ print $2; }'` )"

service redis stop

