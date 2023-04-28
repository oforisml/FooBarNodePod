#!/bin/bash

K6_SCRIPT_FILE="foobarLoadTest.js"
RESPONSE_FILE="response.txt"
cat <<EOF > "$K6_SCRIPT_FILE"
import http from 'k6/http';
export const options = {
    stages: [
        { target: 200, duration: '30' },
        {target: 0, duration: '30' }
    ],
};
export default function () {
    if (Math.floor(Math.random() * 1000) % 2 === 0){
        http.get('http://foo.localhost');
    }
    else{
        http.get('http://bar.localhost')
    }
}
EOF

VIRTUAL_USERS=10
ITERATIONS=100


if [ -n "$1" ]; then
    VIRTUAL_USERS=$1
fi

if [ -n "$2" ]; then
    ITERATIONS=$2
fi

k6 run --vus=$VIRTUAL_USERS  --iterations=$ITERATIONS --summary-trend-stats="med,p(95),p(99.9)" $K6_SCRIPT_FILE |  grep "...:" | tail -16 | sed '/scenarios:/d' | sed '/* default/d' > $RESPONSE_FILE
