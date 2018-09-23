#!/bin/bash

opt=$1

if [ `echo $opt |grep "d"` ]; then
    adb shell cmd package list packages|awk -F':' '{print $2}'|sort| egrep 'docomo|dcm'
elif [ `echo $opt |grep "samsung"` ]; then
    adb shell cmd package list packages|awk -F':' '{print $2}'|sort| egrep 'samsung'
elif [ `echo $opt |grep "s"` ]; then
    adb shell cmd package list packages|awk -F':' '{print $2}'|sort| egrep 'sony'
else
    adb shell cmd package list packages|awk -F':' '{print $2}'|sort
fi

