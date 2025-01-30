#!/bin/zsh


################################################################################
# Name      	: netskope_status_ea.sh                                                                                                                                                 
# Date          : 2025.01.23 
# Version       : 0.1.1                                                                                    
# Author       	: Nic Scott                                               
# Email         : nls.inbox@gmail.com
# Description	: Checks the conneciton status of the netskope agent                                     
################################################################################


## VARIABLES -------------------------------------------------------------------
netskope_binary="/Library/Application Support/Netskope/STAgent/nsdiag"
netskop_status=$(/Library/Application\ Support/Netskope/STAgent/nsdiag -f | grep "Client status" | cut -d ":" -f3 | xargs)


## FUNCTIONS -------------------------------------------------------------------


function check_netskope_status () {
    if [[ ! -e "$netskope_binary" ]]; then 
        echo "<result>Not Installed</result>" 
    elif [[ "$netskop_status" =~ "enable" ]]; then 
        echo "<result>Connected</result>" 
    elif [[ "$netskop_status" =~ "disable" ]]; then 
        echo "<result>Disabled</result>" 
    else 
        echo "<result>Unknown</result>" 
    fi
}


## COMMANDS --------------------------------------------------------------------
check_netskope_status