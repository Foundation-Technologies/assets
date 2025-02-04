#!/bin/bash

# convenience function to run a command as the current user
# usage:
#   runAsUser command arguments...
currentUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ { print $3 }')
uid=$(id -u "$currentUser")

runAsUser() {  
  if [ "$currentUser" != "loginwindow" ]; then
    launchctl asuser "$uid" sudo -u "$currentUser" "$@"
  else
    echo "no user logged in"
    # uncomment the exit command
    # to make the function exit with an error when no user is logged in
    # exit 1
  fi
}

loggedInUser=$( ls -l /dev/console | awk '{print $3}' )
runAsUser /Applications/Privileges.app/Contents/MacOS/PrivilegesCLI --remove

exit 0
