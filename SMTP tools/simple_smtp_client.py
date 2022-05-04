#! /usr/bin/python3
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import re
import smtplib
import time
import sys

smtp_password = ""
username = ""
smtphost = "" # Format: smtp.example.com:25

email_subject = ""
message = """ 
"""

def check_email_valid(email):
    regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
    if(re.fullmatch(regex, email)):
        return 0
    else:
        return 1

def _prepare_args():
    if len(sys.argv) != 3:
        print(f"[x] Usage: {sys.argv[0]} from@email.com to@email.com")
        sys.exit(1)
    from_send = sys.argv[1]
    to_send = sys.argv[2]
    # Checar argumentos:
    invalid_from = 0
    invalid_to = 1
    invalid_from_send = ""
    invalid_to_send = ""
    if check_email_valid(from_send):
        invalid_from_send = f"[x] Invalid email: {from_send}"
        invalid_from += 1
    if check_email_valid(to_send):
        invalid_to_send = f"[x] Invalid email: {to_send}"
        invalid_to += 1
    if invalid_from:
        print(invalid_from_send)
    if invalid_to:
        print(invalid_to_send)
    if invalid_from_send != "" or invalid_to_send != "":
        print("XX")
        exit(1)
    return from_send, to_send


def _prepare_email(message, remitente, destinatario, asunto):
    msg = MIMEMultipart()
    msg['From'] = str(remitente)
    msg['To'] = str(destinatario)
    msg['Subject'] = email_subject
    msg.attach(MIMEText(message, 'plain'))
    return msg

def _sendmail(msg):
    try:
        time.sleep(1)
        print("[i] OK")
        time.sleep(1)
        print(f"[i] Sending email:")
        time.sleep(0.5)
        print(f"\tfrom \t{sys.argv[1]}\n\tto\t{sys.argv[2]}\n")
        # PARAMS START

        ###
        server = smtplib.SMTP(smtphost)
        server.starttls()
        server.login(username, smtp_password)
        server.sendmail(msg['From'], msg['To'], msg.as_string())
        server.quit()
        print("[+] Successfully sent email message to %s:" % (msg['To']))
    except Exception:
        print("[-] Error sending mail:")
        print(Exception)

sender, recipient = _prepare_args()
msg = _prepare_email(message, sender, recipient, email_subject)
sendemail = _sendmail(msg, smtp_password, username, smtphost)
