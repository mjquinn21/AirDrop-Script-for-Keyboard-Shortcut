on run
	tell application "System Events" to set activeApp to name of first application process whose frontmost is true
	set shareButtonExists to false
	set shareBeenClicked to false
	
	tell application "Finder"
		set locOfFile to insertion location as string
		if locOfFile contains ":Desktop:" then
			tell application "Finder"
				set sel to (get the selection)
				reveal sel
				delay 0.1
			end tell
		end if
	end tell
	
	tell application "System Events" to tell application process activeApp to tell window 1
		if exists (every button whose description is "Share") of toolbar 1 then
			set shareButtonExists to true
		end if
	end tell
	
	if shareButtonExists is true then
		tell application "System Events" to tell application process activeApp to tell window 1
			set shareButton to (first button whose description is "Share") of toolbar 1
			ignoring application responses
				click shareButton
			end ignoring
		end tell
		delay 0.01
		set shareBeenClicked to true
	end if
	
	do shell script "killall System\\ Events"
	delay 0.01
	
	
	if shareBeenClicked is true then
		tell application "System Events" to tell application process activeApp to tell window 1
			pick (menu item "AirDrop") of menu 1 of shareButton
		end tell
		quit
	else
		tell application "System Events" to tell application process activeApp
			try
				click menu item "AirDrop" of menu of menu item "Share" of menu "File" of menu bar 1
			on error
				if exists window 2 then tell window 1 to activate
				click menu item "AirDrop" of menu of menu item "Share" of menu "File" of menu bar 1
			end try
		end tell
	end if
end run
