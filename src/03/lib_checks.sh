#!/bin/bash

source lib_funcs.sh

function check_parameter() {
    param="$1"
    if [[ "$param" -eq 1 ]]
    then
        log_file_clear_func
    elif [[ "$param" -eq 2 ]]
    then
        data_file_clear_func
    elif [[ "$param" -eq 3 ]]
    then
        mask_name_file_clear_func
    else
        echo "Error! The parameter must be between 1 and 3"
    fi
}
