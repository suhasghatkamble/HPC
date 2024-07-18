#!/bin/bash



echo " **********************WELCOME TO GPROF PROFILER ********************************"
echo " ******************************************************************************* "
echo " ******************************************************************************* "
echo " ******************************************************************************* "

echo "Enter program file ABSOLUTE path" # taking the program file absolute path 
read filePath                               # storing the file path in the variable

if [ "${filePath##*.}" == "c" ]; then               # checking the entered file is c program or not c program
    if gcc -pg "$filePath" -std=c99 -o "output"; then       # if c program
                                                            # compiling the c program
        ./output                                              # running the executable file
        executable_file="output"                                # storing the name of the executable file name in another variable

        gprof $executable_file gmon.out > "analysis.txt"        # running the final gprof command and putting the appropriate file name to the place of file path
                                                                    # storing the information created after running the gprof command in the analysis.txt file
    else
        echo "Compilation failed."
    fi

elif [ "${filePath##*.}" == "cpp" ]; then           # checking the cpp program 
    if g++ "$filePath" -o "output"; then                   # compiling the cpp program
        ./output                                        # running the executable file
        executable_file="output"        
        gprof $executable_file ./"gmon.out" > "analysis.txt"    # running the final gprof script
                                                                    # storing the information in analysis.txt file
    else
        echo "Compilation failed."
    fi

else
    echo "The file is not a C or C++ source file."
fi

vim "analysis.txt"                              # displaying the final txt file where all information
                                                    # is stored 



echo " *********************THANK YOU ***************************************** "
