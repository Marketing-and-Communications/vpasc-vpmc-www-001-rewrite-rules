#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if ! which python3 > /dev/null
then
  echo "Failed to find python3 in path... aborting"
  exit 1
fi

if [ ! -d "${SCRIPT_DIR}/../sam/.aws-sam" ]
then
  sam build --use-container
  python3 
fi

cd "${SCRIPT_DIR}/../"
python3 tester/rewrite_tester.py --test_path tests --debug $@
