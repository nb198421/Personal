#!/bin/sh

VAR=$(curl -u spgunupudi:Spring2015 http://jira.ribridges.ri.gov/jira/rest/api/latest/issue/UHIPOPS-26159?fields=status)
echo VAR value is :: ${VAR}
#Status=`echo ${VAR} |grep "\"name\":\"Resolved\""
#echo STATUS IS  :: ${Status}
