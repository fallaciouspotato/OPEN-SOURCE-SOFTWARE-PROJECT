#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Course: Open Source Software | Chosen Software: Linux Kernel
# What it does: Prints a welcome screen with system details
# Concepts used: variables, command substitution $(), echo
# ============================================================

# --- Student info (fill these in) ---
STUDENT_NAME="Priyanshu Chourasiya"
REG_NUMBER="24BCG10013"
SOFTWARE="Linux Kernel"
LICENSE="GNU General Public License version 2 (GPL v2)"

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                         # kernel version
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # distro name
USERNAME=$(whoami)                         # current logged-in user
HOME_DIR=$HOME                             # home directory of current user
UPTIME=$(uptime -p)                        # human-readable uptime
DATETIME=$(date '+%A, %d %B %Y — %H:%M')  # formatted date and time
CPU=$(uname -m)                            # CPU architecture

# --- Display the report ---
echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║           OPEN SOURCE AUDIT — SYSTEM REPORT          ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
echo "  Student   : $STUDENT_NAME ($REG_NUMBER)"
echo "  Software  : $SOFTWARE"
echo ""
echo "──────────────────────────────────────────────────────"
echo "  SYSTEM DETAILS"
echo "──────────────────────────────────────────────────────"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Architecture : $CPU"
echo "  User         : $USERNAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date & Time  : $DATETIME"
echo ""
echo "──────────────────────────────────────────────────────"
echo "  LICENSE"
echo "──────────────────────────────────────────────────────"
echo "  This operating system is covered by the:"
echo "  $LICENSE"
echo ""
echo "  Under GPL v2, you are free to run, study, share,"
echo "  and modify this software — as long as any changes"
echo "  you distribute are also shared under GPL v2."
echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║                  End of Report                       ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
