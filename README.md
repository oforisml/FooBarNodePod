# Ingress Controller Installation
``` helm install nginx-ingress ./charts/nginx-ingress-controller-9.5.1.tgz --values ./charts/values.yaml```

The script executes to creaet to install the ingress controller in the cluster to enable traffic flow in the cluster


# Install Load Balancer (Metall)
```./scripts/metallb.sh```
This script executes to install metallb. This becomes a custom installed Load Balancer since the environment is not of any cloud provider like AWS, AZURE or GCP
MetalLB is a load balancer implementation for Kubernetes that provides a network load balancer for bare metal Kubernetes clusters.


# Initialize Load Balancer IP Pool
```kubectl apply -f ./loadbalancer/metallb.yaml```
This creates an IP Address Pool that specifies a range of IP addresses to allocate for LoadBalancer services

It further creates An L2Advertisement resource  in the metallb-system namespace. This resource is not necessary for the IPAddressPool to work, but is used to advertise the Layer 2 (L2) address of the cluster nodes to the network switches to prevent network errors.



# Deployments
``` ./scripts/deploy.sh```
This is what deploys the Deployments kinds and the Service kinds to the cluster to enable the web server run as expected.

