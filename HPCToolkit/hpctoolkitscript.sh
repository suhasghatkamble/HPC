# #!/bin/bash


# source /home/apps/spack/share/spack/setup-env.sh
# spack load hpctoolkit

# echo "Enter exe file name : "
# read exe_name

# echo "Event lists : "
# ehco "1.REALTIME"
# echo "2.CPUTIME"
# echo "3.perf::CACHE-MISSES"
# echo "4.MEMLEAK"
# echo "5.IO"

# while true; do
#     echo "Enter event number "
#     read event_number

#     echo "Do you want tracing in profiling"
#     read tracing

# case $event_number in 
#     1)if [[ $tracing == "yes" ]];then
#         ulimit -s unlimited
#         hpcrun -e REALTIME -t ./$exe_name
#       else
#         hpcrun -e REALTIME ./$exe_name
#       fi

#     2)if [[ $tracing == "yes" ]];then
#         ulimit -s unlimited
#         hpcrun -e CPUTIME -t ./$exe_name
#       else
#         hpcrun -e CPUTIME ./$exe_name
#       fi

#     3)if [[$tracing == "yes"]];then
#         ulimit -s unlimited
#         hpcrun -e perf::CACHE-MISS -t ./$exe_name
#       else
#         hpcrun -e perf::CACHE-MISS ./$exe_name
#       fi
    
#     4)if [[ $tracing == "yes" ]];then
#         ulimit -s unlimited
#         hpcrun -e MEMLEAK -t ./$exe_name
#       else
#         hpcrun -e MEMLEAK ./$exe_name

#       fi
#     5)if [[ $tracing == "yes" ]];then
#         ulimit -s unlimited
#         hpcrun -e IO -t ./$exe_name
#     else
#         hpcrun -e IO ./$exe_name

#       fi
#     *) echo "Please enter correct event_number. \n"
#     ;;

#     esac
# done

# hpcstruct ./hpctoolkit-$exe_name-measurements/
# hpcprof ./hpctoolkit-$exe_name-measurements/
# hpcviewer ./hpctoolkit-$exe_name-database/

















# #!/bin/bash

# source /home/apps/spack/share/spack/setup-env.sh
# spack load hpctoolkit

# echo "Enter exe file name : "
# read exe_name

# echo "Event lists : "
# echo "1. REALTIME"
# echo "2. CPUTIME"
# echo "3. perf::CACHE-MISSES"
# echo "4. MEMLEAK"
# echo "5. IO"

# echo "Enter event numbers (space-separated): "
# read -r event_numbers

# echo "Do you want tracing in profiling"
# read tracing

# declare -a events
# for event_number in $event_numbers; do
#     case $event_number in
#         1) events+=("REALTIME");;
#         2) events+=("CPUTIME");;
#         3) events+=("perf::CACHE-MISS");;
#         4) events+=("MEMLEAK");;
#         5) events+=("IO");;
#         *) 
#             echo "Error: Invalid event number: $event_number"
#             echo "Please enter event numbers (1-5)"
#             exit 1
#             ;;
#     esac
# done

# # Check if both REALTIME and CPUTIME are selected
# if [[ "${events[*]}" == *"REALTIME"* && "${events[*]}" == *"CPUTIME"* ]]; then
#     echo "Error: Cannot select both REALTIME and CPUTIME at the same time"
#     exit 1
# fi

# for event in "${events[@]}"; do
#     if [[ $tracing == "yes" ]]; then
#         ulimit -s unlimited
#         hpcrun -e $event -t ./$exe_name
#         echo "hpcrun -e $event -t ./$exe_name"
#     else
#         ulimit -s unlimited
#         hpcrun -e $event ./$exe_name
#     fi
# done

# hpcstruct ./hpctoolkit-$exe_name-measurements/
# hpcprof ./hpctoolkit-$exe_name-measurements/
# hpcviewer ./hpctoolkit-$exe_name-database/


























# #!/bin/bash

# source /home/apps/spack/share/spack/setup-env.sh
# spack load hpctoolkit

# echo "Enter exe file name : "
# read exe_name

# echo "Event lists : "
# echo "1. REALTIME"
# echo "2. CPUTIME"
# echo "3. perf::CACHE-MISSES"
# echo "4. MEMLEAK"
# echo "5. IO"

# echo "Enter event numbers (space-separated): "
# read -r event_numbers

# echo "Do you want tracing in profiling"
# read tracing

# declare -a events
# for event_number in $event_numbers; do
#     case $event_number in
#         1) events+=("REALTIME");;
#         2) events+=("CPUTIME");;
#         3) events+=("perf::CACHE-MISS");;
#         4) events+=("MEMLEAK");;
#         5) events+=("IO");;
#         *) 
#             echo "Error: Invalid event number: $event_number"
#             echo "Please enter event numbers (1-5)"
#             exit 1
#             ;;
#     esac
# done

# # Check if both REALTIME and CPUTIME are selected
# if [[ "${events[*]}" == *"REALTIME"* && "${events[*]}" == *"CPUTIME"* ]]; then
#     echo "Error: Cannot select both REALTIME and CPUTIME at the same time"
#     exit 1
# fi

# event_string=""
# for event in "${events[@]}"; do
#     event_string+=" -e $event "
# done

# if [[ $tracing == "yes" ]]; then
#     ulimit -s unlimited
#     hpcrun $event_string -t ./$exe_name
#     echo "hpcrun $event_string -t ./$exe_name"
# else
#     ulimit -s unlimited
#     hpcrun $event_string ./$exe_name
#     echo "hpcrun $event_string -t ./$exe_name"
# fi

# hpcstruct ./hpctoolkit-$exe_name-measurements/
# hpcprof ./hpctoolkit-$exe_name-measurements/
# hpcviewer ./hpctoolkit-$exe_name-database/























#!/bin/bash

source /home/apps/spack/share/spack/setup-env.sh
spack load hpctoolkit

echo "Enter exe file path : "
read exe_name

echo "Event lists : "
echo "1. REALTIME"
echo "2. CPUTIME"
echo "3. perf::CACHE-MISSES"
echo "4. MEMLEAK"
echo "5. IO"

echo "Enter event numbers (space-separated): "
echo "REALTIME OR CPUTIME is mandatory"
read -r event_numbers

if [ -z "$event_numbers" ]; then
    echo "Error: No event numbers entered"
    exit 1
fi

echo "Do you want tracing in profiling //// (type yes)"
read tracing

declare -a events
for event_number in $event_numbers; do
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

if [[ $tracing == "yes" ]]; then
    ulimit -s unlimited
    hpcrun $event_string -t $exe_name
    echo "hpcrun $event_string -t $exe_name"

    executable_file="${exe_name##*/}"

    hpcstruct ./hpctoolkit-$executable_file-measurements/
    hpcprof ./hpctoolkit-$executable_file-measurements/
    hpcviewer ./hpctoolkit-$executable_file-database/
   
else
    ulimit -s unlimited
    hpcrun $event_string $exe_name
    echo "hpcrun $event_string $exe_name"

    executable_file="${exe_name##*/}"

    hpcstruct ./hpctoolkit-$executable_file-measurements/
    hpcprof ./hpctoolkit-$executable_file-measurements/
    hpcviewer ./hpctoolkit-$executable_file-database/
fi
