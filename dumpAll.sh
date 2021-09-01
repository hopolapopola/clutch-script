#!/bin/bash
echo "This may take a hot minute so sit back and relax"
clutch -i > /var/mobile/clutch.txt
sed 's/: .*//' /var/mobile/clutch.txt > /var/mobile/clutch.txt.tmp
tail -n 1 /var/mobile/clutch.txt.tmp > /var/mobile/clutch.txt
rm /var/mobile/clutch.txt.tmp
num=$(cat /var/mobile/clutch.txt) 
i=1
while [ $i -lt $num ]
do
    clutch -d $i
    ((i++))
done
rm /var/mobile/clutch.txt
echo "Done! Check /var/mobile/Documents/Dumped for your dumped apps :)"

