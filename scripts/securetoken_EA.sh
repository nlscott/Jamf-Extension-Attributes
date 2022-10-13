#!/bin/bash



console_user=$(/usr/bin/stat -f "%Su" /dev/console)
checkSecureTokenStatus=$(sysadminctl -secureTokenStatus $console_user 2>&1 >/dev/null )

if [[ "$checkSecureTokenStatus" =~ "ENABLED" ]];then    
    echo "Token"
    echo "<result>"Token"</result>"
else
    echo "<result>"No_Token"</result>"
fi