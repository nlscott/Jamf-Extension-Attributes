#!/bin/zsh

opensslPath=$(which openssl)
opensslVersion=$(openssl version | awk '{print $2}')


if [[ $opensslPath =~ "not found" ]]; then
   echo "<result>"unknown"</result>"
else
   echo "<result>"$opensslVersion"</result>"
fi