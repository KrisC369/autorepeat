#!/bin/sh
#script to automate checking for weird memory behavior.
#Run script with ./autorepeat.sh [Applicationpath] [time to wait before killing app] [number of times to run]

APPLICATION=$1
SLEEPTIME=$2
RUNTIMES=$3

echo "Pid of this parent: $$"
echo $$
echo "Starting application."

c=1
while [ $c -le $RUNTIMES ]
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

