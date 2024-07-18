#!/bin/bash


advisor()
{

    available_modules=$(module avail | grep advisor)

    echo "Available modules:"
    i=1
    for module in $available_modules; do
        if [[ $module =~ ^advisor ]];then
            echo "$i.$module"
            i=$((i+1))
        fi
    done

    while true; do
        echo "Enter the number of the module to load: "
        read module_number

        case "$module_number" in
        1) module load advisor/latest && break ;;
                
        2) module load advisor/2023.0.0 && break ;;
        
        *) echo -e "\n option is not available. Please try again. \n "  ;;
        esac
    done

    while true; do
        echo "Enter the generation name from list: "
        echo "1. xehpg_256xve  :  Intel® Arc™ graphics with 256 vector engines"
        echo "2. xehpg_512xve  :  Intel® Arc™ graphics with 512 vector engines"
        echo "3. gen12_tgl     :  Intel® Iris® Xe graphics"
        echo "4. gen12_dg1     :  Intel® Iris® Xe MAX graphics"
        echo "5. gen11_icl     :  Intel® Iris® Plus graphics"
        echo "6. gen9_gt2      :  Intel® HD Graphics 530"
        echo "7. gen9_gt3      :  Intel® Iris® Graphics 550"
        echo "8. gen9_gt4      :  Intel® Iris® Pro Graphics 580"
        read gen_num

        case "$gen_num" in
            1) gen_num="xehpg_256xve" ; break;;
            2) gen_num="xehpg_512xve" ; break;;
            3) gen_num="gen12_tgl" ; break;;
            4) gen_num="gen12_dg1" ; break;;
            5) gen_num="gen11_icl" ; break;;
            6) gen_num="gen9_gt2" ; break;;
            7) gen_num="gen9_gt3" ; break;;
            8) gen_num="gen9_gt4" ; break;;
            *) echo -e "\n Target GPU not available. Please try again.\n" ;;
        esac
    done

    echo "Enter the folder name to store file : "
    read -r store_path

    while true; do
        echo "Choose one of the following"
        echo "1.Program file (C / C++ file)"
        echo "2.executable file"
        read file_num

        case "$file_num" in
            1) echo "Enter ABSOLUTE file path"
                read -r filePath

                if [ "${filePath##*.}" == "c" ]; then
                    gcc "$filePath" -std=c99 -o "output" && ./output
                    executable_file="output"
                    break

                elif [ "${filePath##*.}" == "cpp" ]; then
                    g++ "$filePath" -o "output" && ./output
                    executable_file="output"
                    break

                else
                    echo "The file is not a C or C++ source file."
                fi
                ;;

            2) 
                echo "Enter executable ABSOLUTE name"
                read full_path
                executable_file="${full_path##*/}"
                
                if [ -f "./$executable_file" ]; then
                    echo "Running Advisor..."
                    echo "advisor --collect=offload --config=$gen_num --project-dir=./$store_path -- ./executable_file"
                    advisor --collect=offload --config="$gen_num" --project-dir="./$store_path" -- ./"$executable_file"
                    break
                else
                    echo "Error: Executable file $executable_file does not exist in the directory."
                    exit 1
                fi
                ;;

            *)
                echo -e "\n File not found. Please try again.\n"
                ;;
        esac
    done

    # Run Advisor

    echo "advisor --collect=offload --config=$gen_num --project-dir=./$store_path -- ./$executable_file"
    advisor --collect=offload --config="$gen_num" --project-dir="./$store_path" -- ./"$executable_file"




    # Open Advisor report
    xdg-open "$store_path/e000/report/advisor-report.html"  || echo "Failed to open the Advisor report."
    echo "Script execution completed."
}

