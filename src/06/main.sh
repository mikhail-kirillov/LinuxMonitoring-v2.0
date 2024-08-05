#!/bin/bash

2>/dev/null

rm -rf logs
../04/main.sh

# Work on 1.8.1 version
goaccess logs/*.log --log-format='%h - %e [%x] "%r" %s %b "%R" "%u"' --datetime-format='%d/%b/%Y:%H:%M:%S %z' -o report.html
