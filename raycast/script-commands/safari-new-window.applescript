#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Applications/Safari.app/Contents/Resources/AppIcon.icns
# @raycast.packageName Safari

# Documentation:
# @raycast.author Bradley Newton
# @raycast.authorURL https://github.com/bnew10

tell application "Safari"
    set newWindow to make new document
    set bounds of window 1 to {0, 0, 1440, 900} -- Set window size and position on main display
    activate
end tell

