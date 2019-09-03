#! /usr/bin/env bash
set -xeuo pipefail

# install prereqs
apt-get update
apt-get install -y $(cat prereqs.txt)

declare -A tests
apps=''
for app in $(find apps -name '*.sh'); do
    echo "installing ${app} prereqs..."
    source ${app}
done

# wait for all background downloads to finish
jobs
time wait

# install all the things
apt-get update
apt-get install -y ${apts}
pip3 install --upgrade --user ${pips}

test_result=0
for test in ${!tests[@]}; do
    echo "testing ${test}"
    ${tests[${test}]} || ( echo "$TEST '{test}' FAILED"; test_result=1; )
done

exit ${test_result}
