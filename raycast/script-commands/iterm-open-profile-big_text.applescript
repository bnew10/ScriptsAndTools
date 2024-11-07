#!/usr/bin/osascript

# Dependency: requires iTerm (https://iterm2.com)
# Install via Homebrew: `brew install --cask iterm2`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open big_text
# @raycast.packageName iTerm
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Applications/iTerm.app/Contents/Resources/AppIcon.icns

# Documentation:
# @raycast.author bnew10

on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

on run
	set iTermRunning to is_running("iTerm2")
	tell application "iTerm"
		activate
		if not (iTermRunning) then
			delay 0.5
			close the current window
		end if
		create window with profile "big_text"
	end tell
end run
