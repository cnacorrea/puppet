#!/bin/bash

USER="javamgmt"
PASS=`/usr/local/sbin/generate_crypt_string.sh`
MAIL="$1"

cd /opt/jboss
bin/add-user.sh --silent=true javamgmt $PASS &> /tmp/teste.log

mail -s "Your new JBoss admin credentials" $MAIL << EOF
Dear JBoss user,

A new administrative account was provisioned for you to manage your JBoss install on `hostname`:

Username: javamgmt
Password: $PASS

Regards,
Your Support Team.
EOF

touch /opt/jboss/management_password
