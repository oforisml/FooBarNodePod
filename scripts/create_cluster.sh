#!/bin/bash

SCRIPT_DIR=$(pwd)

# ENTERING THE CLUSTER CONFIG DIRECTORY
cd ../k8s/config/


# CREATING THE CLUSTER USING THE CONFIGURATION
kind create cluster --name mycluster --config myCluster.yaml


# MOVING BACK TO THE SCRIPT DIRECTORY
cd "${SCRIPT_DIR}"

