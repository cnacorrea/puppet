#!/bin/sh

SYSTEM=`uname`

case "$SYSTEM" in
Darwin)
	echo "/Users/confman"
	;;
*)
	echo "/home/confman"
	;;
esac
