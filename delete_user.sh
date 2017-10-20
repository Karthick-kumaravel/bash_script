#############################################  Delete the User in Remore Server #############################################

#!/bin/bash
ip=`grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' /root/kk/password.txt`

for i in $ip; do
        password=`cat /root/kk/password.txt | grep $i | awk '{print $2}'`
        `sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "cat /etc/passwd | grep -w $1" >/dev/null 2>&1`
        status=`echo $?`
                if [ $status -eq 0 ]
                then
                        sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "userdel -r $1" >/dev/null 2>&1
                        echo "$1 account deleted"
                elif [ $status -eq 2 ]
                then
                        echo "User name required,Please give the user name"
                elif [ $status -eq 1 ]
                then
                        echo "$1 account does not exist"
                elif [ $status -eq 5 ]
                then
                        echo "Pub key is not matching and Password is incorrect, Please check the password/key"
                elif [ $status -eq 255 ]
                then
                        echo "Server is not reachable"
                fi
done

Note:-
     i) /root/kk/password.txt - File contains Ip or Hostname in the 1st column and the password in the second column
    ii) The script shoul be executed as "sh delete_user.sh 'name of the user'"
