#!/bin/bash

file="/usr/share/nginx/html/index.html"

function sys_info() {
    CPU=$(mpstat -P ALL | awk 'NR==4 {print 100 - $12}')
    RAM_Free=$(free | awk 'NR==2 {print $4}')
    Space_Free=$(df / | awk 'NR==2 {print $4}')
    Read_Disk=$(iostat | grep '^sda*' | awk '{print $6}')
    Write_Disk=$(iostat | grep '^sda*' | awk '{print $7}')

    echo -e "CPU $CPU\nRAM_Free $RAM_Free\nSpace_Free $Space_Free\nRead_Disk $Read_Disk\nWrite_Disk $Write_Disk"
}

function write_info_to_file() {
    sys_info > $file 2>/dev/null
}

function loop() {
    while true
    do
        write_info_to_file
        sleep 3
    done
}

if [ $# != 0 ] ; then
    echo "No arguments need!"
else
    loop
fi