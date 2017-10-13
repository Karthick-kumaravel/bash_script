############################################################## Paste the generated public key to the remote machine ###############################################################

#!/bin/bash

ip=`cat /root/kk/password.txt | awk '{print $1}'`

for i in  $ip
do
password=`cat /root/kk/password.txt | grep $i | awk '{print $2}'`
`sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "if [ ! -d /root/.ssh ]; then     mkdir -p /root/.ssh/authorized_keys; fi" >/dev/null 2>&1`
status=`echo $?`
        if [ $status -eq 0 ]
        then
                key="'`cat /root/.ssh/id_rsa.pub`'"
                `sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "grep -qF $key /root/.ssh/authorized_keys || echo $key >> /root/.ssh/authorized_keys" >/dev/null 2>&1`
                `sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "chmod 700 /root/.ssh; chmod 600 /root/.ssh/authorized_keys"`
                echo "$i ----> done"
        elif [ $status -eq 5 ]
        then
                echo "Password incorrect, Please check"
        elif [ $status -eq 255 ]
        then
                echo "Server is not reachable"
        fi
done


Note:-
     i) /root/kk/password.txt - File contains Ip or hostname in the 1st column and the password in the second column
