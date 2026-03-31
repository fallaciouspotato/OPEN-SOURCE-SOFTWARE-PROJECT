#!/bin/bash

PACKAGE="linux-image-$(uname -r)"

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║            FOSS PACKAGE INSPECTOR                    ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
echo "  Inspecting package: $PACKAGE"
echo "──────────────────────────────────────────────────────"

if command -v dpkg &>/dev/null; then
    SYSTEM_TYPE="debian"
elif command -v rpm &>/dev/null; then
    SYSTEM_TYPE="rpm"
    PACKAGE="kernel"
else
    echo "  Could not detect package manager. Exiting."
    exit 1
fi

if [ "$SYSTEM_TYPE" = "debian" ]; then

    if dpkg -l "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        VERSION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{print $3}')
        DESCRIPTION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{$1=$2=$3=$4=""; print $0}' | xargs)
    else
        INSTALLED=false
    fi
else
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        VERSION=$(rpm -qi "$PACKAGE" 2>/dev/null | grep "^Version" | awk '{print $3}')
        DESCRIPTION=$(rpm -qi "$PACKAGE" 2>/dev/null | grep "^Summary" | cut -d: -f2 | xargs)
    else
        INSTALLED=false
    fi
fi

if [ "$INSTALLED" = true ]; then
    echo "  Status      : ✔ Installed"
    echo "  Version     : $VERSION"
    echo "  Description : $DESCRIPTION"
    echo ""
    echo "  Current running kernel : $(uname -r)"
    echo "  Architecture           : $(uname -m)"
else
    echo "  Status : ✘ Package '$PACKAGE' not found on this system."
    echo "  Tip    : Try running: sudo apt install linux-image-generic"
fi

echo ""
echo "──────────────────────────────────────────────────────"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "──────────────────────────────────────────────────────"

BASE=$(echo "$PACKAGE" | sed 's/-[0-9].*//' | tr '[:upper:]' '[:lower:]')

case $BASE in
    linux*|kernel*)
        echo "  Linux: The kernel that proved a student with a modem"
        echo "  and a mailing list could outbuild a corporation."
        echo "  Today it runs 100% of the world's top supercomputers."
        ;;
    apache*|httpd*)
        echo "  Apache: The web server that held up the early internet"
        echo "  when it had no reason to — because volunteers cared."
        ;;
    mysql*|mariadb*)
        echo "  MySQL: A reminder that open source and commerce can"
        echo "  coexist — and sometimes fork when they can't."
        ;;
    firefox*)
        echo "  Firefox: A nonprofit's answer to corporate browser"
        echo "  monopoly. Still fighting for an open web."
        ;;
    git*)
        echo "  Git: Linus built this in two weeks after a proprietary"
        echo "  tool betrayed him. It now runs all of software."
        ;;
    python*)
        echo "  Python: Proof that a language shaped entirely by"
        echo "  community consensus can become the world's most loved."
        ;;
    vlc*)
        echo "  VLC: Born in a French university dorm, now plays"
        echo "  literally every format ever invented. For free."
        ;;
    *)
        echo "  Every open source tool carries someone's frustration"
        echo "  turned into a gift. This one is no different."
        ;;
esac

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║                  End of Inspection                   ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
