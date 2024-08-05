#!/bin/bash

END_SIZE=1000000

LOG_FILE_PATH=""
LOG_FILE_NAME="02_file.log"

function generate_dir_name_function() {
    DIR_NAME_ENGLISH_LETTERS="$1"
    START_DATE="$2"
    gi="$3"

    NAME=""

    for (( k=0; k<(( "$gi" + 3 )); k++ ))
    do
        NAME+="${DIR_NAME_ENGLISH_LETTERS:0:1}"
    done

    NAME+="${DIR_NAME_ENGLISH_LETTERS:0}"
    NAME+="_$START_DATE"

    echo "$NAME"
}

function generate_file_name_function() {
    FILE_NAME_ENGLISH_LETTERS="$1"
    START_DATE="$2"
    gj="$3"

    NAME=""

    FILE_NAME=$(echo "$FILE_NAME_ENGLISH_LETTERS" | cut -d '.' -f 1)
    for (( k=0; k<(( "$gj" + 3 )); k++ ))
    do
        NAME+="${FILE_NAME:0:1}"
    done

    NAME+="${FILE_NAME:0}"
    NAME+="_$START_DATE"
    NAME+=".$(echo $FILE_NAME_ENGLISH_LETTERS | cut -d '.' -f 2)"
    
    echo "$NAME"
}

function generate_dirs_and_files_function() {
    DIR_NAME_ENGLISH_LETTERS="$1"
    FILE_NAME_ENGLISH_LETTERS="$2"
    FILE_SIZE="$3"
    LOG_FILE_PATH="$4"

    START_DATE="$(date +%D | awk -F / '{print($2$1$3)}')"

    while :
    do
        if [[ $(df / | head -2 | tail +2 | awk '{printf("%d", $4)}') -le "$END_SIZE" ]]
        then
            break
        fi

        INNER_DIR_COUNTER="$(( 1 + $RANDOM % 100 ))"
        FILE_IN_DIR_COUNTER="$(( 1 + $RANDOM % 200 ))"
        GET_RANDOM_DIR=$(find / -type d -user "$USERNAME" 2> /dev/null | grep -v 'proc' | grep -v 'bin' | grep -v 'sbin' | grep '^\/' | shuf -n 1)

        for (( z=0; z<"$INNER_DIR_COUNTER"; z++ ))
        do
            if [[ $(df / | head -2 | tail +2 | awk '{printf("%d", $4)}') -le "$END_SIZE" ]]
            then
                break
            fi

            while :
            do
                dirictory_name=$(generate_dir_name_function "$DIR_NAME_ENGLISH_LETTERS" "$START_DATE" "$z")
                if ! [[ -d "$GET_RANDOM_DIR/$dirictory_name" ]]
                then
                    break
                fi
            done

            mkdir -p "$GET_RANDOM_DIR/$dirictory_name"
            if [ $? -ne 0 ]
            then
                break
            fi
            echo -e "$GET_RANDOM_DIR/$dirictory_name/\t$(date +'%d.%m.%Y')\t-" >> "$LOG_FILE_PATH"

            for (( j=0; j<"$FILE_IN_DIR_COUNTER"; j++ ))
            do
                if [[ $(df / | head -2 | tail +2 | awk '{printf("%d", $4)}') -le "$END_SIZE" ]]
                then
                    break
                fi

                while :
                do
                    file_name=$(generate_file_name_function "$FILE_NAME_ENGLISH_LETTERS" "$START_DATE" "$j")
                    if ! [[ -f "$GET_RANDOM_DIR/$dirictory_name/$file_name" ]]
                    then
                        break
                    fi
                done
                
                touch "$GET_RANDOM_DIR/$dirictory_name/$file_name"
                fallocate -l ${FILE_SIZE:0:-2}"MB" "$GET_RANDOM_DIR/$dirictory_name/$file_name" 2> /dev/null
                echo -e "$GET_RANDOM_DIR/$dirictory_name/$file_name\t$(date +'%d.%m.%Y')\t${FILE_SIZE:0:-2}MB" >> "$LOG_FILE_PATH"
                
            done
        done
    done
}

function generate_files_function() {
    DIR_NAME_ENGLISH_LETTERS="$1"
    FILE_NAME_ENGLISH_LETTERS="$2"
    FILE_SIZE="$3"

    touch "$LOG_FILE_NAME"
    LOG_FILE_PATH=$(echo "$(pwd)/$LOG_FILE_NAME")

    FREE_SPACE=$(df / | head -2 | tail +2 | awk '{printf("%d", $4)}')
    if [[ "$FREE_SPACE" -gt "$END_SIZE" ]]
    then
        generate_dirs_and_files_function \
        "$DIR_NAME_ENGLISH_LETTERS" \
        "$FILE_NAME_ENGLISH_LETTERS" \
        "$FILE_SIZE" \
        "$LOG_FILE_PATH"
    fi
}
