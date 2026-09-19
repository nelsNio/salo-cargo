#!/bin/sh
set -eu
python -c "import json, urllib.request; data=json.load(urllib.request.urlopen('http://127.0.0.1:' + __import__('os').environ.get('PORT','8000') + '/api/health')); raise SystemExit(0 if data.get('ok') else 1)"
