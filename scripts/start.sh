#!/bin/bash


cd ../k8s/

kubectl apply -f foo-deployment.yaml 
kubectl apply -f bar-deployment.yaml   

kubectl apply -f ingress-controller-service.yaml

kubectl wait --for=condition=Ready --namespace ingress-nginx svc --all 
kubectl wait --for=condition=Ready --namespace ingress-nginx deployments --all 


kubectl apply -f ingress.yaml

cd ../scripts
