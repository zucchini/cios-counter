#!/bin/bash
set -e
set -o pipefail

[[ -z $1 ]] && {
    printf 'usage: %s <semester>\n' "$0" >&2
    exit 2
}

sem=$1

[[ ! -e curl.sh ]] && {
    printf 'error: you need to create curl.sh, read the readme pls\n' >&2
    exit 2
}

while true; do
    {
        printf 'cs 6290 cios progress\n'
        printf '\n'
        . curl.sh | ./dehtmlify.py "$sem" | figlet
        printf '\n'
        printf 'https://b.gatech.edu/cios\n'
        printf '\n'
        printf 'last updated: %s\n' "$(date)"
        printf 'source code: https://github.com/zucchini/cios-counter/\n'
    } >status.next.txt

    # Update the file atomically if we can (that is, if we crash, leave it alone)
    mv status.next.txt status.txt

    sleep 5m
done
