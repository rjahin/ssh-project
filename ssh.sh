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
    esac

done