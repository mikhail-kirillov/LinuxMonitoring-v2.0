#!/bin/bash

function check_first_argument() {
    ABSOLUTE_PATH="$1"
    if [[ $(echo "${ABSOLUTE_PATH:0:1}") == "/" ]] \
    && [[ -d "$ABSOLUTE_PATH" ]]
    then
        echo "1"
    else
        echo "0"
    fi
}

function check_second_argument() {
    INNER_DIR_COUNTER="$1"
    if [[ "$INNER_DIR_COUNTER" =~ [[:digit:]] ]] \
    && [[ "$INNER_DIR_COUNTER" -ge 0 ]]
    then
        echo "1"
    else
        echo "0"
    fi
}

function check_third_argument() {
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

function check_fourth_argument() {
    FILE_IN_DIR_COUNTER="$1"
    if [[ "$FILE_IN_DIR_COUNTER" =~ [[:digit:]] ]] \
    && [[ "$FILE_IN_DIR_COUNTER" -ge 0 ]]
    then
        echo "1"
    else
        echo "0"
    fi
}

function check_fifth_argument() {
    FILE_NAME_ENGLISH_LETTERS="$1"
    if [[ "$FILE_NAME_ENGLISH_LETTERS" =~ ^[a-zA-Z]+[.]+[a-zA-Z]+$ ]]
    then
        FILE_NAME=$(echo "$FILE_NAME_ENGLISH_LETTERS" | cut -d '.' -f 1)
        LENGTH_FILE_NAME="${#FILE_NAME}"
        FILE_EXT=$(echo "$FILE_NAME_ENGLISH_LETTERS" | cut -d '.' -f 2)
        LENGTH_FILE_EXT="${#FILE_EXT}"

        if [[ "$LENGTH_FILE_NAME" -le 7 && "$LENGTH_FILE_NAME" -ge 1 \
        && "$LENGTH_FILE_EXT" -le 3 && "$LENGTH_FILE_EXT" -ge 1 ]]
        then
            echo "1"
        else
            echo "0"
        fi
    else
        echo "0"
    fi
}

function check_sixth_argument() {
    if [[ "${#1}" -ge 3 ]]
    then
        FILE_SIZE="$1"
        SIZE="${FILE_SIZE:0:-2}"
        if [[ "${FILE_SIZE: -2}" == "kb" || "${FILE_SIZE: -2}" == "Kb" \
        || "${FILE_SIZE: -2}" == "KB" ]] && [[ "$SIZE" -ge 0 && "$SIZE" -le 100 ]]
        then
            echo "1"
        else
            echo "0"
        fi
    else
        echo "0"
    fi
}
