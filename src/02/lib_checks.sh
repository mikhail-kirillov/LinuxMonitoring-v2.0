#!/bin/bash

function check_first_argument() {
    DIR_NAME_ENGLISH_LETTERS="$1"
    if [[ "$DIR_NAME_ENGLISH_LETTERS" =~ [[:alpha:]] ]] \
    && [[ "${#DIR_NAME_ENGLISH_LETTERS}" -le 7 \
    && "${#DIR_NAME_ENGLISH_LETTERS}" -ge 1 ]]
    then
        echo "1"
    else
        echo "0"
    fi
}

function check_second_argument() {
    FILE_NAME_ENGLISH_LETTERS="$1"
    FILE_NAME_PATTERN='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
    if [[ "$FILE_NAME_ENGLISH_LETTERS" =~ $FILE_NAME_PATTERN ]]
    then
        echo "1"
    else
        echo "0"
    fi
}

function check_third_argument() {
    if [[ "${#1}" -ge 3 ]]
    then
        FILE_SIZE="$1"
        SIZE="${FILE_SIZE:0:-2}"
        if [[ "${FILE_SIZE: -2}" == "mb" || "${FILE_SIZE: -2}" == "Mb" \
        || "${FILE_SIZE: -2}" == "MB" ]] && [[ "$SIZE" -ge 0 && "$SIZE" -le 100 ]]
        then
            echo "1"
        else
            echo "0"
        fi
    else
        echo "0"
    fi
}
