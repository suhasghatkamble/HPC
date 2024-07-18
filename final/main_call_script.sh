#!/bin/bash


echo "***************W  E   L   C   O   M   E***************"

advisor()
{
    ./advisor.sh
}

vtune()
{
    ./vtune.sh
}

hpctoolkit()
{
    ./hpctoolkit.sh
}

gprof()
{
    ./gprof.sh
}

while true; do
    echo "Choose your option "
    echo "Select 1 to run Advisor script"
    echo "Select 2 to run Vtune script"
    echo "Select 3 to run hpctoolkit script"
    echo "Select 4 to run gprof script"
    read options

case "$options" in 
1)  advisor
    break;;

2)  vtune
    break ;;

3)  hpctoolkit
    break ;;

4)  gprof
    break ;;

*) 
    echo -e "\n option is not available. Please try again. \n "  ;;
    esac
    done


















