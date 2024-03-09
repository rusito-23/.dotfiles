#!/usr/bin/osascript
-- Closes the last space/desktop
-- Taken from: https://stackoverflow.com/questions/66892255/

tell application "Mission Control" to launch
delay 1
tell application "System Events"
    tell list 1 of group 2 of group 1 of group 1 of process "Dock"
        set buttonNames to the name of UI elements
        set buttonNames to the reverse of buttonNames
        set i to the length of buttonNames
        repeat with buttonName in buttonNames
            if contents of buttonName is equal to ("Desktop " & i as text) then
                if i is greater than 1 then
                    perform action "AXRemoveDesktop" of button i
                    exit repeat
                end if
            else
                set i to i - 1
            end if
        end repeat
    end tell
    delay 0.25
    key code 53 --  # Esc key on US English Keyboard
end tell
