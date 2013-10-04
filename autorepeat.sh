#!/bin/sh
#script to automate checking for weird memory behavior.
#Run script with ./autorepeat.sh [Applicationpath] [time to wait before killing app] [number of times to run]

APPLICATION=$1
SLEEPTIME=$2
RUNTIMES=$3
PID=$$

trap 'echo "`basename $0`: Ouch! Quitting early." 1>&2 && echo "Emergency kill in progress..." && kill $PID 1>&2 >/dev/null && k=1' 1 2 15

case $# in
    3)  echo "Pid of this parent: $$"
        echo $$
        echo "Starting application."

        c=1 
        k=0
        while [ $c -le $RUNTIMES ] && [ $k -ne 1 ]
        do
            echo "Count: $c "
            (( c++ ))
        
            $APPLICATION &
            PID=$!
            echo "Pid of child is: $PID"
            #echo $PID
            sleep $SLEEPTIME
            echo "Killing application."
            kill $PID >/dev/null
        done

        echo "Script done."
    ;;
    *)  echo "Usage: `basename $0` [Applicationpath] [Time to wait before killing in seconds] [number of times to run]" 1>&2 ;;
esac
