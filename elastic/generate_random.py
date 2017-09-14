#!/usr/bin/env python
import random
import sys
import getopt
import tempfile
from subprocess import check_output, CalledProcessError
import json

import datetime
import requests
import time
import pytz

epoch = datetime.datetime.utcfromtimestamp(0)


def unix_time_millis(dt):
    return (dt - epoch).total_seconds() * 1000


dict = {'worker': 'w1', 'thread': 'thread1', 'hash_count': 300, 'hash_rate': 300.13, 'time': '2017-09-14 05:46:39'}

# print json.dumps(dict)
# body = '\'%s\'' % (json.dumps(dict),)
# print body


url = 'http://localhost:9200/bitcoin/bitcoin'
headers = {'content-type': 'application/json', 'Accept-Charset': 'UTF-8'}
utc = pytz.timezone('UTC')


while 1:
    dict['hash_count'] = random.randint(100, 400)
    dict['hash_rate'] = random.randint(100, 400)
    dict['time'] = utc.localize(datetime.datetime.now()).strftime("%Y-%m-%d %H:%M:%S")
    payload = json.dumps(dict)
    r = requests.post(url, data=payload, headers=headers)
    print payload, r
    time.sleep(60)




# _exec_command(['curl', '-XPOST', '/', '-H', '\'Content-Type: application/json\'', '-d', body ] )
