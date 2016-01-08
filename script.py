#!/usr/bin/env python
import json
import sys

def dumps(data):
    return json.dumps(data, sort_keys=True)

if __name__ == "__main__":
    if len(sys.argv) == 1 + 1 and sys.argv[1] == "init":
        print(dumps({'data': [], 'host': [], 'participant': {}}))
    elif len(sys.argv) == 3 + 1 and sys.argv[1] == "join":
        old = json.loads(sys.argv[2])
        ID = sys.argv[3]
        old["data"].append(ID)
        old["participant"][ID] = []
        print(dumps(old))
    elif sys.argv[1] == "receive":
        old = json.loads(sys.argv[2])
        recieved = json.loads(sys.argv[3])
        old["data"].append(recieved)
        if len(sys.argv) == 3 + 1:
            old["host"].append(recieved)
        elif len(sys.argv) == 4 + 1:
            ID = sys.argv[4]
            old["participant"][ID].append(recieved)
        print(dumps(old))
