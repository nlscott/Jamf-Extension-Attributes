#!/bin/zsh


requireAdminNetworkChangeStatus=$(/usr/libexec/airportd en0 prefs | grep RequireAdminNetworkChange | cut -d "=" -f2)


function checkAdminNetworkChangeStatus() {
    if [[ $requireAdminNetworkChangeStatus = "YES" ]];then
        echo "<result>"YES"</result>"
    elif [[ $requireAdminNetworkChangeStatus = "NO" ]];then
        echo "<result>"NO"</result>"
    else
        echo "<result>"UNKOWN"</result>"
    fi
}


checkAdminNetworkChangeStatus
