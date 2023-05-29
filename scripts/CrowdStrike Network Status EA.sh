#!/bin/zsh


# Date: 2023.05.04
# Author: nic.scott
# Summary: Checks the network filter status of CrowdStrike Falcon in the
# com.apple.networkextension.plist. This should match what is shown in "System Settings >
# Network > Filtes". If the status is disabled, we re-enable with "falconctl enable-filter"



logDate=$(date "+%Y%m%d.%H%M%S")
networkFilter="com.crowdstrike.falcon.App"
plistFile="/Library/Preferences/com.apple.networkextension.plist"


function getSizeOfArrary() {
    arrarySize=0
    while [ $arrarySize -lt 1000 ] ;do
        output=$(/usr/libexec/PlistBuddy -c 'Print :$objects:"'"$arrarySize"'"' "$plistFile" 2>&1 | grep "Exist" )
    
        if [[ $output =~ "Does Not Exist" ]];then
            # echo $arrarySize
            break
        fi
        let arrarySize=arrarySize+1
    done
}

function checkStatusOfCrowdStrike() {
    COUNT=0
    while [ $COUNT -lt $(($arrarySize - 1)) ] ;do
       
        output=$(/usr/libexec/PlistBuddy -c 'Print :$objects:"'"$COUNT"'"' "$plistFile")

        if [[ $output = "$networkFilter" ]];then
            arrayIndex=$(( $COUNT + 1 ))
            networkFilterStatus=$(/usr/libexec/PlistBuddy -c 'Print :$objects:"'"$arrayIndex"'":Enabled' "$plistFile")
            if [[ $networkFilterStatus = "true" ]];then
                echo "<result>"Enabled"</result>"
                exit 0
            elif [[ $networkFilterStatus = "false" ]];then
                echo "<result>"Disabled"</result>"
                exit 0
            else
                echo "<result>"Unknown"</result>"
                exit 0
            fi
        fi
        let COUNT=COUNT+1
    done
}

getSizeOfArrary
checkStatusOfCrowdStrike