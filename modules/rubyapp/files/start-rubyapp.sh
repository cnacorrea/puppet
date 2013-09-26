#!/bin/bash

# $1 => path where ruby applications are stored in this system
# $2 => application directory (appname.domain)
# $3 => application port

su - deploy -c "( cd ${1}.${2} ; bundle install ; bundle exec passenger start -e production -a 127.0.0.1 -p ${3} -d )"
