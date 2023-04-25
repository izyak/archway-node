import json
import sys
import os
HOME = os.path.expanduser('~')

PATH = f"{HOME}/testnetx/node1/config/genesis.json"

with open(PATH) as outfile:
  file = json.load(outfile)

addr1 = sys.argv[1]
addr2 = sys.argv[2]

file["app_state"]["auth"]["accounts"]=[
  {
    "@type": "/cosmos.auth.v1beta1.BaseAccount",
    "address": addr1,
    "pub_key": None,
    "account_number": "0",
    "sequence": "0"
  },
  {
    "@type": "/cosmos.auth.v1beta1.BaseAccount",
    "address": addr2,
    "pub_key": None,
    "account_number": "0",
    "sequence": "0"
  }
]


file["app_state"]["bank"]["balances"] = [
  {
    "address": addr1,
    "coins": [
      {
        "denom": "validatortoken",
        "amount": "100000000000000"
      }
    ]
  },
  {
    "address": addr2,
    "coins": [
      {
        "denom": "validatortoken",
        "amount": "100000000000000"
      }
    ]
  }
]

with open(PATH, "w") as outfile:
    json.dump(file, outfile)
