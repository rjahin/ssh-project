#!/bin/bash
servers=()
while true; do
    echo " "
    echo "=====server manager====="
    echo "1. Add a server"
    echo "2. List servers"
    echo "3. Check server health"
    echo "4. ssh inside a server"
    echo "5. Exit"
    echo " "

    read -p "Enter your choice: " choice

    case $choice in
        1)
            read -p "Enter server ip: " ip
            servers+=("$ip")
            echo "Server added successfully"
            ;;
        2) 
            echo " "
            # Checks if the list is empty or not
            if [ ${#servers[@]} -eq 0 ]; then 
                echo "No server saved yet!"
            else
                echo "Here are the saved servers: "
                for ip in "${servers[@]}"; do
                    echo "$ip"
                    echo " "
                done
            fi
            ;;
        3)  
            echo " "
            if [ ${#servers[@]} -eq 0 ]; then 
                echo "No server saved yet!"
            else
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
            fi
            echo " "
            ;;
        4)  
            echo " "
            if [ ${#servers[@]} -eq 0 ]; then 
                echo "No server saved yet!"
            else
                # ${!servers[@]} -> list of the index numbers (positions) of the array: 0, 1, 2, ...
                for i in "${!servers[@]}"; do 
                    # $((i+1))       -> add 1 so the menu starts at 1 instead of 0
                    # ${servers[$i]} -> the IP at position i
                    echo "$((i+1)). ${servers[$i]}"
                done

                read -p "Pick a server number: " num
                read -p "Enter username: " username

                # Arrays start at 0, so subtract 1 from the user's choice
                index=$((num-1))

                # -n                   -> true if the string is NOT empty
                # ${servers[$index]}   -> the server IP at position $index (empty if that position doesn't exist)
                # Result: only continue if the user picked a valid server number

                if [ -n "${servers[$index]}" ]; then
                    # ssh user@ip -> log into the chosen server as that user
                    # When you exit the ssh session, you return to the menu
                    ssh "$username@${servers[$index]}"
                else
                    echo "Invalid server numeber"
                fi
            fi
            echo " "
            ;;
        5) 
            echo " "
            echo "Goodbye!!"
            echo " "
            exit;;
        *)
            echo " "
            echo "Invalid Option!!!"
            echo "Please Try Again!!!"
            echo " "
            
    esac

done

