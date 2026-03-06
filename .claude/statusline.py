#!/usr/bin/env python3
import json
import sys
import os

# Nerd Font icons
ICON_TERMINAL  = "\uf120"   #
ICON_BRANCH    = "\uf126"   #
ICON_CONTEXT   = "\uf0e7"   #
ICON_SESSION   = "\uf086"   #
ICON_DIR       = "\uf07c"   #
ICON_MODEL     = "\uf135"   #
ICON_VIM_NORMAL = "\uf0c8"  # square
ICON_VIM_INSERT = "\uf040"  # pencil
ICON_VIM_VISUAL = "\uf247"  # selection

# Powerline separators
SEP_SOFT = "\ue0b1"   # soft left
SEP_HARD = "\ue0b0"   # hard left

# Kitty theme colors
C_LIGHT_BLUE  = (143, 191, 220)   # #8fbfdc — active tab bg / inactive tab fg
C_DARK_GRAY   = (78,  78,  78)    # #4e4e4e — inactive tab bg / tab bar bg
C_NEAR_BLACK  = (14,  20,  25)    # #0e1419 — active tab fg

# Vim mode colors
C_VIM_NORMAL  = (152, 195, 121)   # #98c379 green
C_VIM_INSERT  = (229, 192, 123)   # #e5c07b yellow
C_VIM_VISUAL  = (198, 120, 221)   # #c678dd purple

RESET = "\033[0m"

def fg(r, g, b) -> str:
    return f"\033[38;2;{r};{g};{b}m"

def bg(r, g, b) -> str:
    return f"\033[48;2;{r};{g};{b}m"

# Convenience: pre-built color combos
LEFT_BG  = bg(*C_DARK_GRAY)
LEFT_FG  = fg(*C_LIGHT_BLUE)
RIGHT_BG = bg(*C_LIGHT_BLUE)
RIGHT_FG = fg(*C_NEAR_BLACK)

# Soft separator inherits segment colors (already set), so no extra escapes needed
# Hard separator: the glyph itself is colored as: fg = left-bg-color, bg = right-bg-color
TRANS_SEP = fg(*C_DARK_GRAY) + bg(*C_LIGHT_BLUE) + SEP_HARD

def abbreviate_path(path: str) -> str:
    """Abbreviate deep paths like kitty: ~/../../dirname"""
    home = os.path.expanduser("~")
    if path.startswith(home):
        path = "~" + path[len(home):]
    parts = path.split("/")
    # Filter out empty strings from split
    parts = [p for p in parts if p]
    # Reconstruct: if starts with ~, re-add
    if path.startswith("~"):
        if len(parts) <= 3:
            return "~/" + "/".join(parts[1:]) if len(parts) > 1 else "~"
        else:
            return "~/../" + parts[-1]
    else:
        if len(parts) <= 3:
            return "/" + "/".join(parts)
        else:
            return "/../" + parts[-1]

def get_git_branch(cwd: str) -> str:
    """Read git branch from .git/HEAD, walking up directories."""
    check = cwd
    for _ in range(10):
        head_path = os.path.join(check, ".git", "HEAD")
        if os.path.exists(head_path):
            try:
                with open(head_path, "r") as f:
                    ref = f.read().strip()
                if ref.startswith("ref: refs/heads/"):
                    return ref[len("ref: refs/heads/"):]
                # Detached HEAD — show short hash
                return ref[:7]
            except Exception:
                return ""
        parent = os.path.dirname(check)
        if parent == check:
            break
        check = parent
    return ""

def get_session_name(transcript_path: str) -> str:
    try:
        with open(transcript_path, "r") as f:
            lines = f.readlines()
        for line in reversed(lines):
            line = line.strip()
            if not line:
                continue
            try:
                obj = json.loads(line)
                if obj.get("type") == "custom-title" and "customTitle" in obj:
                    return obj["customTitle"]
            except json.JSONDecodeError:
                continue
    except Exception:
        pass
    return ""

