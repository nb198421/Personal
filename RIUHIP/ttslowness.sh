#!/bin/sh
foldername=$(date +%m%d%y%H%M)
mkdir /log/archive/$foldername
cd /log
zip /log/archive/$foldername/log_$foldername *.*


rm -rf /log/*.*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/EngineServer01/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/EngineServer02/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/ffdc/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/nodeagent/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/SIT-APTC/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/SIT-HIX-APTC/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/SIT-Perf-HIX/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/SIT-Perf-SSP/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/SIT-SSP-APTC/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/wstemp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/wstemp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/temp/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/logs/dmgr/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/logs/ffdc/*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/logs/*.*
rm -rf /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/*.*

#/opt/HIXEAR/TimeTravel/TimeTravel.jar /home/wasadmin/SIT-Perf-HIX_Properties/TimeTravel/TimeTravel.jar

cd /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/wsadmin.sh -f /home/wasadmin/TT/server1/on-modev1.py -lang jython -user wasadmin -password wasadmin;

AdminTask.setJVMProperties('[-nodeName ENT-IR-UHAPPR1Node01 -serverName server1 -bootClasspath [/opt/HIXEAR/TimeTravel.jar ] -verboseModeClass true -verboseModeGarbageCollection false -verboseModeJNI false -initialHeapSize 1024 -maximumHeapSize 3072 -runHProf false -hprofArguments -debugMode true -debugArgs "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=7777" -executableJarFileName -genericJvmArguments -disableJIT false]')
AdminConfig.save()

cd /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/stopServer.sh SIT-HIX-APTC -user wasadmin -password wasadmin

sleep 180

cd /opt/IBM/WebSphere/AppServer/profiles/AppSrv01/bin/startServer.sh SIT-HIX-APTC
