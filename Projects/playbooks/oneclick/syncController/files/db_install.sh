#!/bin/sh

INSTALL_FILE=.INSTALL_CLIENT

if [ -f $INSTALL_FILE ];
then
    client=`cat $INSTALL_FILE`
    prop="ai.properties.$client"
    export ORACLE_SID=`grep DB_INSTANCE= $prop | cut -f2 -d=`
    for r in `grep DB_ORACLE_HOME= $prop | cut -f2 -d=`
    do
       echo $r
    done
    export PATH=$PATH:$r/bin:/home/msdeploy/bin
    ./aiDBInstall.pl
    #./t1.pl
fi
