#!/bin/sh
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
#Varibales Declarations
CurrentDate=$(date '+%d-%b-%Y')
REPONAME=Crucible-Fisheye-Test
LOG_PATH=/opt/HSRI/SVN/AUTOCODECOMMIT/logs/${REPONAME}
CHECKOUT_PATH=/opt/HSRI/SVN/AUTOCODECOMMIT/repositories/${REPONAME}
CONFFILE_PATH=/opt/HSRI/SVN/AUTOCODECOMMIT/repositories/conf/${REPONAME}
SVN_REPO_URL=https://10.64.65.20:18080/svn/${REPONAME}

http://10.118.8.43:18080/svn/NextGen/Delivery/CaseManagement/branches/DES_Branches
USERNAME=npanguluri
PASSWORD=2WrWitpi
SVNLOOK=/opt/csvn/bin/svnlook
REPOS="$1"
REV="$2"
mkdir -p ${LOG_PATH}/${CurrentDate}/temp/${REV}
cd ${LOG_PATH}/${CurrentDate}
AUTHOR="$($SVNLOOK author $REPOS -r $REV)"
MESSAGE=$($SVNLOOK log $REPOS -r $REV)
echo "Commit_Message:"$MESSAGE > ${LOG_PATH}/${CurrentDate}/temp/${REV}/CommitMessage.log
SVNLOG=`$SVNLOOK log -r "$REV" "$REPOS"`
SVNBRANCH=`$SVNLOOK dirs-changed -r "$REV" "$REPOS"`
SVNCHANGE=`$SVNLOOK changed -r "$REV" "$REPOS"`
echo -e "$SVNCHANGE \n" > ${LOG_PATH}/${CurrentDate}/temp/${REV}/SVNCHANGE.log
#SVNDIFF=`$SVNLOOK diff -r "$REV" "$REPOS"`
Exclude_List=`egrep -w 'jar|pub|zip' ${LOG_PATH}/${CurrentDate}/temp/${REV}/SVNCHANGE.log`
commit=`cat ${LOG_PATH}/${CurrentDate}/temp/${REV}/SVNCHANGE.log | awk '{print $2}' | awk -F / '{print $1"/"$2"/"}' | head -n 1`
COMMIT_BRANCH=`cat ${LOG_PATH}/${CurrentDate}/temp/${REV}/SVNCHANGE.log | awk '{print $2}' | awk -F / '{print $1$2}' | head -n 1`
MSG=`echo $MESSAGE`
CommitMessage=`grep -w "SVN TOOL AUTO COMMIT" ${LOG_PATH}/${CurrentDate}/temp/${REV}/CommitMessage.log`
ABSOLUTE_PATH=`grep "$commit" ${LOG_PATH}/${CurrentDate}/temp/${REV}/SVNCHANGE.log | awk -F "$commit" {'print $2'} | rev | cut -d"/" -f2- | rev | uniq`
CHANGESETS=`grep "$commit" ${LOG_PATH}/${CurrentDate}/temp/${REV}/SVNCHANGE.log | awk -F "$commit" {'print $2'}`
#Function
DRY_RUN()
{
	echo "############ Updating the code base at $1 level ############" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	cd ${CHECKOUT_PATH}/$1
	echo "cd ${CHECKOUT_PATH}/$1" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	svn --username ${USERNAME} --password ${PASSWORD} update | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "############ Started DRY RUN between $j$p and $1 ######################" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	#echo "Dry run log while merging $j$p into $i$p" >> ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log
	echo "svn --username ${USERNAME} --password ${PASSWORD} merge -c $REV $2 . --dry-run" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	svn --username ${USERNAME} --password ${PASSWORD} merge -c $REV $2 . --dry-run | tee -a ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	#mkdir -p ${LOG_PATH}/${CurrentDate}/temp/
	#grep conflict ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log >> ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log
}
#Function
MERGE()
{
	echo "############ Merging changes between $j$p into $1 ######################" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	cd ${CHECKOUT_PATH}/$1
	echo "cd ${CHECKOUT_PATH}/$1" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	svn --username ${USERNAME} --password ${PASSWORD} merge -c $REV $2 . | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "svn --username ${USERNAME} --password ${PASSWORD} merge -c $REV $2 ." | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	#echo "Code merge completed on ${i} from ${j}" >> ${LOG_PATH}/${CurrentDate}/temp/${REV}/${AUTHOR}_Message.log
}

if [ -n "$Exclude_List" ]
then
	echo "This commit contains files listed in exclusion list. Post commit is disabled" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	exit 0
fi

if [ "$CommitMessage" != "" ]
then
	echo "This commit is detected as a SVN TOOL AUTO COMMIT. Hence the Post commit hook is disabled." | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	exit 0
