#!/usr/bin/osascript
-- Toggle Menu bar Icons Focus
-- Sends the keys `^ + F8`, the default macOS shortcut to focus the menu bar.

tell application "System Events"
    key code 100 using {control down}
end tell
