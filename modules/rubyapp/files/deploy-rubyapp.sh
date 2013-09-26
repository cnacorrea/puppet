#!/bin/bash

# $1 => path where ruby applications are stored in this system
# $2 => application directory (appname.domain)
# $3 => git repository for download

echo $1
echo $2
echo $3

if [ -d $1/$2 ]; then
	su - deploy -c "( cd $1 ; mv $2 $2.`date +%Y%m%d%H%M` )"
	su - deploy -c "( cd $1 ; git clone -b `cat /usr/local/etc/$2.version` $3 $2 )"
	su - deploy -c "( cd $1 ; cp -Ravp $2.`date +%Y%m%d%H%M`/config/database.yml $2/config/ )"
	su - deploy -c "( cd $1 ; cp -Ravp $2.`date +%Y%m%d%H%M`/config/email.yml $2/config/ )"
	su - deploy -c "( cd $1 ; cp -Ravp $2.`date +%Y%m%d%H%M`/config/config.yml $2/config/ )"
	su - deploy -c "( cd $1 ; cp -Ravp $2.`date +%Y%m%d%H%M`/tmp/pids/*.pid $2/tmp/pids/ )"
	su - deploy -c "( cd $1 ; tar czvf $2.`date +%Y%m%d%H%M`.tar.gz $2.`date +%Y%m%d` )"
	su - deploy -c "( cd $1 ; rm -rf $2.`date +%Y%m%d%H%M` )"
else
	su - deploy -c "( cd $1 ; git clone -b `cat /usr/local/etc/$2.version` $3 $2 )"
fi

APP=`echo $2 | cut -f1 -d.`
if [ -f /etc/init.d/$APP ]; then
	service $APP restart
fi
