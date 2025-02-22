#!/bin/bash

# GitHub repository details
REPO_OWNER="Thousif10"
REPO_NAME="lochost"
SCRIPT_NAME="lochost.sh"

# Function to check for updates
check_for_update() {
    echo -e "\n[+] Checking for updates..."
    # Fetch the latest version of the script from GitHub
    LATEST_SCRIPT_URL="https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/main/$SCRIPT_NAME"
    TEMP_SCRIPT="/tmp/$SCRIPT_NAME"

    # Download the latest version to a temporary location
    curl -s -o "$TEMP_SCRIPT" "$LATEST_SCRIPT_URL"

    if [ $? -eq 0 ]; then
        # Compare the downloaded script with the current one
        if ! cmp -s "$TEMP_SCRIPT" "$0"; then
            echo "[+] A new version is available. Updating the script..."
            # Replace the current script with the new version
            mv "$TEMP_SCRIPT" "$0"
            chmod +x "$0"
            echo "[+] Update complete. Please re-run the script."
            exit 0
        else
            echo "[+] You already have the latest version."
            rm "$TEMP_SCRIPT"
        fi
    else
        echo "[-] Failed to check for updates. Continuing with the current version."
    fi
}

# Check for updates
check_for_update

# Displaying the header and instructions
echo -e "__________________________________________________                             ";
echo -e '.          __     __          __    __   _____  ';
echo -e '.   |     /  \   /    |   |  /  \  /  `    |        ';
echo -e '.   |           |     |---|        ---     |      ';
echo -e '.   |___  \__/   \__  |   |  \__/  .__/    |                                                        ';
echo -e "__________________________________________________                             ";
echo -e ".   $0 // localhost.run easy commander v1                                      ";
echo -e "-------------------------------------------------                              ";
echo -e ".------------| github.com/Thousif10 |------------                              ";
#                              v1.0 
echo -e "__________________________________________________                             ";
echo -e ".                                                                              ";
echo -e ".     *ssh installed required*                                                 ";
echo -e "parameter : $0 [http/tcp] [local port] [option]                                 ";
echo -e ".                                                                              ";
echo -e "     parameter [option] : 0 = request random port                              ";
echo -e "     parameter [option] : change = change http subdomain forwarded             ";
echo -e "     parameter [option] : 4869 = custom port number to forwarding (using tcp)  ";
echo -e ".                                                                              ";
echo -e "$ $0 http  80 0             //localhost:80 forward to public https             ";
echo -e ".                                                                              ";
echo -e ".                                                                              ";
echo -e "$ $0 tcp 4869 0             //random tcp port forwarding                       ";
echo -e "$ $0 tcp 4869 1945          //custom tcp port forwarding                       ";
echo -e ".                                                                              ";
echo -e "__________________________________________________                             ";
echo "running : $0 $1 $2 $3";
echo -e "__________________________________________________                             ";

if [[ "$1" = 'http' ]]; then

    if [[ $3 = 'change' ]]; then
        ssh -R 80:localhost:$2 `echo -n $(date) | md5sum | cut -c1-8`@localhost.run
    elif [[ "$3" -gt "1" ]]; then
        ssh -R $3:localhost:$2 localhost.run
    else
        ssh -R 80:localhost:$2 localhost.run
    fi
    echo -e "__________________________________________________                             ";
fi

if [[ "$1" = 'tcp' ]]; then

    if [[ "$3" -gt "1" ]]; then
        ssh -R $3:localhost:$2 localhost.run
    else
        ssh -R 0:localhost:$2 localhost.run
    fi
    echo -e "__________________________________________________                             ";
fi

