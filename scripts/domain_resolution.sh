#!/bin/bash

LB_IP=$(kubectl get svc/ingress-controller -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')



echo "${LB_IP} foo.localhost" | sudo tee -a /etc/hosts
echo "${LB_IP} bar.localhost" | sudo tee -a /etc/hosts


cat /etc/hosts