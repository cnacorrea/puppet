#!/bin/bash

# $1 => path where ruby applications are stored in this system
# $2 => application directory (appname.domain)
# $3 => git repository for download

if [ -d $1/$2 ]; then
	su - deploy -c "( cd $1 ; mv $2 $2.`date +%Y%m%d` )"
	su - deploy -c "( cd $1 ; git clone -b `cat /usr/local/etc/$2.version` $3 $2 )"
	su - deploy -c "( cd $1 ; cp -Ravp $2.`date +%Y%m%d`/config/database.yml $2/config/ )"
	su - deploy -c "( cd $1 ; cp -Ravp $2.`date +%Y%m%d`/config/email.yml $2/config/ )"
	su - deploy -c "( cd $1 ; cp -Ravp $2.`date +%Y%m%d`/config/config.yml $2/config/ )"
	su - deploy -c "( cd $1 ; tar czvf $2.`date +%Y%m%d`.tar.gz $2.`date +%Y%m%d` )"
	su - deploy -c "( cd $1 ; rm -rf $2.`date +%Y%m%d` )"
else
	su - deploy -c "( cd $1 ; git clone -b `cat /usr/local/etc/$2.version` $3 $2 )"
fi
