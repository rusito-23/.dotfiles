#!/usr/bin/osascript
-- Toggle Menu bar Focus
-- Sends the keys `^ + F2`, the default macOS shortcut to focus the menu bar.

tell application "System Events"
    key code 120 using {control down}
end tell
