#!/bin/bash

# Usage: ./search_pattern.sh <pattern> <file>

pattern="$1"
file="$2"

if [ -z "$pattern" ] || [ -z "$file" ]; then
    echo "Usage: $0 <pattern> <file>"
    exit 1
fi

# Search for the pattern in the file
grep "$pattern" "$file"
