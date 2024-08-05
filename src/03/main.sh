#!/bin/bash

source lib_checks.sh

if [[ $# -eq 1 ]]
then
    check_parameter "$1"
else
    echo "Error! There should be only one parameter!"
fi
