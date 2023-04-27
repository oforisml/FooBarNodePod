#!/bin/bash

for _ in {1..10}; do curl foo.localhost; done

for _ in {1..10}; do curl bar.localhost; done