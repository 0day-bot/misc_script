#!/usr/bin/env python

#
from bs4 import BeautifulSoup
import requests

def get_horoscope(ZODIAC):

    url = f"https://www.astrology.com/horoscope/daily/{ZODIAC}.html"

    r = requests.get(url)

    soup = BeautifulSoup(r.text, 'html.parser')

    hor = soup.find_all('p')

    return hor

def main():
    hor = get_horoscope('taurus')
    daily = hor[1].get_text()
    love = hor[2].get_text()
    work = hor[3].get_text()

    print(f"Daily Horoscope: \n {daily}\nLove Horoscope: \n {love}\nWork Horoscope: \n{work}")

if __name__ == "__main__":
    main()
