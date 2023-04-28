# Introduction  
This is a project where by I deployed two http-echo servicers to serve to hosts.
The first hostname is `http://foo.localhost` and it returns the text `"foo"` and the second one is `http://bar.localhost` which also returns `"bar"`


## TOOLS  
Tools used for this project were  
1. Helm  
2. Bash  
3. KinD
4. Kubectl  
5. GitHub Actions  
6. K6  


### Helm  
Helm was used to install a helm chart for an  `Nginx Ingress Controller` which served as the gateway to the ingresses of the two servers.  
The This ingress controller was installed in the `ingress` namespace.

### Bash 
Bash was justed used to run some basic commands just to sanify the code which is in the github actions file `main.yaml`  

### KinD  
KinD which stands for Kubernetes in Docker is the main tool used in creating the kubernetes cluster.

### Kubectl
This runs commands in the cluster. `Kubectl` is a kubernetes command line tool used to run kubernetes commands.

### GitHub Actions  
The whole architecture of this system is just centered around the CI job which is done using GitHub Actions.  
The github actions job is triggered on pull request and when the request is approved or confirmed, the pipeline executes and tests the load on the hostnames of the application servers deployed then comments the summary of the test under the pull request.  

### K6
`K6` the main tool used to perform and report the Load Test performed in this setting.




## Directories Structure
` .github/ ` contains the parent directory of the GA workflow.  
` charts/ ` houses the ingress controller helm chart with its values
` k6 ` contains a bash script that executes to generate a json file to test the load in the CI
` k8 ` contains the .yaml files that has both the kind ` Service ` and kind ` Deployment ` of the two *http-echo* servers and it finally contains the kind ` Ingress ` which serves a gateway for traffic intake.
` kindCluster ` has the configuration file for creating the cluster. This creates one master node and three worker nodes.
` LB ` contains the worker a .yaml file that creaes an *ip address pool* for the metallb which is a load balancer because this kubernetes cluster is not on a cloud provider hence for the ingress controller to have a load balancer, there was a need to install metallb which gave a cluster wide load balancer to be used by the ingress controller.

