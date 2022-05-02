#!/bin/sh
DATE=`date +%Y%m%d_%H%M`
OutputDir='/home/pthadur/CheckSumReports/BuildServerStaging/DiffReports/HOTFIX_PROD'
rm $OutputDir/IES/*
rm $OutputDir/HIX/*
rm $OutputDir/SSP/*
rm $OutputDir/CCAP/*
rm $OutputDir/OPA/*
rm $OutputDir/DataMart/*
rm $OutputDir/PUB/*
diff -rqyl /opt/HSRI/HOTFIX/IES /opt/HSRI/HybridPILOT/IES > $OutputDir/IES/IES_DiffReports_$DATE.log
diff -rqyl /opt/HSRI/HOTFIX/HIX /opt/HSRI/HybridPILOT/HIX > $OutputDir/HIX/HIX_DiffReports_$DATE.log
diff -rqyl /opt/HSRI/HOTFIX/SSP /opt/HSRI/HybridPILOT/SSP > $OutputDir/SSP/SSP_DiffReports_$DATE.log
diff -rqyl /opt/HSRI/HOTFIX/CCAPEARR /opt/HSRI/HybridPILOT/CCAPEARR > $OutputDir/CCAP/CCAP_DiffReports_$DATE.log
diff -rqyl /opt/HSRI/HOTFIX/OPA /opt/HSRI/HybridPILOT/OPA > $OutputDir/OPA/OPA_DiffReports_$DATE.log
diff -rqyl /opt/HSRI/HOTFIX/DataMart /opt/HSRI/HybridPILOT/DataMart > $OutputDir/DataMart/DataMart_DiffReports_$DATE.log
diff -rqyl /opt/HSRI/Branch/PUBS /opt/HSRI/HybridPILOT/PUBS > $OutputDir/PUB/PUB_DiffReports_$DATE.log
