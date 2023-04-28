# INTRODUCTION  
This is a project where by I deployed two http-echo servicers to serve to hosts.
The first hostname is ```http://foo.localhost``` and it returns the text ```"foo"``` and the second one is ```http://bar.localhost``` which also returns ```"bar"```

## TOOLS  
Tools used for this project were  
1. Helm  
2. Bash  
3. KinD
4. Kubectl  
5. GitHub Actions  
6. K6  


### Helm  
Helm was used to install a helm chart for an  **Nginx Ingress Controller** which served as the gateway to the ingresses of the two servers.  
The This ingress controller was installed in the **ingress** namespace.

### Bash 
Bash was justed used to run some basic commands just to sanify the code which is in the github actions file **main.yaml`**  

### KinD  
KinD which stands for Kubernetes in Docker is the main tool used in creating the kubernetes cluster.

### Kubectl
This runs commands in the cluster. **Kubectl** is a kubernetes command line tool used to run kubernetes commands.

### GitHub Actions  
The whole architecture of this system is just centered around the CI job which is done using GitHub Actions.  
The github actions job is triggered on pull request and when the request is approved or confirmed, the pipeline executes and tests the load on the hostnames of the application servers deployed then comments the summary of the test under the pull request.  

### K6
**K6** the main tool used to perform and report the Load Test performed in this setting.




# DIRECTORIES
