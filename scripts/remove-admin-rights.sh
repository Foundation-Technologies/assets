#!/bin/bash

loggedInUser=$( ls -l /dev/console | awk '{print $3}' )
sudo -u $loggedInUser /Applications/Privileges.app/Contents/MacOS/PrivilegesCLI --remove

exit 0
