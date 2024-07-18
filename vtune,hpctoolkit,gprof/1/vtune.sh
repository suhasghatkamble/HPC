#!/bin/bash


echo " ************************* WELCOME TO VTUNE ****************************** "
echo " ************************************************************************* "
echo " ************************************************************************* "
echo " ************************************************************************* "


echo "Please enter the name of the module : "  # here we are taking module name
                                                    # to load the module

echo "Here is the example , you can type this ** (vtune/latest) **** :"  # here one of the example
                                                                          # is shown

read -r vtune_name                                        # name is the variable to store the name 
                                                        # of the vtune module name

while true; do
    if [[ ! -z "$vtune_name" ]]; then   
        if module load "$vtune_name" 2>/dev/null; then  # here checking module name is written or not written 
            echo "Module loaded successfully!"      # displays module loaded properly
            break
        else
            echo "Failed to load $vtune_name."
            echo "Try again."
        fi
    else
        echo "Module name cannot be empty"      # if module name is not written then try again should be displayed.
        echo "Try again."
    fi
done

while true; do    
    echo "TYPE 1 for running vtune profiling for application"   # taking number 
    read numbers  
    
    if [[ $numbers -eq 1 ]]; then       # checking the number is equal to 1 . if yes it will proceed
        while true; do
            echo "Enter the path of the project directory: "
            read -r directory_path                # taking directory path for project directory to store the 
                                            #files and directories created by running the vtune final command
            
            if [[ -d "$directory_path" ]]; then   # checking the entered  directory path exists or not exists

                echo "Folder already exists."
                echo "Try again."
            else
                echo "Creating directory..."
                if mkdir -p "$directory_path"; then       # creating the directory if not exists
                    echo "Output directory created successfully."
                    break
                else
                    echo "Failed to create directory. Please try again."
                fi
            fi
        done


        while true; do
            echo "Enter path for executable"
            read -r executable_path # taking the executable file name 

            if [[ -f "$executable_path" ]]; then     # checking the Executable file is present or not
                echo "Successfully found executable."
                break
            else
                echo "Failed to find executable. Please try again."
            fi
        done

        vtune --collect=hotspot --result-dir=./$directory_path -- ./$executable_path 
                                                            #running the final vtune command 

        break

    fi

done

vtune-gui ./$directory_path/$directory_path.vtune

echo " ***********************THANK YOU VISIT AGAIN ********************************* "

