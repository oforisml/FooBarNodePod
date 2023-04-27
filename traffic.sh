#!/bin/bash

results="load_test_results.txt"

for i in {1..1000}; do
  if (( RANDOM % 2 )); then
    host="foo.localhost"
  else
    host="bar.localhost"
  fi

  curl -s -w '%{http_code}\t%{time_total}\t%{time_connect}\t%{time_starttransfer}\n' -o /dev/null "$host" >> "$results"
done



cat $results