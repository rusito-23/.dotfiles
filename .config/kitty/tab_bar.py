import os
from pathlib import Path
from kitty.boss import get_boss
from kitty.fast_data_types import add_timer, get_options
from kitty.utils import color_as_int
from kitty.tab_bar import Formatter, draw_attributed_string, as_rgb, TabAccessor

""" Global """

opts = get_options()
timer_id = None

""" Constants """

REFRESH_TIME = 1
HOME = os.getenv("HOME")

SEPARATOR_LEFT = "\ue0b0"
SOFT_SEPARATOR_LEFT = "\ue0b1"
SEPARATOR_RIGHT = "\ue0b2"
SOFT_SEPARATOR_RIGHT = "\ue0b3"

DEFAULT_BG=as_rgb(color_as_int(opts.tab_bar_background))
INACTIVE_TAB_BG=as_rgb(color_as_int(opts.inactive_tab_background))
INACTIVE_TAB_FG=as_rgb(color_as_int(opts.inactive_tab_foreground))
ACTIVE_TAB_BG=as_rgb(color_as_int(opts.active_tab_background))
ACTIVE_TAB_FG=as_rgb(color_as_int(opts.active_tab_foreground))

TERMINAL_ICON = "\uf120 "
HOURGLASS_ICON = "\uf254"
FLASH_ICON = "\uf0e7"
BELL_ICON = "\uf0f3"

""" Cells """


""" The tab cells to the left of the tab bar """
class TabCell:
    def __init__(self, index, text, is_active, is_last, next_tab):
        self.display_text = f" {index} {SOFT_SEPARATOR_LEFT} {text} "
        self.is_active = is_active
        self.is_last = is_last
        self.is_next_active = next_tab.is_active if next_tab else False
        self.separator = SEPARATOR_LEFT \
                if self.is_active or self.is_next_active \
                else SOFT_SEPARATOR_LEFT

    def __len__(self):
        return len(self.display_text) + len(self.separator)

    def draw(self, screen):
        screen.cursor.fg = ACTIVE_TAB_FG if self.is_active else INACTIVE_TAB_FG
        screen.cursor.bg = ACTIVE_TAB_BG if self.is_active else INACTIVE_TAB_BG
        screen.draw(self.display_text)

        if self.is_next_active:
            screen.cursor.fg = INACTIVE_TAB_BG
            screen.cursor.bg = ACTIVE_TAB_BG
        elif self.is_active:
            screen.cursor.fg = ACTIVE_TAB_BG
            screen.cursor.bg = INACTIVE_TAB_BG
        else:
            screen.cursor.fg = INACTIVE_TAB_FG
            screen.cursor.bg = INACTIVE_TAB_BG

        screen.draw(self.separator)


""" The info cells to the right of the tab bar """
class InfoCell:
    def __init__(self, icon, text, highlight):
        self.display_text = f" {icon} {text}"
        self.highlight = highlight
        self.separator = SEPARATOR_RIGHT if highlight else SOFT_SEPARATOR_RIGHT

    def __len__(self):
        return len(self.separator) + len(self.display_text)

    def draw(self, screen):
        screen.cursor.fg = INACTIVE_TAB_FG
        screen.cursor.bg = INACTIVE_TAB_BG
        screen.draw(self.separator)

        screen.cursor.fg = ACTIVE_TAB_FG if self.highlight else INACTIVE_TAB_FG
        screen.cursor.bg = ACTIVE_TAB_BG if self.highlight else INACTIVE_TAB_BG
        screen.draw(self.display_text)


""" Utils """


def _accessor(tab):
    return TabAccessor(tab.tab_id)


def _get_icons(tab):
    icons = []
    if tab.needs_attention:
        icons.append(FLASH_ICON)
    if tab.has_activity_since_last_focus:
        icons.append(BELL_ICON)
    return " ".join(icons)


def _get_cwd(tab):
    cwd = _accessor(tab).active_wd.replace(HOME, "~")
    items = cwd.split("/")
    return f"{items[0]}/../{items[-1]}" if len(items) > 3 else cwd


""" Cell Factory """


def _make_tab_cell(screen, tab, index, is_last, next_tab):
    title = " ".join([_get_icons(tab), _get_cwd(tab)])
    return TabCell(index, title, tab.is_active, is_last, next_tab)


def _make_active_process_name_cell(tab):
    text = _accessor(tab).active_exe
    return InfoCell(TERMINAL_ICON, text, True)


def _make_info_cells(tab):
    return [_make_active_process_name_cell(tab)]


""" Private Drawing """


def _draw_left_status(screen, tab, index, is_last, next_tab):
    cell = _make_tab_cell(screen, tab, index, is_last, next_tab)
    cell.draw(screen)
    return screen.cursor.x


def _draw_right_status(screen, tab, is_last):
    if not is_last:
        return 0
    draw_attributed_string(Formatter.reset, screen)
    cells = _make_info_cells(tab)
    screen.cursor.x = screen.columns - sum(len(c) for c in cells)
    for cell in cells:
        cell.draw(screen)
    return screen.cursor.x


def _redraw_tab_bar(_):
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


""" Drawing """


def draw_tab(
    draw_data,
    screen,
    tab,
    before,
    max_title_length,
    index,
    is_last,
    extra_data
):
    global timer_id
    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)

    _draw_left_status(screen, tab, index, is_last, extra_data.next_tab)
    _draw_right_status(screen, tab, is_last)
    return screen.cursor.x
