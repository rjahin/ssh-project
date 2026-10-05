#!/bin/bash
servers=()
while true; do
    echo " "
    echo "=====server manaher====="
    echo "1. Add a server"
    echo "2. List servers"
    echo "3. Check server health"
    echo "4. ssh inside a server"
    echo "5. exit"
    echo " "

    read -p "enter your choice: " choice

    case $choice in
        1)
            read -p "enter server ip: " ip
            servers+=("$ip")
            echo "Server added successfully"
            ;;
        2) 
            echo "here are the saved servers: "
            for ip in "${servers[@]}"; do
                echo "$ip"
                echo " "
            done
            ;;
        3)  
            # ping        -> send ICMP echo requests to check if a host is reachable
            # -c 1        -> send only 1 packet, then stop
            # -W 2        -> wait up to 2 seconds for a reply before giving up
            # $ip         -> the target IP address stored in the variable "ip"
            # > /dev/null -> discard normal output (stdout)
            # 2>&1        -> send errors (stderr) to the same place as stdout, so they're discarded too
            # Result: no output is printed; exit code 0 = host is up, non-zero = host is down/unreachable
            for ip in "${servers[@]}"; do
                if ping -c 1 -W 2 $ip > /dev/null 2>&1; then
                    echo "$ip is UP!"
                else 
                    echo "$ip is DOWN!"
                fi
            done
            ;;
    esac

done

