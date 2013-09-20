#!/bin/bash

USER="javamgmt"
PASS=`/usr/local/sbin/generate_crypt_string.sh`
MAIL="$1"

TEMP=`mktemp /tmp/jboss.XXXXXX`

cd /opt/jboss
grep -v "^javamgmt=" standalone/configuration/mgmt-users.properties > $TEMP
cp -f $TEMP standalone/configuration/mgmt-users.properties
grep -v "^javamgmt=" domain/configuration/mgmt-users.properties > $TEMP
cp -f $TEMP domain/configuration/mgmt-users.properties
rm -f $TEMP

bin/add-user.sh --silent=true javamgmt $PASS

mail -s "Your new JBoss admin credentials" $MAIL << EOF
Dear JBoss user,

A new administrative account was provisioned for you to manage your JBoss install on `hostname`:

Username: javamgmt
Password: $PASS

The console management URL for this install is probably http://`hostname`:9990/.

Regards,
Your Support Team.
EOF

touch /opt/jboss/management_password
