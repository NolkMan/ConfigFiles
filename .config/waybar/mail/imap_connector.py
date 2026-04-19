import secrets

import imaplib
import json
import time
import sys
import psutil

from imap_utils import make_notification, get_unread, parse_data, notify_with_email

last_error = ""

def eprint(*args, **kwargs):
    print("WAYBAR/MAIL:", *args, file=sys.stderr, **kwargs)
    pass

def make_output(unread, error=""):
    global last_error
    MAIL_CLOSED = " "
    LETTER = "🗈"
    count = len(unread)

    # Logic for the addon
    text = MAIL_CLOSED
    if error != "":
        tooltip = error
        class_string = "disconnected"
        last_error = error
    else:
        class_string = "default"
        tooltip = f"{count} unread messages"
        if last_error != "":
            tooltip = tooltip + '\n' + last_error
        if count == 0:
            text = ""

    eprint(tooltip)
    output = {
        "text": text,
        "tooltip": tooltip,
        "class": class_string
    }
    # Print JSON for Waybar and flush immediately
    print(json.dumps(output))
    sys.stdout.flush()

def remove_mail(unread, id):
    if (id in unread):
        unread.remove(id)
        unread = set(map(lambda x: str(int(x)-1) if int(x) > int(id) else x, unread))
        eprint(unread)

def main():
    global last_error
    getmail = ""
    while True:
        try:
            # Connect and Login
            mail = imaplib.IMAP4_SSL(secrets.HOST)
            mail.login(secrets.USER, secrets.PASS)
            eprint('Connected')
            
            while True:
                unread = get_unread(mail)

                make_output(unread)
                eprint(unread)

                # Use IDLE to wait for changes 
                updates = 0
                with mail.idle(1*60) as idler:
                    for typ, raw_data in idler:
                        updates = updates + 1
                        eprint("'", typ, "', data:", raw_data)
                        if typ == 'EXISTS':
                            for d in raw_data:
                                d = parse_data(d)
                                if d[0]:
                                    unread.add(d[0])
                                    getmail = d[0]
                            make_output(unread)
                            last_error = ""
                            break
                            # TODO get what was added and make a notification out of it
                        elif typ == 'RECENT':
                            eprint("Idler received a  RECENT")
                            pass
                        elif typ == 'FETCH':
                            for d in raw_data:
                                d = parse_data(d)
                                id = d[0]
                                for flags in d[1:]:
                                    if flags[0] == 'FLAGS':
                                        eprint("Remaining flags:", flags[1])
                                        if '\\Seen' in flags[1]:
                                            remove_mail(unread, id)
                                        else:
                                            unread.add(id)
                                eprint(unread)
                                make_output(unread)
                        elif typ == 'EXPUNGE':
                            for d in raw_data:
                                d = parse_data(d)
                                eprint(d)
                                if d[0]:
                                    remove_mail(unread, d[0])
                                    make_output(unread)
                        elif typ == 'OK':
                            eprint("Idler received an OK")
                            last_error = ""
                            break
                        if updates > 3:
                            # If there were many updates, try to recover the current state
                            break
                if getmail != "":
                    try: 
                        eprint("Fetching email: ", getmail)
                        notify_with_email(mail, getmail)
                        getmail = ""
                    except:
                        make_output([], "Errored while fetching the latest email")
                        time.sleep(60)
        except:
            make_output([], "Unable to connect to the mail server")
            # Try to connect in a minute again
            time.sleep(60)
        
                
if __name__ == "__main__":
    # Wait a little bit before starting to let the network connect if we detect that the pc booted recently
    if (time.time() - psutil.boot_time())/60 < 20:
        time.sleep(30)
    main()
