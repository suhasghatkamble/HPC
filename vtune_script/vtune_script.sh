#!/bin/bash
available_modules=$( module avail | grep vtune)

echo "Available modules:"
i=1
for module in $available_modules; do
    if [[ $module =~ ^vtune ]];then
        echo "$i.$module"
        i=$((i+1))
    fi
done



while true; do
    echo "enter number of module"
    read module_number

case "$module_number" in
  1) module load vtune/latest
      break ;;
         
  2) module load vtune/2023.0.0
      break ;;
  *) echo -e "\n option is not available. Please try again. \n "  ;;
  esac
done






while true; do
    echo "enter collect name number : "
    echo "1. hotspot"
    echo "2. abcd"

    read collect_name

case "$collect_name" in
    1) collect_name="hotspot" ; break;;
    2) collect_name="abcd" ; break;;
    *) echo "Collect_name is not available. \n"
        ;;
    esac
done




# export executable_file




echo "Choose one of the following"
echo "1.Program folder path"
echo "2.executable file"

read -p "Your choice : " file_num
while true; do
case "$file_num" in
    1 )
        echo ""
        read -p "Enter valid absolute path where you want to store you report folder : " ABSOLUTE_FOLDER_PATH
        echo "-"
        echo "-"
        echo "-"

        if [ -d "$ABSOLUTE_FOLDER_PATH" ]; then
            echo "Your folder is not presented. "
            echo "Create a folder name Report will store in it "
             read -p  "Enter folder name : " REPORT_FOLDER_NAME

        
                if [ ! -d "./$REPORT_FOLDER_NAME" ]; then

                    echo "-"
                    echo "-"
                    echo "Ented folder name is not present "
                    echo "You can store you report in folder"
                    
                    mkdir $REPORT_FOLDER_NAME

                    echo "-"
                    echo "-"

                    read -p "Enter executable file : " executable_file

                    
                    
                break
                else
                    echo "Folder $report_folder already exist in the directory."
                fi
            else
                echo "Enter path is not valid "
                echo "-------------------------------------------------------"
        fi
        ;;

    2) 
        echo "enter exe file name"
        read full_exe_path
        executable_file="${full_exe_path##*/}"
        
        if [ -f "./$executable_file" ]; then
            echo "vtune --collect=$collect_name --result-dir=./$report_folder -- ./$executable_file"
            vtune --collect=$collect_name --result-dir=./$report_folder -- ./$executable_file
            break
        else
            echo "Error: Executable file $executable_file does not exist in the directory."
            exit 1
        fi
    ;;



    esac


done



echo "vtune --collect=$collect_name --result-dir=./$REPORT_FOLDER_NAME -- $executable_file"
vtune --collect=$collect_name --result-dir=./$REPORT_FOLDER_NAME -- $executable_file

echo "-"           
echo "-"           
echo "-"           
echo "-"           
echo "-"
echo "Report has been generated "   
echo "-"           
echo "-"           
echo "-"           
echo "-"           
vtune-gui ./$REPORT_FOLDER_NAME/$REPORT_FOLDER_NAME.vtune
           








