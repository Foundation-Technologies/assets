#!/bin/bash

dockutil=/usr/local/bin/dockutil
currentUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ { print $3 }')
uid=$(id -u "$currentUser")
userHome=$(dscl . -read /users/${currentUser} NFSHomeDirectory | cut -d " " -f 2)
plist="${userHome}/Library/Preferences/com.apple.dock.plist"

runAsUser() {  
  if [ "$currentUser" != "loginwindow" ]; then
    launchctl asuser "$uid" sudo -u "$currentUser" "$@"
  else
    echo "No user logged in."
    # uncomment the exit command
    # to make the function exit with an error when no user is logged in
    exitCode=1
    exit $exitCode
  fi
}

# Configure the dock for a new user
runAsUser $dockutil --add "/Applications/Microsoft Outlook.app" --no-restart 
runAsUser $dockutil --add "/Applications/Microsoft Teams.app" --no-restart 
runAsUser $dockutil --add "/Applications/OneDrive.app" --no-restart 
runAsUser $dockutil --add "/Applications/Microsoft Word.app" --no-restart 
runAsUser $dockutil --add "/Applications/Microsoft Excel.app" --no-restart 
runAsUser $dockutil --add "/Applications/Microsoft PowerPoint.app" --no-restart
runAsUser $dockutil --add "/Applications/Microsoft OneNote.app" --no-restart 
runAsUser $dockutil --add "/Applications/Self-Service.app" --position start --no-restart 

runAsUser $dockutil --remove "TV" --no-restart
runAsUser $dockutil --remove "App Store" --no-restart
runAsUser $dockutil --remove "Music" --no-restart
runAsUser $dockutil --remove "Podcasts" --no-restart 
runAsUser $dockutil --remove "FaceTime" --no-restart 
runAsUser $dockutil --remove "Messages" --no-restart 
runAsUser $dockutil --remove "News" --no-restart 
runAsUser $dockutil --remove "Maps" --no-restart 
runAsUser $dockutil --remove "Contacts" --no-restart 
runAsUser $dockutil --remove "Freeform" --no-restart
runAsUser $dockutil --remove "Reminders" --no-restart
runAsUser $dockutil --remove "Photos" --no-restart
runAsUser $dockutil --remove "Mail" --no-restart
runAsUser $dockutil --remove "Calendar" --no-restart
runAsUser $dockutil --remove "Notes" --no-restart
runAsUser $dockutil --remove "Phone" --no-restart
runAsUser $dockutil --remove "Games" --no-restart
runAsUser $dockutil --remove "iPhone Mirroring" --no-restart

runAsUser $dockutil --move "System Settings" --position end

/usr/bin/killall Dock

exit 0
