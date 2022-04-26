# Yabai Cheatsheet


# Navigation with bsp layout

```
lctrl + alt - h : yabai -m window --focus west
lctrl + alt - j : yabai -m window --focus south
lctrl + alt - k : yabai -m window --focus north
lctrl + alt - l : yabai -m window --focus east
```

# Navigation with stack layout

```
lctrl - p : yabai -m window --focus stack.prev
lctrl - n : yabai -m window --focus stack.next
```

# Moving windows

```
lctrl + lshift - h : yabai -m window --warp west
lctrl + lshift - j : yabai -m window --warp south
lctrl + lshift - k : yabai -m window --warp north
lctrl + lshift - l : yabai -m window --warp east
```

# Resize windows

```
lctrl + cmd - h : yabai -m window --resize left:-50:0; \
                     yabai -m window --resize right:-50:0
lctrl + cmd - j : yabai -m window --resize bottom:0:50; \
                     yabai -m window --resize top:0:50
lctrl + cmd - k : yabai -m window --resize top:0:-50; \
                     yabai -m window --resize bottom:0:-50
lctrl + cmd - l : yabai -m window --resize right:50:0; \
                    yabai -m window --resize left:50:0
```

# Equalize size of windows

```
rshift + lctrl - e : yabai -m space --balance
```

# Manage windows between spaces

```
alt + shift - p : yabai -m window --space prev; \
                  yabai -m space --focus prev
alt + shift - n : yabai -m window --space next; \
                  yabai -m space --focus next
```

# Manage spaces

```
rctrl + shift - c : osascript ~/.dotfiles/applescripts/CreateSpace.applescript
rctrl + shift - d : osascript ~/.dotfiles/applescripts/CloseLastSpace.applescript
```

# Rotate windows clockwise and anticlockwise

```
alt - r         : yabai -m space --rotate 270
shift + alt - r : yabai -m space --rotate 90
```

# Rotate on X and Y Axis

```
shift + alt - x : yabai -m space --mirror x-axis
shift + alt - y : yabai -m space --mirror y-axis
```

# Set insertion point for focused container

```
shift + lctrl + alt - h : yabai -m window --insert west
shift + lctrl + alt - j : yabai -m window --insert south
shift + lctrl + alt - k : yabai -m window --insert north
shift + lctrl + alt - l : yabai -m window --insert east
```

# Float / Unfloat window

```
cmd + shift - space : \
    yabai -m window --toggle float; \
    yabai -m window --toggle border
```

# Toggle layouts in the current space

```
ctrl + shift - f : yabai -m space --layout float
ctrl + shift - s : yabai -m space --layout stack
ctrl + shift - b : yabai -m space --layout bsp
```

# Apple Script Global Shortcuts

```
ctrl - home : osascript ~/.dotfiles/applescripts/FocusMenuBar.applescript
ctrl - end : osascript ~/.dotfiles/applescripts/FocusMenuBarIcons.applescript
ctrl - pagedown : osascript ~/.dotfiles/applescripts/FocusDock.applescript
ctrl + shift - end : osascript -l JavaScript ~/.dotfiles/applescripts/ToggleCapsLock.applescript false
ctrl + shift - home : osascript -l JavaScript ~/.dotfiles/applescripts/ToggleCapsLock.applescript true
cmd + shift - c : osascript ~/.dotfiles/applescripts/CopyFilePath.applescript
```
