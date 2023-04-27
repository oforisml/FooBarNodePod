#!/bin/bash

for i in {1..1000}
do
  # Randomly Generating a random number between 1 and 2
  rand=$((RANDOM % 2 + 1))

  # The random number is used to determine which URL to request
  if [ $rand -eq 1 ]
  then
    curl foo.localhost
  else
    curl bar.localhost
  fi
done
