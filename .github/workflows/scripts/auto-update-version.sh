#!/bin/bash

# Value to change MARKETING_VERSION to
NEW_VERSION=$(date '+%y').$(date '+%m').$(date '+%d')

# Path to the project.pbxproj file
PDXPROJ_FILE="BlackjackCounting.xcodeproj/project.pbxproj"

# Pattern to find the MARKETING_VERSION line
VERSION_PATTERN="MARKETING_VERSION ="

# String for replacing the MARKETING_VERSION line
REPLACEMENT="MARKETING_VERSION = $NEW_VERSION;"

# Replace MARKETING_VERSION in the file
sed -i '' "s/$VERSION_PATTERN.*/$REPLACEMENT/g" "$PDXPROJ_FILE"

echo "MARKETING_VERSION has been changed to $NEW_VERSION."
