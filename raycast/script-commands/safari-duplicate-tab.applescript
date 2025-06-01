#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Duplicate Tab
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Safari
# @raycast.icon /Applications/Safari.app/Contents/Resources/AppIcon.icns

# @Documentation:
# @raycast.author Bradley Newton
# @raycast.authorURL https://github.com/bnew10
# @raycast.description Duplicates the currently active tab.

tell application "System Events"
  tell process "Safari"
    click menu item "Duplicate Tab" of menu 1 of menu bar item "Window" of menu bar 1
  end
end
return
