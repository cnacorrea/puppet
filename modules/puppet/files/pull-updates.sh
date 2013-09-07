#!/bin/sh

CONFMAN=`confdir`

cd $CONFMAN/puppet
git pull && papply
