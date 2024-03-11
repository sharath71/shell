#!/bin/bash

# Function to check if a number is prime
is_prime() {
    local num=$1
    if [ $num -lt 2 ]; then
        return 1
    fi
    for (( i=2; i*i<=$num; i++ )); do
        if [ $((num % i)) -eq 0 ]; then
            return 1
        fi
    done
    return 0
}

# Usage: ./check_primes.sh <start_number> <end_number>
start=$1
end=$2

if [ -z "$start" ] || [ -z "$end" ]; then
    echo "Usage: $0 <start_number> <end_number>"
    exit 1
fi

echo "Prime numbers between $start and $end are:"
for (( num=start; num<=end; num++ )); do
    if is_prime $num; then
        echo $num
    fi
done
