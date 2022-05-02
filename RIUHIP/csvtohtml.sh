#!/bin/sh
#./csvtohtml.sh -d " " -f /opt/HSRI/scripts/HotFixMvsHybridPILOT/logs/HotFixMvsHybridPILOT.csv  > /opt/HSRI/scripts/HotFixMvsHybridPILOT/logs/HotFixMvsHybridPILOT.html
NOARG=64
#usage function
f_Usage () {
echo "Usage: $(basename $0) -d <delimiter> -f <delimited-file>"
}
#command line args
while getopts d:f: OPTION
do
    case $OPTION in
        d)  DELIMITER=$OPTARG ;;
        f)  INFILE=$OPTARG ;;
    esac
done

#Less than 2 command line argument, throw Usage
[ "$#" -lt 2 ] && f_Usage && exit $NOARG

DEFAULTDELIMITER=","
#If no delimiter is supplied, default delimiter is comma i.e. ,
SEPARATOR=${DELIMITER:-$DEFAULTDELIMITER}
if [ -f "${INFILE}" ]
then
awk 'BEGIN{
FS=","
#print "<HTML>""<TABLE border=1 width='100%' align='centre' ><tr bgcolor='#000080'><TH><FONT COLOR='#FFFFFF'>RIUHIP TECH TEAM</TH></FONT>"
#print "</TABLE>"
print "<HTML>""<TABLE border=1 width='100%' align='centre' bgcolor='#C6C6C6' BORDERCOLOR='#CCFF00' ><tr bgcolor='#5F9EA0'><TH>JAR TIME STAMPS</TH>"
print "</TABLE>"
print "<HTML><TABLE border=2 width='100%' align='centre' BORDERCOLOR='#330000' ><trbgcolor='#FFFFCC'>"
print "<TH>Environemnt Name</TH><TH>EAR Timestamp</TH><TH>CO.jar</TH><TH>Common.jar</TH><TH>DA.jar</TH><TH>FW.jar</TH>"
}
{
    printf "<TR>"
            for(i=1;i<=6;i++)
			{
             printf "<TD>%s</TD>", $i
			}
            print "</TR>"
    }

END{
    print "</TABLE></BODY></HTML>"
   }' y="$yest" n="$now" ${INFILE}
else
echo "file not found"
fi