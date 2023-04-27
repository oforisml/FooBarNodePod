#!/bin/bash


cd ../k8s/

kubectl apply -f foo-deployment.yaml 
kubectl apply -f bar-deployment.yaml   

kubectl apply -f ingress-controller-service.yaml

kubectl wait --namespace default --for=condition=ready deployment --all 
kubectl wait --namespace ingress-nginx --for=condition=ready deployment --all 

kubectl apply -f ingress.yaml

cd ../scripts