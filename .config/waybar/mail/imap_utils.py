import secrets

import subprocess
import imaplib
import json
import time
import sys

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

def parse_data(byte_arr):
    byte_arr = byte_arr.replace(b' ', b'","')
    byte_arr = byte_arr.replace(b'(', b'",["')
    byte_arr = byte_arr.replace(b')', b'"]"')
    byte_arr = b'["' + byte_arr + b'"]'
    byte_arr = byte_arr.replace(b'"",', b'')
    byte_arr = byte_arr.replace(b'""', b'')
    byte_arr = byte_arr.replace(b'\\', b'\\\\')
    return json.loads(byte_arr)

def brief(content):
    eprint(content)
    content = content[1].split(b'\r\n\r\n')
    headers = content[0].split(b'\r\n')
    message = b'\r\n'.join(content[1:])
    sender = [h for h in headers if h.startswith(b'From:')][0] or b'h: Unknown'
    sender = sender.split(b':')[1].strip()
    subject = [h for h in headers if h.startswith(b'Subject:')][0] or b'h: Subject unknown'
    subject = subject.split(b':')[1].strip()
    eprint(headers)
    eprint(message)
    return (sender.decode('utf-8'), subject.decode('utf-8'), message.decode('utf-8'))

def make_notification(id, email):
    f, s, b = brief(email)
    title = f'Email: {f.replace('<', '').replace('>', '')}'
    subtitle = s
    content = b
    if subtitle.lower().find('wazuh') != -1: 
        subtitle = "Wazuh: " + subtitle.split(' - ')[1].strip()
        content = [l for l in b.split('\r\n') if l.startswith('Rule:')][0] or 'r: Unknown rule fired'
        content = content.split('->')[1].strip() or content
    subprocess.call(['notify-send', '-a', 'IMAP MAIL:'+id, f'{title}\n{subtitle}', content])

def get_unread(mail):
    mail.select('INBOX')
    status, response = mail.search(None, 'UNSEEN')
    eprint(status)
    eprint(response)
    response = set(map(lambda b: b.decode('utf-8'), response[0].split()))
    return response

def notify_with_email(mail, id):
    eprint("Fetching email: ", id)
    mail.select("INBOX")
    typ, data = mail.fetch(id, "(RFC822)")
    data = data[0]
    mail.store(id, '-FLAGS', '\\Seen')
    eprint("Fetch typ: ", typ)
    make_notification(id, data)

def notify_latest(mail):
    unread = get_unread(mail)
    if len(unread) == 0:
        eprint("There are no new emails")
        return
    eprint(unread)
    getmail = max(unread)
    eprint(getmail)
    notify_with_email(mail, getmail)

def clear_inbox(mail):
    unread = get_unread(mail)
    for u in unread:
        mail.store(u, '+FLAGS', '\\Seen')

def main():
    mail = imaplib.IMAP4_SSL(secrets.HOST)
    mail.login(secrets.USER, secrets.PASS)
    mail.select("INBOX")
    eprint('Connected')
    if sys.argv[1] == 'read':
        mail.store(sys.argv[2], '+FLAGS', '\\Seen')
    if sys.argv[1] == 'delete':
        mail.store(sys.argv[2], '+FLAGS', '\\Seen')
        mail.store(sys.argv[2], '+FLAGS', '\\Deleted')
    if sys.argv[1] == 'expunge':
        mail.expunge()
    if sys.argv[1] == 'clear':
        clear_inbox(mail)
    if sys.argv[1] == 'notify-latest':
        notify_latest(mail)

if __name__ == "__main__":
    main()
