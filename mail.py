################################################    Email the changed passwd  ####################################################

#!/usr/bin/python

import os
import smtplib
import subprocess

         
TO = 'name@domain.com'                              # To email-address
BCC = 'name@domain.com'				                      # Bcc email address
SUBJECT = '##### Server Password #####'             # Subject of the email
	
f = open('/root/kk/password.txt', 'r')              # '/root/kk/password.txt' is the file contains the output of the password.sh
TEXT = f.read()
f.close()

	
sender = 'name@domain.com'                          # Sender email-address
passwd = 'password'                                 # Sender email-address's password

server = smtplib.SMTP('smtp.domain.com', 587)       # SMTP of the server
server.ehlo()                                       # ESMTP
server.starttls()                                   # TLS
server.ehlo()
server.login(sender, passwd)


BODY = '\r\n'.join([
       	'To: %s' % TO,
	'From: %s' % sender,
	'subject: %s' % SUBJECT,
	'',
	TEXT
	])
try:
	server.sendmail(sender, [TO, BCC], BODY)
	print 'email sent'
except:
        print 'error'
