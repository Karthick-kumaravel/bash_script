#!/bin/bash

ip=`grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' /root/kk/password.txt`
`> /root/kk/password_new`
for i in $ip; do
	old_password=`cat /root/kk/password.txt | grep $i | awk '{print $2}'` 
	new_password=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -1`	
	ssh -o StrictHostKeyChecking=no root@$i "yes "$new_password" | passwd root > /dev/null 2>&1" >/dev/null 2>&1 
	sshpass -p $new_password ssh -o StrictHostKeyChecking=no -o  PreferredAuthentications=password root@$i "echo $? >/dev/null 2>&1" >/dev/null 2>&1
		if [ $? -eq 0 ]
		then
			echo "$i $new_password" >> /root/kk/password_new
			echo "" >> /root/kk/password_new
		else 
			echo "$i $old_password --------> Password not set/old password taken" >> /root/kk/password_new
			echo "" >> /root/kk/password_new
		fi
done

`rm -f /root/kk/password.txt`
`cp -f /root/kk/password_new /root/kk/password.txt`
exit 0
