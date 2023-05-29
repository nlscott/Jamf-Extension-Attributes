#!/bin/zsh

# Date: 2023.02.17
# Author: nic.scott
# Summary:reports back the name of the accoutn signed into AppleID/iCloud in System Settings




loggedInUser=$(stat -f%Su /dev/console)
icloudAccountName=$( defaults read /Users/$loggedInUser/Library/Preferences/MobileMeAccounts.plist Accounts | grep AccountID | cut -d '"' -f 2)

function getiCloudAccountName() {
    if [ -z "$icloudAccountName" ]; then
        echo "<result>Not Signed In</result>"
    else
        echo "<result>$icloudAccountName</result>"
    fi
}

getiCloudAccountName