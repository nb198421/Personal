#!/bin/sh
IESRevisionFrom=$1
IESRevisionTo=$2
SharedLibRevisionFrom=$3
SharedLibRevisionTo=$4
InternalLibRevisionFrom=$5
InternalLibRevisionTo=$6
SSPRevisionFrom=$7
SSPRevisionTo=$8
HIXRevisionFrom=$9
HIXRevisionTo=${10}
DSRevisionFrom=${11}
DSRevisionTo=${12}
OPARevisionFrom=${13}
OPARevisionTo=${14}
HSRICOMMONSFrom=${15}
HSRICOMMONSTo=${16}
MuleRevisionFrom=${17}
MuleRevisionTo=${18}
#RBT URL'S
#RBT
IES_RBT_URL=https://10.64.65.20:18080/svn/HSRI-IES/tags/CriticalProjects-IES
SharedLib_RBT_URL=https://10.64.65.20:18080/svn/HSRI-IES/tags/CriticalProjects-HSRIIESSharedLib
InternalLib_RBT_URL=https://10.64.65.20:18080/svn/HSRI-IES/tags/CriticalProjects-HSRIIESInternalLib
SSP_RBT_URL=https://10.64.65.20:18080/svn/HSRI-BASELINE/HSRI-SSP/tags/CriticalProjects-SSP
HIX_RBT_URL=https://10.64.65.20:18080/svn/HSRI-HIX/tags/CriticalProjects-HIX
DS_RBT_URL=https://10.64.65.20:18080/svn/HSRI-IES/tags/CriticalProjects-DS
OPA_RBT_URL=https://10.64.65.20:18080/svn/HSRI-BASELINE/tags/CriticalProjects-OPA
HSRICOMMONS_RBT_URL=https://10.64.65.20:18080/svn/HSRI-COMMON/tags/CriticalProjects-MULE
MULE_RBT_URL=https://10.64.65.20:18080/svn/HSRI-IES/tags/CriticalProjects-MULE
#WB
##IES_WB_URL=https://10.64.65.20:18080/svn/HSRI-IES/branches/GOLD-BUILD-For-09132016Live-IES7.0.0
##SharedLib_WB_URL=https://10.64.65.20:18080/svn/HSRI-IES/branches/GOLD-BUILD-For-09132016Live-HSRIIESSharedLib7.0.0
##InternalLib_WB_URL=https://10.64.65.20:18080/svn/HSRI-IES/branches/GOLD-BUILD-For-09132016Live-HSRIIESInternalLib7.0.0
##SSP_WB_URL=https://10.64.65.20:18080/svn/HSRI-BASELINE/HSRI-SSP/branches/GOLD-BUILD-For-09132016Live-SSP7.0.0
##HIX_WB_URL=https://10.64.65.20:18080/svn/HSRI-HIX/branches/GOLD-BUILD-For-09132016Live-HIX7.0.0
##DS_WB_URL=https://10.64.65.20:18080/svn/HSRI-IES/branches/GOLD-BUILD-For-09132016Live-DS7.0.0
##OPA_WB_URL=https://10.64.65.20:18080/svn/HSRI-BASELINE/branches/GOLD-BUILD-For-09132016Live-OPA7.0.0
##HSRICOMMONS_WB_URL=https://10.64.65.20:18080/svn/HSRI-COMMON/branches/GOLD-BUILD-MULE-BRANCH-For-09132016Live
##MULE_WB_URL=https://10.64.65.20:18080/svn/HSRI-IES/branches/GOLD-BUILD-MULE-BRANCH-For-09132016Live
echo "#########################################################################################"
echo "echoing revision numbers"
echo "ies from: $IESRevisionFrom"
echo "ies to: $IESRevisionTo"
echo "SL from: $SharedLibRevisionFrom"
echo "SL to: $SharedLibRevisionTo"
echo "IL from: $InternalLibRevisionFrom"
echo "IL to: $InternalLibRevisionTo"
echo "ssp from: $SSPRevisionFrom"
echo "ssp to: $SSPRevisionTo"
echo "hix from: $HIXRevisionFrom"
echo "hix to: $HIXRevisionTo"
echo "DS from: $DSRevisionFrom"
echo "DS to: $DSRevisionTo"
echo "opa from: $OPARevisionFrom"
echo "opa to: $OPARevisionTo"
echo "common mule from: $HSRICOMMONSFrom"
echo "common to: $HSRICOMMONSTo"
echo "mule from: $MuleRevisionFrom"
echo "mule to: $MuleRevisionTo"
echo "#########################################################################################"
echo "started extracting RBT SVN log"
svn log -v -r ${IESRevisionFrom}:${IESRevisionTo} ${IES_RBT_URL} |  tr -d '\n' | sed -r 's/-{2,}/\n/g' | sed -r 's/ \([^\)]+\)//g' | sed -r 's/^r//' | sed -r "s/[0-9]+ lines?//g" | sort -g | sed 's/ | /;/g' > /opt/HSRI/SVN_LOG/logs/RBT/IES-RBT-log.csv
svn log -v -r ${SharedLibRevisionFrom}:${SharedLibRevisionTo} ${SharedLib_RBT_URL}|  tr -d '\n' | sed -r 's/-{2,}/\n/g' | sed -r 's/ \([^\)]+\)//g' | sed -r 's/^r//' | sed -r "s/[0-9]+ lines?//g" | sort -g | sed 's/ | /;/g' > /opt/HSRI/SVN_LOG/logs/RBT/SharedLib-RBT-log.csv
svn log -v -r ${InternalLibRevisionFrom}:${InternalLibRevisionTo} ${InternalLib_RBT_URL} |  tr -d '\n' | sed -r 's/-{2,}/\n/g' | sed -r 's/ \([^\)]+\)//g' | sed -r 's/^r//' | sed -r "s/[0-9]+ lines?//g" | sort -g | sed 's/ | /;/g' > /opt/HSRI/SVN_LOG/logs/RBT/InternalLib-RBT-log.csv
svn log -v -r ${SSPRevisionFrom}:${SSPRevisionTo} ${SSP_RBT_URL} |  tr -d '\n' | sed -r 's/-{2,}/\n/g' | sed -r 's/ \([^\)]+\)//g' | sed -r 's/^r//' | sed -r "s/[0-9]+ lines?//g" | sort -g | sed 's/ | /;/g' > /opt/HSRI/SVN_LOG/logs/RBT/SSP-RBT-log.csv
svn log -v -r ${HIXRevisionFrom}:${HIXRevisionTo} ${HIX_RBT_URL} |  tr -d '\n' | sed -r 's/-{2,}/\n/g' | sed -r 's/ \([^\)]+\)//g' | sed -r 's/^r//' | sed -r "s/[0-9]+ lines?//g" | sort -g | sed 's/ | /;/g' > /opt/HSRI/SVN_LOG/logs/RBT/HIX-RBT-log.csv
svn log -v -r ${DSRevisionFrom}:${DSRevisionTo} ${DS_RBT_URL} |  tr -d '\n' | sed -r 's/-{2,}/\n/g' | sed -r 's/ \([^\)]+\)//g' | sed -r 's/^r//' | sed -r "s/[0-9]+ lines?//g" | sort -g | sed 's/ | /;/g' > /opt/HSRI/SVN_LOG/logs/RBT/DS-RBT-log.csv
svn log -v -r ${OPARevisionFrom}:${OPARevisionTo} ${OPA_RBT_URL} |  tr -d '\n' | sed -r 's/-{2,}/\n/g' | sed -r 's/ \([^\)]+\)//g' | sed -r 's/^r//' | sed -r "s/[0-9]+ lines?//g" | sort -g | sed 's/ | /;/g' > /opt/HSRI/SVN_LOG/logs/RBT/OPA-RBT-log.csv
svn log -v -r ${HSRICOMMONSFrom}:${HSRICOMMONSTo} ${HSRICOMMONS_RBT_URL} |  tr -d '\n' | sed -r 's/-{2,}/\n/g' | sed -r 's/ \([^\)]+\)//g' | sed -r 's/^r//' | sed -r "s/[0-9]+ lines?//g" | sort -g | sed 's/ | /;/g' > /opt/HSRI/SVN_LOG/logs/RBT/COMMONMULE-RBT-log.csv
svn log -v -r ${MuleRevisionFrom}:${MuleRevisionTo} ${MULE_RBT_URL} |  tr -d '\n' | sed -r 's/-{2,}/\n/g' | sed -r 's/ \([^\)]+\)//g' | sed -r 's/^r//' | sed -r "s/[0-9]+ lines?//g" | sort -g | sed 's/ | /;/g' > /opt/HSRI/SVN_LOG/logs/RBT/MULE-RBT-log.csv
echo "started extracting RBT SVN log"
echo "#########################################################################################"
echo "printing last committed versions"
echo "************************************************************************************"
echo "Last 1 commits of "${IES_RBT_URL}":"
svn log ${IES_RBT_URL} -l 1
echo "************************************************************************************"
echo "Last 1 commits of "${SharedLib_RBT_URL}":"
svn log ${SharedLib_RBT_URL} -l 1
echo "************************************************************************************"
echo "Last 1 commits of "${InternalLib_RBT_URL}":"
svn log ${InternalLib_RBT_URL} -l 1
echo "************************************************************************************"
echo "Last 1 commits of "${SSP_RBT_URL}":"
svn log ${SSP_RBT_URL} -l 1
echo "************************************************************************************"
echo "Last 1 commits of "${HIX_RBT_URL}":"
svn log ${HIX_RBT_URL} -l 1
echo "************************************************************************************"
echo "Last 1 commits of "${OPA_RBT_URL}":"
svn log ${OPA_RBT_URL} -l 1
echo "************************************************************************************"
echo "Last 1 commits of "${HSRICOMMONS_RBT_URL}":"
svn log ${HSRICOMMONS_RBT_URL} -l 1
echo "************************************************************************************"
echo "Last 1 commits of "${MULE_RBT_URL}":"
svn log ${MULE_RBT_URL} -l 1
echo "************************************************************************************"
echo "Last 1 commits of "${DS_RBT_URL}":"
svn log ${DS_RBT_URL} -l 1
echo "#########################################################################################"
