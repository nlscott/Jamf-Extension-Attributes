#!/bin/bash


javaPath=$(which java)
javaVersion=$($javaPath -version 2> >(grep "java version") | cut -d "\"" -f2)
javaRuntime=$($javaPath -version 2> >(grep "Unable to locate a Java Runtime"))



if [[ -z $javaPath ]];then
   echo "<result>"none"</result>"
   exit 0
fi


if [[ -z $javaRuntime ]];then
   if [[ ! -z $javaVersion ]];then
      echo "<result>"$javaVersion"</result>"
      exit 0
   fi
else
   echo "<result>"no runtime installed"</result>"
   exit 0
fi
