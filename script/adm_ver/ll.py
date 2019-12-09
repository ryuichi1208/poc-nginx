#!/usr/bin/python3

import requests
import bs4

BASE_BALL = "https://rankings.wbsc.org/ja"


def main():
    rs = requests.get(BASE_BALL)
    soup = bs4.BeautifulSoup(rs.text, "lxml")
    for s in soup.find_all('div', class_="ranking-listing-homepage-team-row"):
        print(s.find("span", class_="team-points").text.strip())



if __name__ == "__main__":
    main()
