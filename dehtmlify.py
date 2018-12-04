#!/usr/bin/env python3

import sys
from string import digits
from bs4 import BeautifulSoup

def main(argv):
    if len(argv) != 1:
        print('usage: ./dehtmlify.py <term>')
        sys.exit(1)

    term_wanted = argv[0]

    sections = set()
    section_responses = {}
    section_totals = {}

    soup = BeautifulSoup(sys.stdin, 'html.parser')

    # Find columns
    cols = [col.text for col in soup.find_all('th')]
    col_indices = {col: i for i, col in enumerate(cols)}

    for section_row in soup.select('tbody tr'):
        section_columns = section_row.find_all('td')
        term = section_columns[col_indices['Term']].text
        section = section_columns[col_indices['Sec']].text
        # A1 -> A, B34 -> B, etc
        letter = section.rstrip(digits)

        if term != term_wanted:
            continue

        # stats
        total = int(section_columns[col_indices['Total']].text)
        resp = int(section_columns[col_indices['Resp']].text)

        sections.add(letter)
        section_responses.setdefault(letter, 0)
        section_totals.setdefault(letter, 0)
        section_responses[letter] += resp
        section_totals[letter] += total

    for section in sorted(sections):
        percent = section_responses[section] / section_totals[section] * 100
        print('{}: {:.2f}%'.format(section, percent))

if __name__ == '__main__':
    main(sys.argv[1:])
