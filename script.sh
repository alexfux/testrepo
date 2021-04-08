#!/bin/bash


ip=$(cat /var/log/secure | egrep -o  "([0-9]{1,3}\.){3}[0-9]{1,3}")
acc=$(cat /var/log/secure | grep "Accepted" | awk -F " " '{print $11}' | sort -u)
acc2=$(echo $acc | wc -w)
counter=0
counter2=0
date=$(date)

echo "
Report For: $date

Total authorised ip adresses: $acc2.

These are the ip addresses that were accepted and their origin:"

for u in $acc ;do
        co=$(whois $u | grep -i "country" | awk -F " " '{print $2}'| sort -u)
        ec=ho "$u came from $co"
done

for i in $ip ;do
        if  [ $i != 192.168.1.101 ];then
                let counter=counter+1
        else
                let counter2=counter2+1
        fi
done

allco=$(($counter+$counter2))

echo "
Total ip entries in the log file : $allco
There were $counter entries from unauthorised ip addresses.
There were $counter2 entries from my addresses.

End of report." | tee mail.txt

#echo "
#Report For: $date

#Total authorised ip adresses: $acc2.

#These are the ip addresses that were accepted:
#$acc

#Total entries: $allco
#There were $counter entries from unauthorised ip addresses.
#There were $counter2 entries from my addresses.

#End of report." | tee mail.txt


#mail -s "Suspicous Activity Report" alexfux@gmail.com < mail.txt



i am addig stuff to test 222

this should be on the new branch        