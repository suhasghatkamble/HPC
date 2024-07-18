#!/bin/bash



echo "***********************************WELCOME TO HPCTOOLKIT ********************************"

source /home/apps/spack/share/spack/setup-env.sh # source the spack 
spack load hpctoolkit                                  # spack is loaded

echo "Enter Executable file ABSOLUTE path : "           # entering the executable file absolute path
read exe_name                                                   # storing in the variable name as exe_name

echo "Event lists : "                                            # showing the list of event                  
echo "1. REALTIME"
echo "2. CPUTIME"
echo "3. perf::CACHE-MISSES"
echo "4. MEMLEAK"
echo "5. IO"

echo "Enter event numbers (space-separated): "              # taking the event detailed
echo "REALTIME OR CPUTIME is mandatory"
read -r event_numbers

if [ -z "$event_numbers" ]; then                                    
    echo "Error: No event numbers entered"
    exit 1
fi

echo "Do you want tracing in profiling //// (type yes)"         # asking for tracing the profile
read tracing                                                        # storing the tracing in variable

declare -a events
for event_number in $event_numbers; do                                  # append the event details
    case $event_number in
        1) events+=("REALTIME");;
        2) events+=("CPUTIME");;
        3) events+=("perf::CACHE-MISSES");;
        4) events+=("MEMLEAK");;
        5) events+=("IO");;
        *) 
            echo "Error: Invalid event number: $event_number"
            echo "Please enter event numbers (1-5)"
            exit 1
            ;;
    esac
done

# Check if both REALTIME and CPUTIME are selected
if [[ "${events[*]}" == *"REALTIME"* && "${events[*]}" == *"CPUTIME"* ]]; then      
    echo "Error: Cannot select both REALTIME and CPUTIME at the same time"
    exit 1
fi

event_string=""
for event in "${events[@]}"; do
    event_string+=" -e $event"
done

if [[ $tracing == "yes" ]]; then            # if tracing is selected then this is run
    ulimit -s unlimited                         # when we execute the file it should increase the limit of size
    hpcrun $event_string -t $exe_name           # this is hpctoolkit first command
    echo "hpcrun $event_string -t $exe_name"

    executable_file="${exe_name##*/}"               # executable file absolute path is taken
                                                        # by this only name of execuatable file is taken 
                                                         # and stored in the executable_file variable name

    # this is the next final command of the hpctoolkit

    hpcstruct ./hpctoolkit-$executable_file-measurements/  
    hpcprof ./hpctoolkit-$executable_file-measurements/
    hpcviewer ./hpctoolkit-$executable_file-database/

else
    ulimit -s unlimited                         # if tracing is not selected then this is run 
    hpcrun $event_string $exe_name                 # when we execute the file it should increase the limit of size
    echo "hpcrun $event_string $exe_name"                # this is hpctoolkit first command

    executable_file="${exe_name##*/}"                        # executable file absolute path is taken
                                                        # by this only name of execuatable file is taken 
                                                         # and stored in the executable_file variable name

    # this is the next final command of the hpctoolkit

    hpcstruct ./hpctoolkit-$executable_file-measurements/
    hpcprof ./hpctoolkit-$executable_file-measurements/
    hpcviewer ./hpctoolkit-$executable_file-database/
fi
echo " *****************************THANK YOU VISIT AGAIN ********************************** "
