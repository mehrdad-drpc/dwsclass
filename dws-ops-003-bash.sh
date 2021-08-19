#!/bin/bash

user_interupt=0
user_repeat_time=0
user_command=""

function usage {
    echo "input 'i' for interupt in second"
    echo "input 'n' for repeat time"
    echo "input 'c' for your executed command"
}

if [ $# -eq 0 ]; then
    usage
else
    while getopts ":i:n:c:h" option; do
        case "${option}" in
        h)
            usage
            ;;
        i)
            user_interupt="${OPTARG}"

            ;;
        n)
            user_repeat_time=${OPTARG}
            ;;
        c)
            user_command=${OPTARG}
            ;;
        *)
            echo "run $0 -h"
            ;;
        esac
    done
fi

c=0
while [ $c -lt $user_repeat_time ]; do
    $user_command &>/dev/null
    if [ $? -eq 0 ]; then
        echo "----- $(( c + 1 )) -----"
        $user_command
        sleep $user_interupt
        ((c = c + 1))
    else
        read -p "plaese enter valid command: " user_command
        while [ -z $user_command ]; do
            read -p "plaese enter valid command: " user_command
        done
        continue
    fi
done

