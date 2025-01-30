#!/bin/zsh

################################################################################
# Name      	: homebrew_installed_ea.sh                                                                                                                                                 
# Date          : 2025.01.28 
# Version       : 0.1.0                                                                                    
# Author       	: Nic Scott                                               
# Email         : nls.inbox@gmail.com 
# Description	: checks to see if homebrew is installed and reports version                                    
################################################################################


## VARIABLES -------------------------------------------------------------------
current_user=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }')



## FUNCTIONS -------------------------------------------------------------------
function which_homebrew () {
    if [[ -f "/usr/local/bin/brew" ]]; then
        homebrew_path="/usr/local/bin/brew"
        echo "$homebrew_path"
        echo ""
    elif [[ -e "/opt/homebrew/bin/brew" ]]; then
        homebrew_path="/opt/homebrew/bin/brew"
        echo "$homebrew_path"
        echo ""
    else
        homebrew_path="False"
        echo "Could not find brew path"
        echo ""
    fi
}


function homebrew_version () {
    if [[ $homebrew_path == "False" ]]; then
        echo "<result>"Not Installed"</result>"
    else
        echo "<result>"$(sudo -u "$current_user" $homebrew_path --version | awk '{print $2}' | awk '{print $1}'| xargs)"</result>"
    fi
}



## COMMANDS --------------------------------------------------------------------
which_homebrew
homebrew_version