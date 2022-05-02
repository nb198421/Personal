#! /bin/bash
var=$1
CurrentDate=$(date +%d-%b-%C%y)
cd /opt/HSRI/SVN/checkout/
svn cleanup buildversions/
svn cleanup /opt/HSRI/SVN/checkout/buildversions/ReleaseBranch/
cd /opt/HSRI/SVN/checkout/buildversions/ReleaseBranch
svn update
num=$(head -2 build.properties | tail -c 4)
echo $num
echo $CurrentDate
tmp=`expr $num + 1`
echo "tmp:"$tmp""
printf -v vnum "%03d" $tmp
echo $vnum
rm build.properties
echo "#BUILD DETAILS" > build.properties
echo "BUILDNUMBER = "$var$vnum"" >> build.properties
echo "BUILDTIME = "$CurrentDate"" >> build.properties
echo "BUILDSTREAM = Release Branch" >> build.properties
svn update
svn commit  -m "Updated Release Branch build version"
chmod -R 777 /opt/HSRI/SVN/checkout/buildversions/ReleaseBranch/*.properties
echo "##########################################################"
echo "######## Printing the Current Build Version###############"
cat /opt/HSRI/SVN/checkout/buildversions/ReleaseBranch/build.properties
echo "######################END#################################"
echo "##########################################################"