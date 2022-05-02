#!/bin/sh
nohup /home/pthadur/DryRun_SONAR/apache-ant-1.10.0/bin/ant -v -f /home/pthadur/DryRun_SONAR/Sonar/WB/HSRI-HIX-sonar-build.xml > /home/pthadur/DryRun_SONAR/Sonar/WB/logs/HSRI-HIX-sonar-build.log &
nohup /home/pthadur/DryRun_SONAR/apache-ant-1.10.0/bin/ant -v -f /home/pthadur/DryRun_SONAR/Sonar/WB/HSRI-SSP-sonar-build.xml > /home/pthadur/DryRun_SONAR/Sonar/WB/logs/HSRI-SSP-sonar-build.log &
nohup /home/pthadur/DryRun_SONAR/apache-ant-1.10.0/bin/ant -v -f /home/pthadur/DryRun_SONAR/Sonar/WB/HSRI-CCAP-sonar-build.xml > /home/pthadur/DryRun_SONAR/Sonar/WB/logs/HSRI-CCAP-sonar-build.log &
nohup /home/pthadur/DryRun_SONAR/apache-ant-1.10.0/bin/ant -v -f /home/pthadur/DryRun_SONAR/Sonar/WB/HSRI-EARR-sonar-build.xml > /home/pthadur/DryRun_SONAR/Sonar/WB/logs/HSRI-EARR-sonar-build.log &
nohup /home/pthadur/DryRun_SONAR/apache-ant-1.10.0/bin/ant -v -f /home/pthadur/DryRun_SONAR/Sonar/WB/HSRI-IES-sonar-build.xml > /home/pthadur/DryRun_SONAR/Sonar/WB/logs/HSRI-IES-sonar-build.log &
tail -f /home/pthadur/DryRun_SONAR/Sonar/WB/logs/HSRI-IES-sonar-build.log