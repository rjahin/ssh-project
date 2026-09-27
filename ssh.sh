#!/bin/bash
#here 2>&1 means send stderr(2) to wheereever stdout(1) is going
servers=()
while true; do
    echo " "
    echo "=====server manaher====="
    echo "1. Add a server"
    echo "2. List servers"
    echo "3. Check server health"
    echo "4. shh inside a server"
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
            for ip in "${servers[@]}"; do
                if ping -c 1 -W 2 $ip > /dev/null 2>&1; then #we will not see the ping output
                    echo "$ip is UP!"
                else 
                    echo "$ip is DOWN!"
                fi
            done
            ;;
    esac

done

