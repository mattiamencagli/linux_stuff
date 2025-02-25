To use `screen` in a Linux server and then exit while keeping the session running, follow these steps:

### 1. Connect to the Server
First, SSH into your Linux server:
```bash
ssh user@your-server-ip
```

### 2. Start a `screen` Session
Run:
```bash
screen -S mysession
```
This starts a new screen session named `mysession`.

### 3. Run Your Command
Execute the command or process you want to keep running. For example:
```bash
python3 my_script.py
```

### 4. Detach the `screen` Session
Press:
```
Ctrl + A, then D
```
This detaches the session and keeps it running in the background.

### 5. Exit the Server
Now, safely log out of the server:
```bash
exit
```

---

### Reconnect to the `screen` Session Later
If you log back into the server and want to reattach to the screen session, run:
```bash
screen -r mysession
```

If you have multiple screen sessions, list them with:
```bash
screen -ls
```
Then reattach using:
```bash
screen -r [session_id]
```
