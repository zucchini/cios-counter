#!/bin/bash
set -e
set -o pipefail

[[ -z $1 ]] && {
    printf 'usage: %s <section_1> <section_2> ... <section_n>\n\nEach section_i will look like "Spring 2025 CS 2110 Lecture E"\n' "$0" >&2
    exit 2
}

sems=( "$@" )

[[ ! -e curl.sh ]] && {
    printf 'error: you need to create curl.sh, read the readme pls\n' >&2
    exit 2
}

whereami=$(dirname "${BASH_SOURCE[0]}")

while true; do
    . curl.sh >page.html

    {
        printf -- '             CS 2110 CIOS Progress\n'
        printf -- '             =====================\n'
        printf -- '\n'
        ./dehtmlify.py "${sems[@]}" <page.html | figlet -c -w 50
        printf -- '\n'
        printf -- '              Do your CIOS here:\n'
        printf -- '      ===>                           <===\n'
        printf -- '      ===> https://b.gatech.edu/cios <===\n'
        printf -- '      ===>                           <===\n'
        printf -- '\n'
        printf -- '\n'
        printf -- '\n'
        printf -- '\n'
        printf -- '\n'
        printf -- '------------------------------------------------------\n'
        printf -- 'last updated: %s\n' "$(TZ=America/New_York date)"
        printf -- 'source code: https://github.com/zucchini/cios-counter/\n'
    } >"$whereami/status.next.txt"

    # Update the file atomically if we can (that is, if we crash, leave it alone)
    mv "$whereami/status.next.txt" "$whereami/status.txt"

    sleep 5m
done
