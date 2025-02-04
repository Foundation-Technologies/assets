#!/bin/bash

dockutil="/usr/local/bin/dockutil"
killall="/usr/bin/killall"
loggedInUser=$( ls -l /dev/console | awk '{print $3}' )
LoggedInUserHome="/Users/$loggedInUser"
UserPlist=$LoggedInUserHome/Library/Preferences/com.apple.dock.plist

# convenience function to run a command as the current user
# usage:
#   runAsUser command arguments...
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

################################################################################
# Use Dockutil to Modify Logged-In User's Dock
################################################################################

echo "------------------------------------------------------------------------"
echo "Current logged-in user: $loggedInUser"
echo "------------------------------------------------------------------------"
echo "Removing all Items from the Logged-In User's Dock..."
runAsUser $dockutil --remove all --no-restart 
echo "Creating New Dock..."
runAsUser $dockutil --add "/Applications/Microsoft Outlook.app" --no-restart 
runAsUser $dockutil --add "/Applications/Microsoft Teams.app" --no-restart 
runAsUser $dockutil --add "/Applications/Company Portal.app" --no-restart 
runAsUser $dockutil --add "/Applications/Microsoft Word.app" --no-restart 
runAsUser $dockutil --add "/Applications/Microsoft Excel.app" --no-restart 
runAsUser $dockutil --add "/Applications/Microsoft PowerPoint.app" --no-restart 
runAsUser $dockutil --add "System/Applications/System Preferences.app" --no-restart 
runAsUser $dockutil --add "~/Downloads" --section others --view auto --display folder --no-restart 
echo "Restarting Dock..."
runAsUser $killall Dock

exit 0
