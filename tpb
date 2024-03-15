#!/usr/bin/env python
import sys
import requests
import argparse
from urllib.parse import quote
from bs4 import BeautifulSoup

CATEGORIES = {
        'all': 0,
        'movie': 207,
        'tv': 208,
}

def main():
    parser = argparse.ArgumentParser()

    parser.add_argument('search', default=None)
    parser.add_argument('-c', '--category', default='all', choices=CATEGORIES.keys())

    args = parser.parse_args()

    response = requests.get(f"https://thepiratebay10.org/search/{args.search}/1/99/{CATEGORIES[args.category]}")
    response.raise_for_status()

    soup = BeautifulSoup(response.text, 'html.parser')

    raw_listings = [part.parent.parent for part in soup.find_all('div', class_='detName')]

    listings = map(Listing, raw_listings)


    print('search for:', response.url)
    for l in listings:
        try:
            print(l)
        except Exception as e:
            print('broke on')
            print(l.raw)
            raise e

class Listing:
    def __init__(self, raw):
        self.raw = raw

    def __str__(self):
        return f'{self.seed()}\t{self.leech()}\t{self.name():<80}\t{self.magnet()}'

    def name(self):
        return self.raw.find('div', class_='detName').text.strip()

    def seed(self):
        return self.raw.find_all('td')[-2].text

    def leech(self):
        return self.raw.find_all('td')[-1].text

    def magnet(self):
        return self.raw.select_one('a[href^=magnet]')['href']

    def user(self):
        return self.raw.select_one('a[title^=Browse]').text


if __name__ == '__main__':
    main()

