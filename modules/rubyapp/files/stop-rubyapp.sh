#!/bin/bash

# $1 => path where ruby applications are stored in this system
# $2 => application directory (appname.domain)
# $3 => application port

su - deploy -c "( cd ${1}/${2} ; bundle exec passenger stop -p ${3} )"

