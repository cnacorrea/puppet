#!/bin/sh

CONFMAN=`confdir`

sudo puppet apply ${CONFMAN}/puppet/manifests/site.pp --modulepath=${CONFMAN}/puppet/modules/ $*
