devies=`cat devices.txt | grep -B 9 $1 | grep -A 1 UDID`
command=$2
for d in $devies; do
  if [[ $d =~ "<string>" ]]; then
    folder=`echo "$d" | sed 's/<string>\(.*\)<\/string>/\1/'`
    echo "Removing: $folder"
    echo "\tDevice "`cat Devices/$folder/device.plist`
    if [[ $command == "do" ]]; then
      echo "\tREMOVING"
      rm -rfv Devices/$folder
    fi
  fi
done


