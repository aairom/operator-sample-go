#!/bin/bash

# **************** Global variables

ROOT_FOLDER=$(cd $(dirname $0); cd ..; pwd)

# **********************************************************************************
# Functions
# **********************************************************************************

function installCertManager () {
  kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.2/cert-manager.yaml
  echo "Press any key to move on"
  read input
}

function installOLM () {
    operator-sdk olm install --version v0.20.0
    echo "Press any key to move on"
    read input
}

function installPrometheusOperator () {
    kubectl apply -f $ROOT_FOLDER/prometheus/operator/
    echo "Press any key to move on"
    read input
}

function createPrometheusInstance () {
    kubectl apply -f $ROOT_FOLDER/prometheus/prometheus/
    echo "Press any key to move on"
    read input
}

# **********************************************************************************
# Execution
# **********************************************************************************

installCertManager
installOLM
installPrometheusOperator
createPrometheusInstance 
