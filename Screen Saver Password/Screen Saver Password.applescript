--
--  Screen Saver Password.applescript
--  Screen Saver Password
--
--  Created by Monty on 9/24/12.
--  Copyright (c) 2012 taolam. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	-- this property will be used to configure our notification
	property myNotification : missing value
    
    property theAppName : "Screen Saver Password"
    property theSetMessage : "The Screen Saver Password has been enabled."
    property theClearMessage : "The Screen Saver Password has been disabled."
    property theResult : "false"
    
	on applicationWillFinishLaunching_(aNotification)
        tell application "System Events"
            tell security preferences
                if get require password to wake is true then
                    set require password to wake to false
                else
                    set require password to wake to true
                    set theResult to "true"
                end if
            end tell
        end tell
        
        if theResult is "true"
            -- send a notification to indicate the Screen Saver Pasword has been set
            sendNotificationWithTitle_AndMessage_(theAppName,theSetMessage)
        else
            -- send a notification to indicate the Screen Saver Pasword has been cleared
            sendNotificationWithTitle_AndMessage_(theAppName,theClearMessage)
        end if
    quit
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
    
	-- Method for sending a notification based on supplied title and text
	on sendNotificationWithTitle_AndMessage_(aTitle, aMessage)
		set myNotification to current application's NSUserNotification's alloc()'s init()
		set myNotification's title to aTitle
		set myNotification's informativeText to aMessage
		current application's NSUserNotificationCenter's defaultUserNotificationCenter's deliverNotification_(myNotification)
	end sendNotification
	
	
end script