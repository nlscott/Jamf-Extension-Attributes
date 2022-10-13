
#!/bin/zsh

console_user=$(/usr/bin/stat -f "%Su" /dev/console)
googleDefaultProfile="/Users/$console_user/Library/Application Support/Google/Chrome/Default"
googlePreferenceFile="/Users/$console_user/Library/Application Support/Google/Chrome/Default/Preferences"


function checkDefaultProfile () {
    if [ -d "$googleDefaultProfile" ]; then
        if [ -f "$googlePreferenceFile" ]; then
            syncStatus=$(cat "$googlePreferenceFile"  | grep -e 'consented_to_sync\":true')
            if [[ ! -z $syncStatus ]]; then
                echo "<result>"true"</result>"
            elif [[ -z $syncStatus ]]; then
                echo "<result>"false"</result>"
            else
                echo "<result>"not signed in"</result>"
            fi
        else
             echo "<result>"no preference file"</result>"
        fi
    else
        echo "<result>"no default profile"</result>"
    fi
}



checkDefaultProfile
