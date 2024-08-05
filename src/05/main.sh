#!/bin/bash

function dir_logs_not_found() {
    echo "Dir logs not found!"
    rm -rf logs 2>/dev/null
    ../04/main.sh
    echo "Done. Restart script"
}

function all_sort_by_answers() {
    find logs/* -type f -name "day*.log" | xargs cat | sort -n -k 9
}

function all_unic_ips() {
    find logs/* -type f -name "day*.log" | xargs cat | awk '{print $1}' | sort | uniq -u
}

function all_answers_with_errors() {
    find logs/* -type f -name "day*.log" | xargs cat | grep " [45].. "
}

function all_unic_ips_in_error_answers() {
    all_answers_with_errors | awk '{print $1}' | sort | uniq -u
}

if [[ $# -eq 1 ]]
then
    if [[ -d "logs" ]]
    then
        logs_counter=$(ls -l "logs" | grep "[^-]*day..log" | wc -l)
        if [[ $logs_counter -eq 5 ]]
        then
            case $1 in
                1) all_sort_by_answers ;;
                2) all_unic_ips ;;
                3) all_answers_with_errors ;;
                4) all_unic_ips_in_error_answers ;;
                *) echo "Error! Need parameter between 1 and 4!";;
            esac
        else
            dir_logs_not_found
        fi
    else
        dir_logs_not_found
    fi
else
    echo "One parameters needed!"
fi
