#!/bin/bash
build_list() {
	#get total number of installed apps + list
	clutch -i > /var/mobile/installed_apps.txt
	#thanks u/AndyPea1230 for pointing me towards the wc command - i looked it up and turns out i'm an idiot lmao, this is way easier
	lines=$(wc -l < /var/mobile/installed_apps.txt)
	num=$(($lines - 1))
	cat /var/mobile/installed_apps.txt
	echo -e "\n"
}

dump_all() {
	i=1
	while [ $i -le $num ]
	do
   		clutch -d $i
		((i++))
	done
	echo "Done! Check /var/mobile/Documents/Dumped for your dumped apps :)"
}

dump_range() {
	echo "Please specify a range (i.e. 1-2, 3-7) to dump (refer to the list above for which apps are which"
	read -r range
	echo $range > /tmp/range
	range1=$(sed 's/\([^-]*\).*/\1/' /tmp/range)
	range2=$(sed 's/.*-//' /tmp/range)
	i=$range1
	while [ $i -le $range2 ]
	do
		clutch -d $i
		((i++))
	done
	echo "Done! Check /var/mobile/Documents/Dumped for your dumped apps :)"
}

main() {
	echo -e "clutch dumpAll script Copyright (C) 2022 riley/@hopolapopola\nThis program comes with ABSOLUTELY NO WARRANTY\nThis is free software, and you are welcome to resdistribute it\nunder certain conditions, see https://www.gnu.org/licenses/gpl-3.0.html\n"
	build_list
	echo -e "Hi! This is a (hopefully) helpful script that can dump all or a range of apps with clutch :) \nTo start, do you want to dump all or a range? \n\nall/range/cancel:"
	read -r selection
	if [ "$selection" == "range" ]; then
		dump_range
	elif [ "$selection" == "all" ]; then
		dump_all
	else
		exit
	fi
}
main
