#!/bin/bash

END_SIZE=1000000
LOG_FILE_NAME="01_file.log"

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
    for (( k=0; k<(( $gj + 3 )); k++ ))
    do
        NAME+="${FILE_NAME:0:1}"
    done

    NAME+="${FILE_NAME:0}"
    NAME+="_$START_DATE"
    NAME+=".$(echo $FILE_NAME_ENGLISH_LETTERS | cut -d '.' -f 2)"
    
    echo "$NAME"
}

function generate_files_function() {
    ABSOLUTE_PATH="$1"
    INNER_DIR_COUNTER="$2"
    DIR_NAME_ENGLISH_LETTERS="$3"
    FILE_IN_DIR_COUNTER="$4"
    FILE_NAME_ENGLISH_LETTERS="$5"
    FILE_SIZE="$6"

    touch "$LOG_FILE_NAME"
    LOG_FILE_PATH=$(echo "$(pwd)/$LOG_FILE_NAME")

    cd "$ABSOLUTE_PATH"
    SCRIPT_PATH=$(pwd)
    START_DATE=$(date +%D | awk -F / '{print($2$1$3)}')

    FREE_SPACE=$(df / | head -2 | tail +2 | awk '{printf("%d", $4)}')
    if [[ "$FREE_SPACE" -gt "$END_SIZE" ]]
    then
        generate_dirs_and_files_function \
        "$INNER_DIR_COUNTER" "$DIR_NAME_ENGLISH_LETTERS" \
        "$FILE_IN_DIR_COUNTER" "$FILE_NAME_ENGLISH_LETTERS" "$FILE_SIZE" \
        "$LOG_FILE_PATH" \
        "$START_DATE"
    fi
}

function generate_dirs_and_files_function() {
    INNER_DIR_COUNTER="$1"
    DIR_NAME_ENGLISH_LETTERS="$2"
    FILE_IN_DIR_COUNTER="$3"
    FILE_NAME_ENGLISH_LETTERS="$4"
    FILE_SIZE="$5"
    LOG_FILE_PATH="$6"
    START_DATE="$7"

    for (( i=0; i<"$INNER_DIR_COUNTER"; i++ ))
    do
        if [[ $(df / | head -2 | tail +2 | awk '{printf("%d", $4)}') -le "$END_SIZE" ]]
        then
            break
        fi

        while :
        do
            dirictory_name=$(generate_dir_name_function "$DIR_NAME_ENGLISH_LETTERS" "$START_DATE" "$i")
            if ! [[ -d "$(pwd)/$dirictory_name" ]]
            then
                break
            fi
        done

        mkdir "$dirictory_name"
        echo -e "$(pwd)/$dirictory_name/\t$(date +'%d.%m.%Y')\t-" >> "$LOG_FILE_PATH"

        for (( j=0; j<"$FILE_IN_DIR_COUNTER"; j++ ))
        do
            if [[ $(df / | head -2 | tail +2 | awk '{printf("%d", $4)}') -le "$END_SIZE" ]]
            then
                break
            fi

            while :
            do
                file_name=$(generate_file_name_function "$FILE_NAME_ENGLISH_LETTERS" "$START_DATE" "$j")
                if ! [[ -f "$(pwd)/$dirictory_name/$file_name" ]]
                then
                    break
                fi
            done
            
            touch "$dirictory_name/$file_name"
            fallocate -l ${FILE_SIZE:0:-2}"KB" "$dirictory_name/$file_name" 2> /dev/null
            echo -e "$(pwd)/$dirictory_name/$file_name\t$(date +'%d.%m.%Y')\t${FILE_SIZE:0:-2}KB" >> "$LOG_FILE_PATH"
        done
    done
}
