######################################### Paste the generated public key to the remote machine #########################################

#!/bin/bash

ip=`cat password.txt | awk '{print $1}'`

for i in  $ip
do
password=`cat password.txt | grep $i | awk '{print $2}'`
`sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "if [ ! -d /root/.ssh ]; then     mkdir -p /root/.ssh; fi"`
#`sshpass -p $password scp /root/.ssh/id_rsa.pub root@$i:/root/.ssh/authorized_keys`
`cat /root/.ssh/id_rsa.pub | sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i 'cat >> /root/.ssh/authorized_keys' >/dev/null 2>&1`
`sshpass -p $password ssh -o StrictHostKeyChecking=no root@$i "chmod 700 /root/.ssh; chmod 600 /root/.ssh/authorized_keys"`
echo "$i ----> done"
done
