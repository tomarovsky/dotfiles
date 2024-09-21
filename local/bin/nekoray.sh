#!/bin/bash

if pgrep -x "nekoray" > /dev/null
then
    killall nekoray
else
    nekoray -appdata &
fi

