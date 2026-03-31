#!/bin/bash
LOGFILE=$1
KEYWORD=${2:-"error"}   # if no keyword given, default to "error"

COUNT=0         
TOTAL=0         

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║              KERNEL LOG FILE ANALYZER                ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

if [ -z "$LOGFILE" ]; then
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog kernel"
    echo ""
    echo "  Common Linux log files to try:"
    echo "    /var/log/syslog      (Ubuntu/Debian)"
    echo "    /var/log/messages    (CentOS/Fedora)"
    echo "    /var/log/kern.log    (kernel messages)"
    echo "    /var/log/dmesg       (boot messages)"
    exit 1
fi

if [ ! -f "$LOGFILE" ]; then
    echo "  Error: File '$LOGFILE' does not exist."
    exit 1
fi

ATTEMPT=1
while [ $ATTEMPT -le 2 ]; do
    if [ ! -s "$LOGFILE" ]; then
        # File exists but is empty
        if [ $ATTEMPT -eq 1 ]; then
            echo "  Warning: '$LOGFILE' appears empty. Retrying in 2 seconds..."
            sleep 2
            ATTEMPT=$((ATTEMPT + 1))
        else
            echo "  File is still empty after retry. Nothing to analyze."
            exit 0
        fi
    else
        # File has content, break out of retry loop
        break
    fi
done

echo "  Log file : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo ""
echo "  Scanning..."
echo ""

while IFS= read -r LINE; do


    TOTAL=$((TOTAL + 1))

    # Check if this line contains the keyword (case-insensitive with -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi

done < "$LOGFILE"   # feed file into the while loop via stdin redirect


echo "──────────────────────────────────────────────────────"
echo "  RESULTS"
echo "──────────────────────────────────────────────────────"
echo "  Total lines scanned       : $TOTAL"
echo "  Lines matching '$KEYWORD' : $COUNT"

# Calculate percentage if total is not zero
if [ $TOTAL -gt 0 ]; then
    # bash only does integer math, so multiply by 100 first
    PERCENT=$(( COUNT * 100 / TOTAL ))
    echo "  Match rate                : $PERCENT%"
fi

echo ""

echo "──────────────────────────────────────────────────────"
echo "  LAST 5 MATCHING LINES"
echo "──────────────────────────────────────────────────────"
echo ""

# grep -i = case insensitive | tail -5 = last 5 results only
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -z "$MATCHES" ]; then
    echo "  No matches found for '$KEYWORD'."
else
    # Print each matching line with a small indent
    echo "$MATCHES" | while IFS= read -r MATCH; do
        echo "  › $MATCH"
    done
fi

echo ""
echo "──────────────────────────────────────────────────────"
echo "  WHY LOG FILES MATTER IN OPEN SOURCE"
echo "──────────────────────────────────────────────────────"
echo ""
echo "  On proprietary systems, log files are often hidden"
echo "  or encrypted. On Linux, every kernel event is logged"
echo "  in plain text — anyone can read, audit, or pipe them."
echo "  Transparency is not just a feature. It is the design."
echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║                 End of Analysis                      ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
