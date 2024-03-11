#!/bin/bash

# Function to check if a number is even or odd
is_even_or_odd() {
    local num=$1
    if [ $((num % 2)) -eq 0 ]; then
        echo "$num is even"
    else
        echo "$num is odd"
    fi
}

# Usage: ./check_even_odd.sh <number>
number=$1

if [ -z "$number" ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

is_even_or_odd $number
