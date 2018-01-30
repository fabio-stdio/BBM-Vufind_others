#!/bin/sh
 
# Disable JETTY_CONSOLE output -- it causes problems when run by cron:
export JETTY_CONSOLE=/dev/null
 
# Pass parameters along to vufind.sh:
CURRENTPATH=`dirname $0`
cd $CURRENTPATH
$CURRENTPATH/vufind.sh $*