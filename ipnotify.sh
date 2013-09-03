#!/bin/bash


#IPnotify - notifies me if my external DHCP-assigned IP address changes
#written, produced, and directed by Kibble
#This script is under the Beer License
#If you see it and you like it, feel free to buy me a beer


IPfile=~/tmp/IPfile.$$
IPlog=~/myIP.log

if [ ! -e $IPlog ]
then
 echo "0.0.0.0" > $IPlog
fi

IPlink='http://automation.whatismyip.com/n09230945.asp'
TOMAIL='thedicearecubed@gmail.com'
FROMMAIL='kmbtutor@gmail.com'


IPfetch=$(wget -q -O - $IPlink)

#check to see if we got an IP address
#this reg-ex is beatable, but good enough, e.g. 999.999.999.999
if [ -z $(echo "$IPfetch" | grep -E  '([0-9]{1,3}\.){3}[0-9]{1,3}') ]
then
  echo "Did not fetch valid IP. Exiting." >> $IPlog
  date >> $IPlog
  exit
fi

#check fetched IP against last logged one
if [ $IPfetch = $(head -n1 $IPlog) ]
then
#  echo "Nothing to see here; move along!"
  date >> $IPlog
  exit
fi

#update log
echo $IPfetch > $IPlog
date >> $IPlog

#form e-mail message
cat > $IPfile <<EOF
To: $TOMAIL
From: $FROMMAIL
Subject: New IP Notification

Your IP address is now $IPfetch.

Hope you're having a wonderful day! :-)
EOF

#mail it
ssmtp $TOMAIL < $IPfile

#clean up
rm -f $IPfile
