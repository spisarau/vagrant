#!/bin/bash

FREESPACE=$((100-$(df --total | grep total |awk '{print $5}'| grep -o -e '[0-9]*') ))
EXITING=0
LOG_DIR="/opt/free-space"
LOGS_COUNT=5

# How often dist space info should be saved to the data file
POLL_PERIOD="30"
# Mount point of the disk that should be monitored
MOUNT_POINT="/"
# Path to data file
RESULT_FILE="/opt/free-space/free-space.csv"

function do_start {

NUM_OF_FILES=$(ls -l | wc -l $LOG_DIR )
if ! [ -f $RESULT_FILE ]
then 
	mkdir /opt/free-space
	touch $RESULT_FILE
	echo "Timestamp,Free Disk Space" >> $RESULT_FILE
else

	if (( $NUM_OF_FILES == $(( $LOGS_COUNT + 1 )) ))
	then 
	rm /opt/free-space/free-space.$LOGS_COUNT.csv
	for (( COUNTER=$LOGS_COUNT; COUNTER=>NUM_OF_FILES; COUNTER-- )); do
		mv /opt/free-space/free-space.$(($COUNTER-1)).csv /opt/free-space/free-space.$(($COUNTER)).csv
	fi
	if (( $NUM_OF_FILES > 1 )
	then 
	rm /opt/free-space/free-space.$LOGS_COUNT.csv
	for (( COUNTER=$LOGS_COUNT; COUNTER=>$NUM_OF_FILES-1; COUNTER-- )); do
		mv /opt/free-space/free-space.$(($COUNTER-1)).csv /opt/free-space/free-space.$(($COUNTER)).csv
	fi
	
	
done
	echo $RESULT_FILE > /opt/free-space/free-space.1.csv
	
 
	
	
	
	
	 
fi

if [ -f $RESULT_FILE ] && $NUM_OF_FILES > 1
then 
	# mv $RESULT_FILE $LOG_DIR/free-space.$(($NUM_OF_FILES+1)).csv

fi



EXIT=1

until $EXIT
do
	FREESPACE=$((100-$(df --total | grep total |awk '{print $5}'| grep -o -e '[0-9]*') ))
	DATE=`date '+%Y-%m-%d %H:%M:%S'`
	echo $DATE$','$FREESPACE >> /opt/free-space/free-space.csv
	sleep $POLL_PERIOD
done

   }

function do_stop {
 EXITING=0
  }

function do_status {
 echo "Usage $1 [start|stop|status]"

   }

function do_help {
    echo "Usage $1 [start|stop|status]"
}

case "$1" in
    start)
        do_start
        ;;

    stop)
        do_stop
        ;;

    status)
        do_status
        ;;

    *)
        do_help
        ;;
esac;

