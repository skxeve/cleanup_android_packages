#!/bin/bash
list_file=$1
set -eu

if [ "${list_file}" == "" ]; then
    echo "Empty file name."
    exit 1
fi
if [ ! -e ${list_file} ]; then
    echo "File not found: ${list_file}"
    exit 1
fi

search_command='adb shell cmd package list packages | grep'
delete_command='adb shell pm uninstall -k --user 0'

echo "==================== package list ===================="
cat ${list_file}
echo "==================== adb devices ===================="
adb devices
echo "==================== confirm ===================="
echo "\$ ${delete_command} \$(packages)"
echo -n "Exec OK?(y/n):"
read ans
if [ "$ans" != "y" ]; then
    echo "Canceled."
    exit 1
fi

echo "==================== exec ===================="
for p in $(cat ${list_file} | grep -v '^#')
do
    if [ "${p}" = "" ]; then
        continue
    fi
    echo "---- ${p}"
    if [[ `echo ${p} | egrep '^#'` ]]; then
        continue
    fi
    if [[ `${search_command} ${p}` ]]; then
        echo "Exists package."
        echo "\$ ${delete_command} ${p}"
        ${delete_command} ${p}
    else
        echo "Not installed package."
    fi
done
echo "==================== done ===================="
