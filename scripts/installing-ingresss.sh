#!/bin/bash


TIMEOUT=${1:-180s}
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml



echo "waiting for ingress ingress controller!..."
kubectl wait --namespace ingress-nginx --for=condition=available deployment --all 

