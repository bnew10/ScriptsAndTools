#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Tab to New Window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Applications/Safari.app/Contents/Resources/AppIcon.icns
# @raycast.packageName Safari

# Documentation:
# @raycast.author Bradley Newton
# @raycast.authorURL https://github.com/bnew10

tell application "System Events"
  tell process "Safari"
    click menu item "Move Tab to New Window" of menu 1 of menu bar item "Window" of menu bar 1
  end tell
end tell
return
