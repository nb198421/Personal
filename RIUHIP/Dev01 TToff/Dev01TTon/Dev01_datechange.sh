#!/bin/bash

# Read the input about the new date to be updated
echo -n "Please enter the month and press [ENTER] {format: MM}: "
read MONTH

echo -n "Please enter the date and press [ENTER] {format: DD}: "
read DATE

echo -n "Please enter the year and press [ENTER] {format: YYYY}: "
read YEAR


echo ""
echo "Executing date change in MNO Dev server1"
echo "Setting date to " $MONTH/$DATE/$YEAR

if [ -d /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/installedApps/ENT-DV-UHAPP01Cell01/HIXMainITR3_DEV1.ear ]; then
	cd /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/installedApps/ENT-DV-UHAPP01Cell01/HIXMainITR3_DEV1.ear/HIXWeb.war/WEB-INF/classes
	rm -f timetravel.properties

	echo "timetravel_enabled=Y" > timetravel.properties
	echo "#month day year hour min ss" >> timetravel.properties
	echo "date=$MONTH $DATE $YEAR 12 12 12" >> timetravel.properties

	echo ""
	echo -n "Press Enter to start the date change"
	read inp

	echo ""
	echo "Starting the date change at `date`"
	#cd /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin
	#./stopServer.sh server1 -username wasadmin -password wasadmin
	echo "Sleeping for 15 seconds"
	sleep 15
	#./startServer.sh server1
else
	echo "/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/installedApps/ENT-DV-UHAPP01Cell01/HIXMainITR3_DEV1.ear does not exist"
	exit 1
fi

echo ""
echo "Completed the date change at `date`"
echo ""
exit 0

