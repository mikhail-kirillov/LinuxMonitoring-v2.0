#!/bin/bash

source lib_checks.sh
source lib_funcs.sh

START_TIME="$(date +%s)"

DIR_NAME_ENGLISH_LETTERS="$1"
FILE_NAME_ENGLISH_LETTERS="$2"
FILE_SIZE="$3"

if [[ $# -eq 3 ]]
then

    sum_tmp_var=3

    if ! [[ $(check_first_argument "$DIR_NAME_ENGLISH_LETTERS") -eq 1 ]]
    then
        echo "Error! Invalid first argument: $DIR_NAME_ENGLISH_LETTERS
        We need a list of English letters used in folder names (no more than 7 characters)"
        let "sum_tmp_var-=1"
    fi

    if ! [[ $(check_second_argument "$FILE_NAME_ENGLISH_LETTERS") -eq 1 ]]
    then
        echo "Error! Invalid second argument: $FILE_NAME_ENGLISH_LETTERS
        We need a list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension)"
        let "sum_tmp_var-=1"
    fi

    if ! [[ $(check_third_argument "$FILE_SIZE") -eq 1 ]]
    then
        echo "Error! Invalid third argument: $FILE_SIZE
        File size required (in Megabytes, but not more than 100)"
        let "sum_tmp_var-=1"
    fi

    if [[ "$sum_tmp_var" -eq 3 ]]
    then

        generate_files_function "$DIR_NAME_ENGLISH_LETTERS" "$FILE_NAME_ENGLISH_LETTERS" "$FILE_SIZE"

        END_TIME="$(date +%s)"

        echo "The script started working: $START_TIME"
        echo "The script finished working: $END_TIME"
        echo "Script execution time (in seconds) = $(( $END_TIME - $START_TIME ))"

        echo "The script started working: $START_TIME" >> "$LOG_FILE_PATH"
        echo "The script finished working: $END_TIME" >> "$LOG_FILE_PATH"
        echo "Script execution time (in seconds) = $(( $END_TIME - $START_TIME ))" >> "$LOG_FILE_PATH"
    fi

else
    echo "Error! Invalid number of arguments!"
fi
