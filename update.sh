#!/bin/bash
set -e
set -o pipefail

[[ -z $1 ]] && {
    printf 'usage: %s <semester_1> <semester_2> ... <semester_n>\n' "$0" >&2
    exit 2
}

sems=( "$@" )

[[ ! -e curl.sh ]] && {
    printf 'error: you need to create curl.sh, read the readme pls\n' >&2
    exit 2
}

while true; do
    . curl.sh >page.html

    for sem in "${sems[@]}"; do
        mkdir -p "$sem"

        {
            printf -- '             CS 2110 CIOS Progress\n'
            printf -- '             =====================\n'
            printf -- '\n'
            ./dehtmlify.py "$sem" <page.html | figlet -c -w 50
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
        } >"$sem/status.next.txt"

        # Update the file atomically if we can (that is, if we crash, leave it alone)
        mv "$sem/status.next.txt" "$sem/status.txt"
    done

    sleep 5m
done
