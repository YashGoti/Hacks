#!/usr/bin/env python
#@_YashGoti_
import sys, requests, jsbeautifier

def beautifyjs(content):
    try:
        return jsbeautifier.beautify(content)
    except:
        pass

def getjsresponse(url):
    try:
        return requests.get('{}'.format(url), timeout=10)
    except:
        pass

if __name__ == "__main__":
    try:
        if sys.argv[1]:
            response = getjsresponse(sys.argv[1])
            if response.status_code == 200:
                print(beautifyjs(response.text))
            else:
                pass
        else:
            print("~/jsbeautify.py {} https://jsurl.js".format(sys.argv[0]))
    except:
        pass
