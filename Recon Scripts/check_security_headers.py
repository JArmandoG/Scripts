import requests
import pprint

security_headers = {}
url = ''

def initialize_headers():
    global security_headers
    security_headers['XSS_PROTECTION'] = 'False'
    security_headers['CSP'] = 'False'
    security_headers['XFRAME_OPTIONS'] = 'False'
    security_headers['NO_SNIFF'] = 'False'
    security_headers['HSTS'] = 'False'
    security_headers['HPKP'] = 'False'

def parse_headers(url):
    global security_headers
    initialize_headers()
    try:
        print("Connecting to %s" % url)
        # we deliberately ignore SSL certificate errors
        req = requests.get(url, verify=False)

        for header in req.headers.items():
            if 'x-xss-protection' in header[0].lower():
                security_headers['XSS_PROTECTION'] = 'True'
            if 'public-key-pins' in header[0].lower():
                security_headers['HPKP'] = 'True'
            if 'x-frame-options' in header[0].lower():
                security_headers['XFRAME_OPTIONS'] = 'True'
            if 'x-content-type-options' in header[0].lower():
                security_headers['NO_SNIFF'] = 'True'
            if 'content-security-policy' in header[0].lower():
                security_headers['CSP'] = 'True'
            if 'strict-transport-security' in header[0].lower():
                security_headers['HSTS'] = 'True'
        return security_headers, req.headers.items()
    except Exception as err:
        print(err)
    return False

SH, original_headers = parse_headers(url)
print(f"[+] Results for {url}")
pprint.pprint(SH, depth=1)

print(type(original_headers))
pprint.pprint(original_headers, depth=1)
