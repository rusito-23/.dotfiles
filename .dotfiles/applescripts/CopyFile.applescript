#!/usr/bin/osascript
-- Copy File
-- Copies the current file into the system clipboard

on run {filePath}
    set theFile to POSIX file filePath as alias
    tell application "Finder"
        set the clipboard to theFile
    end tell
end run
