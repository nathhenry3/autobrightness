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
if b is manually adjusted
	end script until 
		next reboot/login

Example hello world menu code:

           OPTIONS="Hello Quit"
           select opt in $OPTIONS; do
               if [ "$opt" = "Quit" ]; then
                echo done
                exit
               elif [ "$opt" = "Hello" ]; then
                echo Hello World
               else
                clear
                echo bad option
               fi
           done

COMMENT1


