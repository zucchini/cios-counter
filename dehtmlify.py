#!/usr/bin/env python3

import sys
from string import digits
from bs4 import BeautifulSoup
from fractions import Fraction

def main(argv):
    if not argv:
        print('usage: ./dehtmlify.py <section_1> <section_2> ... <section_n>\n\nEach section_i will look like "Spring 2025 CS 2110 Lecture E"')
        return 1

    titles_wanted = set(argv)
    # Avoid double-counting sections
    titles_found = set()

    response_rate = (0, 0)

    soup = BeautifulSoup(sys.stdin, 'html.parser')

    for course in soup.find_all(class_=['MyEvalCenterToBeOpened', 'MyEvalCenterOpened']):
        title = course.select('.classTitle')[0].text
        if title in titles_wanted - titles_found:
            titles_found.add(title)
            responded_numbers = course.select('.spanRespondedNumbers')
            n_responded = int(responded_numbers[0].text)
            n_total = int(responded_numbers[2].text)
            response_rate = (response_rate[0] + n_responded, response_rate[1] + n_total)

    titles_missing = titles_wanted - titles_found
    if titles_missing:
        raise ValueError('couldnt find these courses: ' + ', '.join(titles_missing))

    resp_ratio =  float(response_rate[0]) * 100.0 / float(response_rate[1])
    print('{:.2f}%'.format(resp_ratio))
    print('{}/{}'.format(*response_rate))

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
