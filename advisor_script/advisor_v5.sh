#!/bin/bash
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
    echo "enter number of module"
    read module_number

case "$module_number" in
  1) module load advisor/latest
      break ;;
         
  2) module load advisor/2023.0.0
      break ;;
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
    4) gen_num="gen12_tg1" ; break;;
    5) gen_num="gen11_icl" ; break;;
    6) gen_num="gen9_gt2" ; break;;
    7) gen_num="gen9_gt3" ; break;;
    8) gen_num="gen9_gt4" ; break;;
    *)
      echo -e "\n Target GPU not available. Please try again.\n"
      ;;
  esac
done

echo "Enter the full path to store file : "
read store_path

while true; do
echo "Choose one of the following"
echo "1.Program file"
echo "2.executable file"

read file_num

case "$file_num" in
    1) echo "Enter file path"
       read filePath

        # if [ "${filePath##*.}" == "c" ]; then
        #     gcc "$filePath" -o "${filePath%.c}" && ./${filePath%.c}
        #     break
        # elif [ "${filePath##*.}" == "cpp" ]; then
        #     g++ "$filePath" -o "${filePath%.cpp}" && ./${filePath%.cpp}
        #     break
        
        if [ "${filePath##*.}" == "c" ]; then
            gcc "$filePath" -o "output" &&./output
            executable_file="output"
            break

        elif [ "${filePath##*.}" == "cpp" ]; then
            g++ "$filePath" -o "output" &&./output
            executable_file="output"
            break

        else
            echo "The file is not a C or C++ source file."
        fi
        ;;

    # 2) echo "enter exe file name"
    #    read executable_file

    #    return executable_file
    #    ;;

    # executable_file="${full_path##*/}"
    # or
    # executable_file=$(basename "$full_path")


    # or

    # if [ -f "./$executable_file" ]; then
    # echo "
    

    2) echo "enter exe file name with full path"
        read full_path
        executable_file="${full_path##*/}"
        break
        ;;

    *)
      echo -e "\n File not found. Please try again.\n"
      ;;
esac
done

echo "advisor --collect=offload --config=$gen_num --project-dir=./$store_path -- ./executable_file"
advisor --collect=offload --config=$gen_num --project-dir=./$store_path -- ./$executable_file

