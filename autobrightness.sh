#!/bin/bash
<<COMMENT1
Pseudocode:

get system time
get current brightness = b

if x time
	b = f(x)
		Note: f(x) depends on sunset, sunrise, and is a linear piecewise function (triangular) - i.e. increasing 
		until sun apex, then decreasing. May have higher gradient around sunset/sunrise. Divide b into discrete intervals
		to match discrete brightness units provided to controller
		
if month = 6
	sunrise = y
	sunset = z
if month = 12
	sunrise = f
	sunrise = g
linear interpolation function between two months:
	if 
if b is manually adjusted
	end script until 
		next reboot/login

in /sys/class/backlight/intel_backlight - cat max_brightness gives 976. min = 0.

tzselect = Pacific/Auckland
Auckland = NZXX0003 = location code to use when searching with lynx

COMMENT1

# First obtain a location code from: https://weather.codes/search/

location="NZXX0003"

# Obtain sunrise and sunset raw data from weather.com
sun_times=$( lynx --dump  https://weather.com/weather/today/l/$location | grep "\* Sun" | sed "s/[[:alpha:]]//g;s/*//" )

# Extract sunrise and sunset times and convert to 24 hour format
sunrise=$(date --date="`echo $sun_times | awk '{ print $1}'` AM" +%s)
sunset=$(date --date="`echo $sun_times | awk '{ print $2}'` PM" +%s)

# Get current times
date=$(date '+%T')
#echo $date

month=$(date '+%m')
#echo $curr_month

time=$(date '+%s')

echo "Sunrise for location $location: $sunrise"
echo "Sunset for location $location: $sunset"

#apex="$(((($sunset-$sunrise)/2)+$sunrise))"
#echo $apex

diff_sunrise=$(($time-$sunrise))
diff_sunset=$(($time-$sunset))

if [ $diff_sunrise -ge 0 -a $diff_sunrise -lt 3600 ]
then
	brightness=$((($diff_sunrise*100/3600)*8+150)) 
	echo "diff_sunrise in the slot"
#726+250=976=max brightness
elif [ $diff_sunrise -lt 0 ]
then
	echo "diff_sunrise < 0"	
	brightness=$"150"
else
	brightness=$"976"
fi

if [ $diff_sunset -ge 0 -a $diff_sunset -lt 3600 -a $diff_sunrise -gt 3601 ]
then
	echo "diff_sunset in the slot"	
	brightness=$((($diff_sunset*100/3600)*8+150))
elif [ $diff_sunset -ge 3600 ]
then
	echo "diff_sunset >= 3600"	
	brightness=$"150"
fi

echo "Brightness = $brightness"

#Final line: send brightness to intel_backlight
echo "$brightness" > /sys/class/backlight/intel_backlight/brightness

# Need to update every half hour or so
