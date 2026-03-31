#!/bin/bash
DIRS=(
    "/etc"        
    "/boot"       
    "/proc"       
    "/var/log"    
    "/home"       
    "/usr/bin"    
    "/usr/src"    
    "/tmp"        
    "/sys"        
)

echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║              LINUX DIRECTORY AUDIT REPORT                       ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""
printf "  %-16s %-12s %-10s %-8s %s\n" "DIRECTORY" "SIZE" "PERMS" "OWNER" "NOTE"
echo "  ──────────────────────────────────────────────────────────────"


for DIR in "${DIRS[@]}"; do

    # Check if directory actually exists before trying to read it
    if [ -d "$DIR" ]; then

        # Get permissions, owner, and group using ls -ld
        # awk extracts: field 1 = permissions, field 3 = owner, field 4 = group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')

        # Get disk usage with du; suppress permission errors with 2>/dev/null
        # cut -f1 extracts just the size (first field before the tab)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # If du returned nothing (e.g. /proc is virtual), label it accordingly
        if [ -z "$SIZE" ]; then
            SIZE="virtual"
        fi

        # Add a short note for directories that are especially relevant
        # to the Linux kernel audit
        case $DIR in
            /boot)    NOTE="← kernel & bootloader live here" ;;
            /proc)    NOTE="← live kernel info (not real files)" ;;
            /sys)     NOTE="← kernel exposes hardware here" ;;
            /usr/src) NOTE="← kernel source code" ;;
            /tmp)     NOTE="← world-writable, watch permissions" ;;
            *)        NOTE="" ;;
        esac

        printf "  %-16s %-12s %-10s %-8s %s\n" "$DIR" "$SIZE" "$PERMS" "$OWNER" "$NOTE"

    else
        printf "  %-16s %s\n" "$DIR" "[not found on this system]"
    fi

done

echo ""
echo "──────────────────────────────────────────────────────────────"
echo "  KERNEL-SPECIFIC CHECK"
echo "──────────────────────────────────────────────────────────────"

KERNEL_VERSION=$(uname -r)
KERNEL_CONFIG="/boot/config-$KERNEL_VERSION"

echo ""
echo "  Running kernel version : $KERNEL_VERSION"
echo ""

if [ -f "$KERNEL_CONFIG" ]; then
    # Get permissions and size of the kernel config file
    CONFIG_PERMS=$(ls -l "$KERNEL_CONFIG" | awk '{print $1}')
    CONFIG_SIZE=$(du -sh "$KERNEL_CONFIG" | cut -f1)
    echo "  Kernel config file     : $KERNEL_CONFIG"
    echo "  Permissions            : $CONFIG_PERMS"
    echo "  Size                   : $CONFIG_SIZE"
    echo ""
    echo "  This file contains every compile-time decision made"
    echo "  for your kernel — thousands of yes/no/module choices."
else
    echo "  Kernel config file not found at $KERNEL_CONFIG"
    echo "  Try: zcat /proc/config.gz | head -20 (if available)"
fi

echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                     End of Audit                                ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""
