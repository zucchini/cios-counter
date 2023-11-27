#!/usr/bin/env python3

import sys
from string import digits
from bs4 import BeautifulSoup
from fractions import Fraction

def main(argv):
    if len(argv) != 1:
        print('usage: ./dehtmlify.py "Spring 2022 CS 6290 Lecture A #21973202202"')
        return 1

    title_wanted = argv[0]

    response_rate = None

    soup = BeautifulSoup(sys.stdin, 'html.parser')

    for course in soup.find_all(class_=['MyEvalCenterToBeOpened', 'MyEvalCenterOpened']):
        title = course.select('.classTitle')[0].text
        if title == title_wanted:
            responded_numbers = course.select('.spanRespondedNumbers')
            n_responded = int(responded_numbers[0].text)
            n_total = int(responded_numbers[2].text)
            response_rate = (n_responded, n_total)
            break

    if response_rate is None:
        raise ValueError('i cant find that course!')

    resp_ratio =  float(response_rate[0]) * 100.0 / float(response_rate[1])
    secno = title_wanted[-1]
    print('Section {}:'.format(secno))
    print('{:.2f}%'.format(resp_ratio))
    print('{}/{}'.format(*response_rate))

    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
