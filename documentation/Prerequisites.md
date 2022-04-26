# Prerequisites

### 1. Required CLIs

1. [operator-sdk](https://sdk.operatorframework.io/docs/installation/) (comes with Golang)
2. git
3. kubectl
4. podman
5. Only if IBM Cloud is used: [ibmcloud](https://cloud.ibm.com/docs/cli?topic=cli-install-ibmcloud-cli)

### 1.1. Operator SDK

🔴 IMPORTANT: The repo has been tested with operator-sdk v1.18.1. Note that there is an issue with this version. It doesn't download the tools in the 'bin' directory. You need to use the older version v1.18.0 first, init a new temporary new project and copy the downloaded four files from the 'bin' directoy into the 'bin' subdirectories of both operators. After this update to v1.18.1.

### 2. Repo

```
$ git clone https://github.com/nheidloff/operator-sample-go.git
$ cd operator-sample-go
$ code .
```

### 3. Kubernetes Cluster

Any newer Kubernetes cluster should work. The Operator SDK version v1.18.1 has been [tested](https://github.com/kubernetes/client-go#versioning) with Kubernetes v1.23. You can also use OpenShift. We have mostly tested the two operators with IBM Cloud Kubernetes Service and IBM Red Hat OpenShift on IBM Cloud.

Log in to Kubernetes or OpenShift, for example:

```
$ ibmcloud login -a cloud.ibm.com -r eu-de -g resource-group-niklas-heidloff7 --sso
$ ibmcloud ks cluster config --cluster xxxxxxx
$ kubectl get all
```

```
$ oc login --token=sha256~xxxxx --server=https://c106-e.us-south.containers.cloud.ibm.com:32335
$ kubectl get all
```

### 4. Required Kubernetes Components

#### 4.1 OpenShift

* [Certificate manager](https://cert-manager.io/) need to be installed

#### 4.2 Kubernetes

* [Cert-Manager](https://cert-manager.io/)
* OLM (Operator Lifecycle Manager)
* Prometheus operator
* Prometheus instance

```sh
sh scripts/install-required-kubernetes-components.sh
```

### 5. Image Registry

Replace REGISTRY and ORG with your registry account. When creating new image versions later, change the versions in versions.env. 

```
$ export REGISTRY='docker.io'
$ export ORG='nheidloff'
$ podman login $REGISTRY
$ source versions.env
```
