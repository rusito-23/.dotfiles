#!/usr/bin/osascript
-- Creates and focus a new space/desktop
-- Taken from: https://apple.stackexchange.com/questions/178762

do shell script "open -a 'Mission Control'"
delay 0.5
tell application "System Events" to ¬
    click (every button whose value of attribute "AXDescription" is "add desktop") ¬
        of UI element "Spaces Bar" of UI element 1 of group 1 of process "Dock"
delay 0.5
tell application "System Events" to key code 53