else
	echo "##########################################################################################################################" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "##################### POST COMMIT initiated as new commit was detected $REV on $COMMIT_BRANCH ######################################" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "##########################################################################################################################" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "SVNLOOK:"$SVNLOOK | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "SVNLOG:"$SVNLOG | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "SVNBRANCH:"$SVNBRANCH | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "SVNCHANGE:$SVNCHANGE\n" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "REPO_NAME:"$REPOS | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "REV:"$REV | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "AUTHOR:"$AUTHOR | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "Commit_Message:"$MESSAGE | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "Exclusion List: "$Exclude_List | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "Commit detected on: "$commit | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "CommitMessage=${CommitMessage}" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	echo "ABSOLUTE_PATH=${ABSOLUTE_PATH}" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	#echo "SVNDIFF:"$SVNDIFF | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
	VALID_CHECKINS=`grep "^ENABLED_BRANCHES=" ${CONFFILE_PATH}/.post_commit.conf | cut -d"=" -f2`
	for j in ${VALID_CHECKINS}
	do
		if [[ ${commit} == ${j} ]]
		then
			COMMIT_VALUE=`cat ${CONFFILE_PATH}/.post_commit.conf |  grep -w "^${commit}" | awk -F":" {'print $2'}`
			for i in ${COMMIT_VALUE}
			do
				for p in ${ABSOLUTE_PATH}
				do
					echo $p >> ${LOG_PATH}/${CurrentDate}/temp/${REV}/changedfilelist.log
					echo "The value of p is ${p}" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					echo "The value of i is ${i}" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					DRY_RUN "${i}${p}" "${SVN_REPO_URL}/${j}${p}"
				done
				Conflict=`grep conflict ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log`
				#echo "conflict :: ${Conflict}" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
				DRYRUN_STATUS=`cat ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log`
				#echo "DRYRUN_STATUS :: ${DRYRUN_STATUS}" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
				if [[ ${DRYRUN_STATUS} == "" ]]
				then
					#echo "Inside dry run status check" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					echo "Changes done on Source Branch(${j}) as part of r${REV} are already present on the Target Branch(${i}). Hence no Merge and Commit required on Target Branch." | tee -a ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					echo "Skipping Merge and Commit to Target Branch(${i})." >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log
					cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/changedfilelist.log
				else
				if [[  "$Conflict" != "" ]]
				then
					#echo "Inside conflict check" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					echo " Detected conflicts while merging ${j} to ${i}" | tee -a ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log
					cat ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log >> ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log
					cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log
					cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/changedfilelist.log
					if [[  ]]
				else
					for CHANGESET in ${CHANGESETS}
					do
						echo "################################ No conflicts found. Code merging is in progress from $j to $i. #######################" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
						FILEPATH=${CHANGESET%/*}
						MERGE "${i}${FILEPATH}" "${SVN_REPO_URL}/${j}${CHANGESET}"
						echo "################################ Code Merge between $j to $i completed successfully. #######################" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					done
					echo "############ Started Code Commit between $j into $i ######################" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					#cat ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log >> ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_complete.log
					echo $CHANGESETS | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					cd ${CHECKOUT_PATH}/${i}
					echo "cd ${CHECKOUT_PATH}/${i}" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					echo "svn --username ${USERNAME} --password ${PASSWORD} commit ${CHANGESETS} -m "\"$MSG\" :: r\"$REV\" :: \"$AUTHOR\" [SVN TOOL AUTO COMMIT] "" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					export LANG="en_US.UTF-8"
					export LC_COLLATE="en_US.UTF-8"
					export LC_CTYPE="en_US.UTF-8"
					export LC_MESSAGES="en_US.UTF-8"
					export LC_MONETARY="en_US.UTF-8"
					export LC_NUMERIC="en_US.UTF-8"
					export LC_TIME="en_US.UTF-8"
					export LC_ALL="en_US.UTF-8"
					svn --username ${USERNAME} --password ${PASSWORD} commit ${CHANGESETS} -m "\"$MSG\" :: r\"$REV\" :: \"$AUTHOR\" [SVN TOOL AUTO COMMIT] " | tee -a ${LOG_PATH}/${CurrentDate}/temp/${REV}/commit.log | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					COMMITSTATUS=`grep -w "Committed revision" ${LOG_PATH}/${CurrentDate}/temp/${REV}/commit.log`
					if [[ "${COMMITSTATUS}" == "" ]];then echo "Code Commit between $j into $i failed. Please contact TECH TEAM immediately" | tee -a ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log; else echo "Code Commit between $j into $i is successful" | tee -a ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_complete.log >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log;fi
					echo "commit status = ${COMMITSTATUS}" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
					cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log
					cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/changedfilelist.log
					cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/commit.log
				fi
			fi
			done

			if [ -s "${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log" ]
			then
				echo "################# Detected conflicts while merging $j to $i ##########" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
				
				#ERRORS=`grep -C2 "^C" ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_complete.log`
				ERRORS=`cat ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_complete.log`
				#ERRORS_1=`cat ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log | uniq` 2>/dev/null
				ERRORS_1=`cat ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log`
				echo ${ERRORS} | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
				echo ${ERRORS_1} | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
				echo -e "${ERRORS}\n${ERRORS_1}" >&2
				#cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_complete.log
				#cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log
				#cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/${AUTHOR}_Message.log
				cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log
				exit 1;
			else
				echo "################################ Printing Success Messages ################################" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
				SUCCESS_MESSAGE=`cat ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_complete.log | uniq`
				echo -e "$SUCCESS_MESSAGE \n" | sed -e "s/^/$(date +'[%Y-%m-%d %H:%M:%S]') /" >> ${LOG_PATH}/${CurrentDate}/${COMMIT_BRANCH}_POSTCOMMIT.log
				echo "${SUCCESS_MESSAGE}" >&2
				#cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_complete.log
				#cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun_Final.log
				#cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/${AUTHOR}_Message.log
				cat /dev/null > ${LOG_PATH}/${CurrentDate}/temp/${REV}/dryrun.log
				exit 0;
			fi
		fi
	done
fi

