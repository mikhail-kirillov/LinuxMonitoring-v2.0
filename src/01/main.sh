#!/bin/bash

source lib_checks.sh
source lib_funcs.sh

ABSOLUTE_PATH="$1"
INNER_DIR_COUNTER="$2"
DIR_NAME_ENGLISH_LETTERS="$3"
FILE_IN_DIR_COUNTER="$4"
FILE_NAME_ENGLISH_LETTERS="$5"
FILE_SIZE="$6"

if [[ $# -eq 6 ]]
then
    sum_tmp_var=6

    if ! [[ $(check_first_argument "$ABSOLUTE_PATH") -eq 1 ]]
    then
        echo "Error! Invalid first argument: $ABSOLUTE_PATH
        Need absolute path"
        let "sum_tmp_var-=1"
    fi

    if ! [[ $(check_second_argument "$INNER_DIR_COUNTER") -eq 1 ]]
    then
        echo "Error! Invalid second argument: $INNER_DIR_COUNTER
        Number of subfolders required"
        let "sum_tmp_var-=1"
    fi

    if ! [[ $(check_third_argument "$DIR_NAME_ENGLISH_LETTERS") -eq 1 ]]
    then
        echo "Error! Invalid third argument: $DIR_NAME_ENGLISH_LETTERS
        We need a list of English letters used in folder names (no more than 7 characters)"
        let "sum_tmp_var-=1"
    fi

    if ! [[ $(check_fourth_argument "$FILE_IN_DIR_COUNTER") -eq 1 ]]
    then
        echo "Error! Invalid fourth argument: $FILE_IN_DIR_COUNTER
        Need number of files in each created folder"
        let "sum_tmp_var-=1"
    fi

    if ! [[ $(check_fifth_argument "$FILE_NAME_ENGLISH_LETTERS") -eq 1 ]]
    then
        echo "Error! Invalid fifth argument: $FILE_NAME_ENGLISH_LETTERS
        We need a list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension)"
        let "sum_tmp_var-=1"
    fi

    if ! [[ $(check_sixth_argument "$FILE_SIZE") -eq 1 ]]
    then
        echo "Error! Invalid sixth argument: $FILE_SIZE
        File size required (in kilobytes, but not more than 100)"
        let "sum_tmp_var-=1"
    fi

    if [[ "$sum_tmp_var" -eq 6 ]]
    then
        generate_files_function "$ABSOLUTE_PATH" \
        "$INNER_DIR_COUNTER" "$DIR_NAME_ENGLISH_LETTERS" \
        "$FILE_IN_DIR_COUNTER" "$FILE_NAME_ENGLISH_LETTERS" \
        "$FILE_SIZE"
    fi

else
    echo "Error! There must be 6 arguments!"
fi