def compact_tokens(n) -> str:
    """Format token count compactly: 1234 -> 1.2k, 1000000 -> 1m."""
    if n is None:
        return "?"
    if n >= 1_000_000:
        return f"{n / 1_000_000:.1f}m"
    if n >= 1_000:
        return f"{n / 1_000:.1f}k"
    return str(n)

def context_bar(used_pct) -> str:
    """Return a compact context usage string with warning icon if high."""
    if used_pct is None:
        return ""
    icon = ICON_CONTEXT if used_pct >= 75 else "\uf201"  #  line chart
    return f"{icon} {used_pct:.0f}%"

def main():
    data = json.load(sys.stdin)

    cwd = data.get("workspace", {}).get("current_dir", data.get("cwd", os.getcwd()))
    model_name = data.get("model", {}).get("display_name", "Claude")
    transcript_path = data.get("transcript_path", "")

    ctx = data.get("context_window", {})
    used_pct = ctx.get("used_percentage")
    input_tokens  = ctx.get("total_input_tokens")
    output_tokens = ctx.get("total_output_tokens")

    git_branch = get_git_branch(cwd)
    session_name = get_session_name(transcript_path) if transcript_path else ""
    abbrev_path = abbreviate_path(cwd)

    # Build left segments
    left_parts = []
    left_parts.append(f"{ICON_TERMINAL} {model_name}")
    left_parts.append(f"{ICON_DIR} {abbrev_path}")
    if git_branch:
        left_parts.append(f"{ICON_BRANCH} {git_branch}")
    if session_name:
        left_parts.append(f"{ICON_SESSION} {session_name}")

    # Vim mode
    vim_mode = data.get("vim", {}).get("mode", "")

    # Build right segment
    right_parts = []
    ctx_str = context_bar(used_pct)
    if ctx_str:
        right_parts.append(ctx_str)
    if input_tokens is not None and output_tokens is not None:
        right_parts.append(f"\uf080 {compact_tokens(input_tokens)}/{compact_tokens(output_tokens)}")

    soft_sep = f" {LEFT_FG}{SEP_SOFT} "
    left_content = soft_sep.join(left_parts)
    left = f"{LEFT_BG}{LEFT_FG} {left_content} "

    if right_parts:
        right_content = f" {RIGHT_FG}{SEP_SOFT} ".join(right_parts)
        closing_arrow = fg(*C_LIGHT_BLUE) + "\033[49m" + SEP_HARD + RESET
        right = f"{RIGHT_BG}{RIGHT_FG} {right_content} {closing_arrow}"
        base = f"{left}{TRANS_SEP}{right}"
    else:
        base = f"{left}{RESET}"

    if vim_mode:
        # Determine vim segment color and icon
        if vim_mode == "NORMAL":
            vim_color = C_VIM_NORMAL
            vim_icon = ICON_VIM_NORMAL
        elif vim_mode == "INSERT":
            vim_color = C_VIM_INSERT
            vim_icon = ICON_VIM_INSERT
        elif vim_mode == "VISUAL":
            vim_color = C_VIM_VISUAL
            vim_icon = ICON_VIM_VISUAL
        else:
            vim_color = C_LIGHT_BLUE
            vim_icon = ""

        vim_label = f"{vim_icon} {vim_mode}" if vim_icon else vim_mode
        # Vim segment at the very start: bg=vim color, fg=near-black
        vim_seg = f"{bg(*vim_color)}{fg(*C_NEAR_BLACK)} {vim_label} "
        # Powerline transition arrow: fg=vim color, bg=inactive tab bg, then reset into base
        vim_arrow = f"{fg(*vim_color)}{bg(*C_DARK_GRAY)}{SEP_HARD}"
        print(f"{vim_seg}{vim_arrow}{base}", end="")
    else:
        print(base, end="")

if __name__ == "__main__":
    main()
