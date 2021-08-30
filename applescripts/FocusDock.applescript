#!/usr/bin/osascript
-- Toggle Dock Focus
-- Sends the keys `^ + F3`, the default macOS shortcut to focus the dock.

tell application "System Events"
    key code 99 using {control down}
end tell
