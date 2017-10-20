##################################################################  Crete User (sudo) in the Remote Server #################################################################                                        

#!/bin/bash
ip=`grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' /root/kk/password.txt`

for i in $ip; do
        password=`cat /root/kk/password.txt | grep $i | awk '{print $2}'`
        `sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "cat /etc/passwd | grep -w $1" >/dev/null 2>&1`
        status=`echo $?`
                if [ $status -eq 1 ]
                then
                        user_password=Password@123
                        sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "useradd $1 && echo '$1 ALL=(ALL) ALL' >> /etc/sudoers" >/dev/null 2>&1
                        sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "yes "$user_password" | passwd $1 && chage -d 0 $1 > /dev/null 2>&1" >/dev/null 2>&1
                        echo "$1 account created and added as a sudo user "
                elif [ $status -eq 2 ]
                then
                        echo "User name required,Please give the user name"
                elif [ $status -eq 0 ]
                then
                        echo "$1 account already exist"
                elif [ $status -eq 5 ]
                then
                        echo "Pub key is not matching and Password is incorrect, Please check the password/key"
                elif [ $status -eq 255 ]
                then
                        echo "Server is not reachable"
                fi
done

echo "Password for the user $1 is $user_password"



Note:-
     i) /root/kk/password.txt - File contains Ip or Hostname in the 1st column and the password in the second column
    ii) The script shoul be executed as "sh create_user.sh 'name of the user'"
