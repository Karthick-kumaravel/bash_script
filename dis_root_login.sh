######################################################## Disable the Root user password login of the remote server ################################################################

#!/bin/bash
ip=`grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' /root/kk/password.txt`

for i in $ip; do
        password=`cat /root/kk/password.txt | grep $i | awk '{print $2}'`
        `sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "echo "PermitRootLogin without-password" >> /etc/ssh/sshd_config && /etc/init.d/sshd restart" >/dev/null 2>&1`
	status=`echo $?`
	if [ $status -eq 0 ]
	then
		echo "Root login disabled"
	elif [ $status -eq 5 ]
        then
        	echo "Pub key is not matching and Password is incorrect, Please check the password/key"
        elif [ $status -eq 255 ]
        then
        	echo "Server is not reachable"
        fi
done


Note:-
     i) /root/kk/password.txt - File contains Ip in the 1st column and the password in the second column
