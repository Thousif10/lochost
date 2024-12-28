#!/bin/bash

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
      else [[ $3 = 0 ]];
        ssh -R 80:localhost:$2 localhost.run
    fi
echo -e "__________________________________________________                             ";
fi

if [[ "$1" = 'tcp' ]]; then

    if [[ "$3" -gt "1" ]]; then
        ssh -R $3:localhost:$2 localhost.run
      else [[ $3 = 0 ]];
        ssh -R 0:localhost:$2 localhost.run
    fi
echo -e "__________________________________________________                             ";
fi

