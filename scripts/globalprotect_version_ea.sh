#!/bin/sh


globalProtectApp="/Applications/GlobalProtect.app"


 if [ -d "$globalProtectApp" ]; then
   if [ -f "$globalProtectApp/Contents/Info.plist" ]; then
      globalProtectVersion=$( defaults read "$globalProtectApp/Contents/Info.plist" CFBundleShortVersionString )
      echo "<result>"$globalProtectVersion"</result>"
   else
      echo "<result>"null"</result>"  
   fi
else
   echo "<result>"null"</result>" 
fi