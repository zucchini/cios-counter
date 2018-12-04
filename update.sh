#!/bin/bash
set -e

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
        printf 'cs 2110 cios progress\n'
        printf '\n'
        . curl.sh | ./dehtmlify.py "$sem" | figlet
        printf '\n'
        printf 'https://b.gatech.edu/cios\n'
        printf '\n'
        printf 'last updated: %s\n' "$(date)"
        printf 'source code: https://github.com/zucchini/cios-counter/\n'
    } >status.txt

    sleep 5m
done
