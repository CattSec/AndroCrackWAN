# AndroCrackWAN
I created a simple automated android meterpreter tool to work over anywhere in the world without port fowarding
To start you will need to install ngrok at https://ngrok.com/download
You will also need metasploit installed on a Linux OS
##You may have to hit Ctrl+C a few times in the meterpreter until it reads: 'msf exploit(handler) >' 
Then type 'sessions 1'


########INSTALL############
1) Navigate to where you installed AndroCrack
2) Type chmod +x AndroCrack.sh
3) Run by typing ./AndroCrack.sh
###########################

If you are running on a Nethunter Device:
1)Comment out lines 2-19
2)In Kali Terminal type: apt-get install postgresql
3)Type ./ngrok tcp 4444
4)Now run the script in a new Kali Terminal
