#!/bin/bash

function path_check_dir_and_rm() {
    if [[ -d "$1" ]]
    then
        rm -rf "$1" 2> /dev/null
    fi
}

function time_converter() {
    get_time="$1"
    echo $(date -d "$get_time" +%s)
}

function delete_dirs_by_time() {
    get_start_date="$1"
    get_end_date="$2"
    find "/" -type d 2>/dev/null | while read get_dir
    do
        created_date=$(stat -c %W "$get_dir" 2>/dev/null)
        if [[ "$created_date" -ge "$get_start_date" ]] && [[ "$created_date" -le "$get_end_date" ]]
        then
            rm -rf "$get_dir" 2>/dev/null
        fi
    done
}

function log_file_clear_func() {
    read -p "Enter the path to the log file: " logfile_path
    if [[ -f "$logfile_path" ]]
    then
        while read line
        do  
            path_dir="$(echo "$line" | awk -F"\t" '{printf($1)}')"
            path_check_dir_and_rm "$path_dir"
        done < "$logfile_path"
        path_dir="$(echo "$line" | awk -F"\t" '{printf($1)}')"
        path_check_dir_and_rm "$path_dir"
    else
        echo "Error! The file does not exist!"
    fi
}

function data_file_clear_func() {
    read -p "Enter start date (Example: YYYY-MM-DD HH:MM): " start_date
    read -p "Enter end date (Example: YYYY-MM-DD HH:MM): " end_date
    start_date_converted=$(time_converter "$start_date")
    end_date_converted=$(time_converter "$end_date")
    delete_dirs_by_time "$start_date_converted" "$end_date_converted"
}

function mask_name_file_clear_func() {
    read -p "Enter the directory name mask (For example: abcd_$(date +%s)): " mask
    find / -type d 2> /dev/null | grep -P "${mask:0:1}{0,}$mask" | sed 's/ /\\ /g' | xargs rm -rf 2>/dev/null
}
