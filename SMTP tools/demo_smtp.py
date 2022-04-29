#! /usr/bin/python3
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import re
import smtplib
import time
import sys

email_subject = "Gracias"
message = """

<link href='https://fonts.googleapis.com/css?family=DM Sans' rel='stylesheet'>
<style>
body {
    font-family: 'DM Sans';font-size: 22px;
}
</style>

<tr> <td> <img alt="dp-banner" src="https://github.com/JArmandoG/files/blob/main/Screen%20Shot%202022-03-31%20at%2012.18.28.png?raw=true" width="100%" style="margin: 0; border: 0; padding: 0; display: block;"> </td> </tr>
<p>Este ejercicio fue realizado en un ambiente controlado, pero puede ser explotado por un tercero. Para evitar que esto suceda, recomendamos aplicar las configuraciones de seguridad adecuadas DKIM, DMARC, SPF para el correo electrónico.<br>
Para mayor información, ponte en contacto con un representante de Delta Protect.
<br>
Atentamente,<br>El equipo de Delta Protect</p>

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
        rel_p = "9zfPTjxZQt4YHCqI"
        username = "johndonym123@gmail.com"
        smtphost = "smtp-relay.sendinblue.com:587"
        server = smtplib.SMTP(smtphost)
        server.starttls()
        server.login(username, rel_p)
        server.sendmail(msg['From'], msg['To'], msg.as_string())
        server.quit()
        print("[+] Successfully sent email message to %s:" % (msg['To']))
    except Exception:
        print("[-] Error sending mail:")
        print(Exception)

remitente, destinatario = _prepare_args()
msg = _prepare_email(message, remitente, destinatario, email_subject)
sendemail = _sendmail(msg)
