#!/bin/bash


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


vtune-gui ./$path/$path.vtune

