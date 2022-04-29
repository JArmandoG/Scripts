#!/usr/bin/python
import shodan

SHODAN_API_KEY = ""
api = shodan.Shodan(SHODAN_API_KEY)
my_search = "ssl:'domain'"

try:
    results = api.search(my_search)
    print(results)
except shodan.APIError as e:
    print('Error: {}'.format(e))
