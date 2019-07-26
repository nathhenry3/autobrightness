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

COMMENT1



date=$(date '+%T')
echo $date

#month=$date[

brightness=$"900"
#Final line: send brightness to intel_backlight
echo "$brightness" > /sys/class/backlight/intel_backlight/brightness


