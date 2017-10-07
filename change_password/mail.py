#!/usr/bin/python

import os
import smtplib
import subprocess

         
TO = 'support@sixthstar.in'                              # To email-address
BCC = 'kaarthick.p.k@gmail.com'				    # Bcc email address
SUBJECT = '##### Server Password #####'      # Subject of the email
	
f = open('/root/kk/password.txt', 'r')                    # '/tmp/result.txt' is the file contains the output of the script-disk_alert_a.sh
TEXT = f.read()
f.close()

	
sender = 'support@sixthstar.in'                          # Sender email-address
passwd = 'C@bin*354'                                 # Sender email-address's password

server = smtplib.SMTP('star.sixthstar.in', 587)       # SMTP of the server
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
