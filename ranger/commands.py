#!/bin/python3
# Author: Igor Andruskiewitsch
# Notes: Custom commands for the Ranger terminal file manager

# -- IMPORTS

import os
import subprocess
import ranger

# -- COMMON CONSTANTS

NULL_ERR="2> /dev/null"
MATCH="\( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \)"
FIND="find -L {} {} -prune -o {} -print"
FZF="fzf --height 100% +m"

# -- COMMANDS

class fzf(ranger.api.commands.Command):
    """:fzf [-d]
    Find a file or directory using `fzf`.
    """
    # Constants
    path="."
    parse="sed 1d | cut -b3-"

    def build_command(self):
        args = "-type d" if self.arg(1) == '-d' else ""
        find = f"{FIND.format(self.path, MATCH, args)}"
        command = f"{find} {NULL_ERR} | {self.parse} | {FZF}"
        return command

    def execute(self):
        # Execute fzf command
        command = self.build_command()
        exe = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, _ = exe.communicate()

        # Escape if an error occurred
        if exe.returncode != 0:
            return

        # Get selected path
        sel_path = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))

        # Navigate to selected path
        if os.path.isdir(sel_path):
            self.fm.cd(sel_path)
        else:
            self.fm.select_file(sel_path)


class rg(ranger.api.commands.Command):
    """:rg <args> <pattern>
    Live RipGrep over current directory.
    Outputs the files that match the search and navigates to the file.
    """
    ripgrep="rg"

    def execute(self):
        # Check arguments
        if len(self.args) < 2:
            self.fm.notify("Usage: rg <pattern>", bad=True)
            return

        # Execute rg command with given parameters
        command = f"{self.ripgrep} -l {' '.join(self.args[1:])} | {FZF}"
        exe = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, _ = exe.communicate()

        # Build path
        rel_path = stdout.decode('utf-8').strip('\n')
        abs_path = f"{self.fm.thisdir.path}/"

        # Navigate to selected path
        sel_path = os.path.abspath(f"{abs_path}{rel_path}")
        self.fm.select_file(sel_path)
