#!/bin/bash

# Script per ripristino automatico

# controllando l'utilizzo della cpu

# OrionsSoftware 2015

 

alertvalue=30

while [ 1 -gt 0 ]

do

sleep 30

cpu1=`top -b -n1 | grep "cgminer"`

cpu=${cpu1:38:2}

#proc=${cpu1:0:5}

if [ $cpu -lt $alertvalue ] || [ $cpu -eq "" ] ; then

   #echo "Primo Alert " $cpu

   sleep 30

   cpu1=`top -b -n1 | grep "cgminer"`

   cpu=${cpu1:38:2}

   if [ $cpu -lt $alertvalue ] || [ $cpu -eq "" ] ; then

                #echo "Alert confermato : Ora il livello "$cpu

                start-stop-daemon --stop --pidfile /run/cgminer.pid --exec cgminer

                start-stop-daemon --stop --pidfile /run/restart.pid --exec sh /mineros/restart.sh

                #echo "Fermato il servizio"

                sleep 15

                #start-stop-daemon --start --pifile /run/cgminer.pid --exec cgminer

                #echo "Bassa potenza!Riavviato il servizio "+$cpu

                python /mineros/boot.py start

                date " - restart services">> /var/log/restart_miner.log

   fi

fi

done
