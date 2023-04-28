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
**` .github/ `** contains the parent directory of the GA workflow.  

**` charts/ `** houses the ingress controller helm chart with its values  

**` k6 `** contains a bash script that executes to generate a json file to test the load in the CI  

**` k8 `** contains the .yaml files that has both the kind ` Service ` and kind ` Deployment ` of the two ***http-echo*** servers and it finally contains the kind ` Ingress ` which serves a gateway for traffic intake.  

**` kindCluster `** has the configuration file for creating the cluster. This creates one master node and three worker nodes.  

**`LB `** contains the worker a .yaml file that creates an ***ip address pool*** for the metallb which is a load balancer because this kubernetes cluster is not on a cloud provider hence for the ingress controller to have a load balancer, there was a need to install metallb which gave a cluster wide load balancer to be used by the ingress controller.


## Scripts
**`install_ingress.sh`** installs the `NGINX ingress controller` which directs traffic from the load balancer to the ingress..

**`deploy_foobar.sh`** is a script that invokes kubectl to deploy all the content of the `k8s/`

**`setup_metalLB.sh`** contains commands to install ***metallb*** which serves as the only load balancer in the entire cluster since the cluster is not on any cloud provider and hence has no load balancer. The script further runs th .yaml file that creates the IPAddressPool

**`update_hostfile.sh`**  adds the ip address of the load balancer to the host file of the server for both http-echo servers.

**`traffic.sh`** is just curls the both `foo.localhost` and `bar.localhost`. 
          


# Github Actions Flow
The flow is located in the **`.github/workflow`** directory.
This contains the .yaml file which has the entire CI flow.


The entire CI job runs on an **`ubuntu-latest`** virtual machine provided by GitHub for the github actions job.



The flow is triggered on pull request. After the entire CI flow runs, the summary of the Load Test is commented on that pull request.
For the comment to go through there is a permission added to the CI job which allows for the comment to be added to the pull request.


### Steps
1. First and foremost, there is a checkout/pulls of repository to runner machine using the action **`actions/checkout@v3`** from the github action market place. Hence, making the files in the repository available to begin the CI job.

2. the github action **`docker/setup-qemu-action@v2`** from the marketplace, as a basis since the KinD will be using docker to for the cluster creating. The cluster is installed on docker hence, the need for the machine to have docker.

3. installs k6 which will be used for the stress test of the http-echo servers. K6 takes instruction from .json files which contains the configuration of how may virtual users, iterations etc should k6 have while actively testing the deployments.

4. creates the kubernetes cluster using **`kind`**. It uses the `config.yaml` to create 1 master node and 3 worker nodes in the cluster.

5. The ingress controller is deployed to allow traffic from the load balancer reach the ingress of the deployments. This ingress controller is deployed in a namespace of its own.

6. There is a brief pause of 10s to allow the ingress controller to get ready before the major deployments of the servers start.


7. `deploy_foobar.sh` deploys the two echo-servers on the cluster. Each of the two servers contain both the foo.localhost and bar.localhost hostname of the ingresses respectively. It further creates the ingress for the two deployments.

8. `setup_metalLB.sh` installs the Metal Load Balancer for the cluster. This is necessary because there is no load balancer available on the cluster because KinD was used and hence, the need arises for another load balancer to be installed on the cluster.

9. Another pause for 20s after the installation of the load balancer.

10. `summary.sh` is run to generate the summary after testing the CI job using k6. It then saves the summary to a file called `response.txt`

11. With the use of the github action `thollander/actions-comment-pull-request@v2` the pull requested is commented.
The content of the comment is the read from the file saved in point 10.