#!/bin/zsh


function checkFileSystem () {
    fsType="$(/usr/sbin/diskutil info / | /usr/bin/awk 'sub(/File System Personality: /,""){print $0}' | xargs)"
    if [[ "$fsType" != *APFS* ]]; then
        echo "<result>Invalid: File System is $fsType</result>"
        exit 0
    fi
}

function checkArchitecture () {
    platform=$(/usr/bin/arch)
    if [[ "$platform" != "arm64" ]]; then
        echo "<result>Invalid: Platform is $platform</result>"
        exit 0
    fi
}

function getVolumeOwners (){
    listOfVolumeOwners=()
    arrayofUUIDs=( $(diskutil apfs listUsers / | grep +-- | awk '{print $2}') )
    for UUID in "${arrayofUUIDs[@]}"; do
        get_username=$(dscl . -search /Users GeneratedUID $UUID | xargs | awk '{print $1}')
        if [[ $get_username != "" ]]; then
            admin_check=$(dsmemberutil checkmembership -U $get_username -G admin)
            admin_output="user is a member of the group"
            if [ $admin_check = $admin_output ]; then
                listOfVolumeOwners+=($get_username)
            elif [ $admin_check != $admin_output ]; then
                listOfVolumeOwners+=($get_username)
            else
                continue
            fi   
        else
            continue
        fi
    done
}

function showVolumeOwners () {
    echo "<result>$listOfVolumeOwners</result>"
}


checkFileSystem
checkArchitecture
getVolumeOwners
showVolumeOwners



