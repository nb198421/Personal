# This script will turn ON Time Travel and will bounce the application server

#!/bin/bash

HostName='ENT-DV-UHAPP01'
UserName='wasadmin'
Passwd='wasadmin'
JVM='server1'
Cell='ENT-DV-UHAPP01Cell01'
EAR='HIXMainITR3_DEV1.ear'
wasAdmin='/opt/IBM/WebSphere/AppServer/bin/'
AppHome='/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin'
script='/opt/HIXEAR/Dev01TT/TTOn/on-Dev01.py'
InstalledApps='/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/installedApps'
Path='HIXWeb.war/WEB-INF/classes'
DateChange='/opt/HIXEAR/Dev01TT/TTOn/Dev01_datechange.sh'

echo "Clearing temp file and logs"

rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/wstemp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/nodeagent/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/server1/*

echo "Cleared the temp and logs of server1(Dev01)"

echo "Script initiated to set Time Travel from application server"

$AppHome/wsadmin.sh -f $script -lang jython -user $UserName -password $Passwd;

echo "Added TimeTravel.jar in the boot class path"

$DateChange

echo "Date change and server bounce is completed"