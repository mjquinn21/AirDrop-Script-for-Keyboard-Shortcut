tell application "System Events" to set activeApp to name of first application process whose frontmost is true
tell application "System Events"
	tell process activeApp
		set frontmost to true --redundacy
		click menu item "AirDrop" of menu of menu item "Share" of menu "File" of menu bar 1
	end tell
end tell
