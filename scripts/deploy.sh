#!/bin/bash
for deployment in ./k8s/deployments/
    do
        kubectl apply -f $deployment
    done
