-- Copy File Path
-- Copies the current file path into the system clipboard
-- https://github.com/unforswearing/applescript

tell application "Finder"
    set pathFile to selection as text
    set pathFile to get POSIX path of pathFile
    set the clipboard to pathFile
end tell
