#!/bin/bash
today() {
    date '+%d %B %Y'
}

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║        OPEN SOURCE MANIFESTO GENERATOR               ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
echo "  Answer three questions honestly."
echo "  Your answers will be woven into a personal"
echo "  open source philosophy statement."
echo ""
echo "──────────────────────────────────────────────────────"

# --- Question 1: daily tool ---
echo ""
read -p "  1. Name one open-source tool you use every day: " TOOL

# Keep asking until they actually type something
while [ -z "$TOOL" ]; do
    echo "     Come on, there's definitely one. Git? Linux? Firefox?"
    read -p "  1. Name one open-source tool you use every day: " TOOL
done

# --- Question 2: what freedom means ---
echo ""
read -p "  2. In one word, what does 'freedom' in software mean to you? " FREEDOM

while [ -z "$FREEDOM" ]; do
    read -p "  2. One word — control? choice? transparency? trust?: " FREEDOM
done

# --- Question 3: what they would build ---
echo ""
read -p "  3. Name one thing you would build and share freely if you could: " BUILD

while [ -z "$BUILD" ]; do
    read -p "  3. Anything — an app, a tool, a library, a game: " BUILD
done

echo ""
echo "──────────────────────────────────────────────────────"
echo "  Generating your manifesto..."
echo "──────────────────────────────────────────────────────"
echo ""

# --- Build the output filename using whoami (current user) ---
OUTPUT="manifesto_$(whoami).txt"

# --- Get today's date using our alias-style function ---
DATE=$(today)

# --- Compose the manifesto and write it to the file ---
# Using > creates/overwrites the file
# Using >> appends to it line by line
echo "════════════════════════════════════════════" > "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Written by: $(whoami) on $DATE" >> "$OUTPUT"
echo "════════════════════════════════════════════" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- The actual manifesto paragraph ---
# We concatenate the user's three answers into a flowing paragraph
echo "  Every day I use $TOOL — software I did not pay for," >> "$OUTPUT"
echo "  built by people I have never met, who chose to share" >> "$OUTPUT"
echo "  their work rather than lock it away." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  To me, freedom in software means $FREEDOM." >> "$OUTPUT"
echo "  Not in an abstract sense, but in a practical one —" >> "$OUTPUT"
echo "  the freedom to look inside a tool, to fix it, to" >> "$OUTPUT"
echo "  adapt it, and to pass it on better than you found it." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  If I had the time and skill, I would build $BUILD" >> "$OUTPUT"
echo "  and I would share it. Not because I have to." >> "$OUTPUT"
echo "  Because that is what this community taught me:" >> "$OUTPUT"
echo "  the most powerful thing you can do with knowledge" >> "$OUTPUT"
echo "  is give it away." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  — Written on a Linux machine, $(uname -r)" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "════════════════════════════════════════════" >> "$OUTPUT"

# --- Show the result ---
echo "  Manifesto saved to: $OUTPUT"
echo ""
echo "──────────────────────────────────────────────────────"
cat "$OUTPUT"
echo "──────────────────────────────────────────────────────"
echo ""
echo "  To view it again anytime, run:  cat $OUTPUT"
echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║           Manifesto generated successfully           ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
