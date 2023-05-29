#!/bin/sh


# Date: 2023.05.29
# Author: nic.scott
# Summary: Checks the authorizationdb for permissions to install apple updates and
# reports corrupted if they are changed from the default. This was to indentifiy issues
# with users that can not restart their computer from GUI by choosing apple icon >
# restart, becuae the logout hangs


AuthDbSetting=$(security authorizationdb read system.install.apple-software | grep "root-or-entitled-admin-or-authenticate-admin")

if [[ -z $AuthDbSetting ]]; then
	echo "<result>Corrupted</result>"
else
	echo "<result>Correct</result>"
fi
