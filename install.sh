#! /usr/bin/env bash
set -xeuo pipefail

# TODO - moar idempotentcy!


# install prereqs
apt-get update
apt-get install -y $(cat prereqs.txt)


# gather list of apps to install
if [ $# -eq 0 ]; then
    apps="$(find apps -name '*.sh')"
else
    apps="$(printf 'apps/%s.sh\n' $@)"
fi


# prep and arrogate packages that need to be installed
apts=''
pips=''
declare -A posts
declare -A tests
for app in ${apps}; do
    echo "preparing for ${app} install..."
    source ${app}
done


# wait for all background downloads to finish
echo "waiting for async stuff to finish"
jobs
time wait
while lsof -w /var/lib/dpkg/lock /var/cache/apt/archives/lock /var/lib/apt/lists/lock; do
    echo "waiting for locks..."
    sleep 1;
done


# install all the things
if [ -n "${apts}" ]; then
    # TODO - you don't always need to update here
    apt-get update
    apt-get install -y ${apts}
fi

if [ -n "${pips}" ]; then
    pip3 install --upgrade --user ${pips}
fi


# post actions
for post in ${!posts[@]}; do
    echo "post action ${post}"
    ${posts[${post}]}
done


# quick tests
test_result=0
for test in ${!tests[@]}; do
    echo "testing ${test}"
    ${tests[${test}]} || ( echo "$TEST '{test}' FAILED"; test_result=1; )
done


# done
exit ${test_result}
