#!/bin/bash

#This simple bash script copies all videos from your GoPro sd-card to the specified directory inside Videos directory.
#Only full video files, not preview files or thumbnails. 
#The name of the copied files will be the date and time when the video was recorded.

# If there are less than 2 parameters, show instructions and exit.
if [ $# -lt 1 ]; then
    echo "Usage: bash copyFromGoPro.sh destination_folder [timezone_difference]"
    exit 1
fi

gopro_dir = $(find /media -type d -name "*GOPRO*")
new_dir=/home/$USER/Videos/$1
if [ ! -d "$new_dir" ]; then
  mkdir $new_dir
fi

#Timezone_difference considers the hour difference between the location where the clip was recorded and your local time
if [ "$2" ]; then
	hour_difference=$2
else
	hour_difference=0
fi

for filename in $gopro_dir/*.MP4; do
	date_file=$(date -d "$(date -Iseconds -r $filename) + $hour_difference hours" | awk '{print $2"_"$3"_"$4}')
	cp $filename $new_dir/$date_file
done 

