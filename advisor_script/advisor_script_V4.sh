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
  
  read gen

  case "$gen" in
    ("xehpg_256xve" | "xehpg_512xve" | "gen12_tgl" | "gen12_tg1" | "gen11_icl" | "gen9_gt2" | "gen9_gt3" | "gen9_gt4")
      break
      ;;
    *)
      echo -e "\n The name $gen is not available. Please try again.\n"
      ;;
  esac
done

echo "Enter the full path to store file : "
read store_path

echo "Enter the file name"
read file_name

echo "advisor --collect=offload --config=$gen --project-dir=./$store_path -- ./$file_name"
advisor --collect=offload --config=$gen --project-dir=./$store_path -- ./$file_name
