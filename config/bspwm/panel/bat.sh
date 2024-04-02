#!/bin/bash

source $(dirname $0)/profile

FULL=`acpi -b | awk '{gsub(/%,/,""); print $4}' | sed 's/%//g'`
NOTFULL=`acpi -b | awk '{ split($5,a,":"); print substr($3,0,2), $4, "["a[1]":"a[2]"]" }' | tr -d ',' | sed -e 's/\[//g;s/\]//g'`

[[ $FULL -eq 100 ]] && echo -e "%{F$THECOLOR}${BATTIC}" || echo -e "%{F$THECOLOR}%{F$FOREG} $NOTFULL"
