#!/bin/bash
# vague
# continually downloads a new ai generated image.

# it returns nothing otherwise
userAgent='Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.82 Safari/537.36 Vivaldi/2.3.1440.41'

# add some jitter for fun
jitterTime(){
	t=$(( $1 * 100)) 	# base time
	l=$(( ($2-1) * 100)) 	# tolerance
	major=$(( ( ($t - $l )  + ( RANDOM % (2 * ($l+50)))) / 100 ))
	minor=$((RANDOM % 10000))
	echo $major.$minor
}

sleep(){
	echo waiting for $@
	command sleep $@
}

# time between gets
time=3
# add some jitter for fun
tolerance=3	

# setup download directory
mkdir -p images
pushd images || { echo cant cd to download dir ; exit ; }

# main loop
while true ; do
	randomFileName=$(cat /dev/urandom | tr -cd '0-9' | head -c 25)
	wget https://thispersondoesnotexist.com/image -O $randomFileName.jpg -U "$userAgent"
	sleep $(jitterTime $time $tolerance)
done