vtune()
{

    echo "Enter the name of the module (e.g. vtune/latest): "
    read -r name

    while true; do
        if [[ ! -z "$name" ]]; then
            if module load "$name" 2>/dev/null; then
                echo "Module loaded successfully!"
                break
            else
                echo "Failed to load $name."
                echo "Try again."
            fi
        else
            echo "Module name cannot be empty"
            echo "Try again."
        fi
    done

    while true; do    
        echo "TYPE 1 for single application profiling"
        echo "TYPE 2 for dual application profiling"
        read prof
        
        if [[ $prof -eq 1 ]]; then
            while true; do
                echo "Enter the path of the project directory: "
                read -r path
                if [[ -d "$path" ]]; then
                    echo "Folder already exists."
                    echo "Try again."
                else
                    echo "Creating directory..."
                    if mkdir -p "$path"; then
                        echo "Output directory created successfully."
                        break
                    else
                        echo "Failed to create directory. Please try again."
                    fi
                fi
            done


            while true; do
                echo "Enter path for executable"
                read -r executable
                if [[ -f "$executable" ]]; then
                    echo "Successfully found executable."
                    break
                else
                    echo "Failed to find executable. Please try again."
                fi
            done

            vtune --collect=hotspot --result-dir=$path -- $executable

            break

        elif [[ $prof -eq 2 ]]; then
            while true; do
                echo "Enter the path of the project directory for application 1: "
                read -r path
                if [[ -d "$path" ]]; then
                    echo "Folder already exists."
                    echo "Try again."
                else
                    echo "Creating directory..."
                    if mkdir -p "$path"; then
                        echo "Output directory created successfully."
                        break
                    else
                        echo "Failed to create directory. Please try again."
                    fi
                fi
            done

            while true; do
                echo "Enter the path of the project directory for application 2: "
                read -r path2
                if [[ -d "$path2" ]]; then
                    echo "Folder already exists."
                    echo "Try again."
                else
                    echo "Creating directory..."
                    if mkdir -p "$path2"; then
                        echo "Output directory created successfully."
                        break
                    else
                        echo "Failed to create directory. Please try again."
                    fi
                fi
            done


            while true; do
                echo "Enter ABSOLUTE path for executable #1"
                read -r executable
                if [[ -f "$executable" ]]; then
                    echo "Successfully found executable."
                    break
                else
                    echo "Failed to find executable. Please try again."
                fi
            done

            while true; do
                echo "Enter ABSOLUTE path for executable #2"
                read -r executable2
                if [[ -f "$executable2" ]]; then
                    echo "Successfully found executable."
                    break
                else
                    echo "Failed to find executable. Please try again."
                fi
            done

            vtune --collect=hotspot --result-dir=$path -- $executable
            vtune --collect=hotspot --result-dir=$path2 -- $executable2
            break
        fi

    done

    vtune -report hotspots -r $path -r $path2 --column="Result 1:CPU Time:Self" --column="Result 2:CPU Time:Self" 


}

hpctoolkit()
{
        
    source /home/apps/spack/share/spack/setup-env.sh
    spack load hpctoolkit

    echo "Enter Executable file ABSOLUTE path : "
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

        hpcstruct hpctoolkit-$executable_file-measurements/
        hpcprof hpctoolkit-$executable_file-measurements/
        hpcviewer hpctoolkit-$executable_file-database/

    else
        ulimit -s unlimited
        hpcrun $event_string $exe_name
        echo "hpcrun $event_string $exe_name"

        executable_file="${exe_name##*/}"

        hpcstruct hpctoolkit-$executable_file-measurements/
        hpcprof hpctoolkit-$executable_file-measurements/
        hpcviewer hpctoolkit-$executable_file-database/
    fi
}

gprof()
{
        
    echo "Enter file ABSOLUTE path"
    read filePath

    if [ "${filePath##*.}" == "c" ]; then
        if gcc -pg "$filePath" -std=c99 -o "output"; then
            ./output
            executable_file="output"
            gprof $executable_file gmon.out > "analysis.txt"
        else
            echo "Compilation failed."
        fi

    elif [ "${filePath##*.}" == "cpp" ]; then
        if g++ "$filePath" -std=c99 -o "output"; then
            ./output
            executable_file="output"
            gprof $executable_file ./"gmon.out" > "analysis.txt"
        else
            echo "Compilation failed."
        fi

    else
        echo "The file is not a C or C++ source file."
    fi

    vim "analysis.txt"
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


















