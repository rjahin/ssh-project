# Server Manager (Bash)
 
A simple interactive Bash script for managing a list of servers from the terminal. You can add server IPs, list them, check whether they're reachable, and SSH into one, all from a menu.
 
## Features
 
- **Add a server**: save a server IP to the list
- **List servers**: show all saved servers
- **Check server health**: ping each server and report whether it's UP or DOWN
- **SSH into a server**: pick a server from a numbered list and log in with a username
- **Exit**: close the program
## Requirements
 
- Linux or macOS with Bash
- `ping` (for health checks)
- `ssh` (for connecting to servers)
- SSH access (username and password or key) to the servers you want to log into
## How to Run
 
1. Make the script executable:
```bash
   chmod +x ssh.sh
```
 
2. Run it:
```bash
   ./ssh.sh
```
 
3. Choose an option from the menu by typing its number and pressing Enter.
## Example
 
```
=====server manager=====
1. Add a server
2. List servers
3. Check server health
4. ssh inside a server
5. Exit
 
Enter your choice: 1
Enter server ip: 192.168.1.10
Server added successfully
 
Enter your choice: 3
192.168.1.10 is UP!
 
Enter your choice: 4
1. 192.168.1.10
Pick a server number: 1
Enter username: ubuntu
```
 
## How It Works
 
- Servers are stored in a Bash array (`servers=()`), and new IPs are added with `servers+=("$ip")`.
- The menu runs inside a `while true` loop and uses a `case` statement to handle each choice.
- The health check runs `ping -c 1 -W 2` on each server: one packet with a 2-second timeout. The output is hidden, and the exit code decides whether the server is UP or DOWN.
- The SSH option lists servers using their array indexes (`${!servers[@]}`), converts the user's choice back to a 0-based index, and runs `ssh user@ip`.
## Limitations
 
- The server list is stored in memory only, so it's cleared every time the script exits.
- Some servers or firewalls block ping (ICMP), so a server may show as DOWN even when it's running.
- IP addresses aren't validated, so any text can be added as a server.
## Possible Improvements
 
- Save servers to a file (e.g. `servers.txt`) so the list persists between runs
- Validate IP addresses before adding them
- Add an option to remove a server
- Check a specific port (like 22 for SSH) instead of only using ping
## What I Learned
 
- Bash arrays: adding items, looping over values (`${servers[@]}`), counting items (`${#servers[@]}`), and working with indexes (`${!servers[@]}`)
- Building a menu with `while` loops and `case` statements
- Reading user input with `read -p`
- Redirecting output with `> /dev/null 2>&1` and using exit codes in `if` statements
- Connecting to remote servers with `ssh`
