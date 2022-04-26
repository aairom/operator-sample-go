# Setup and local Usage

First install [prerequistes](Prerequisites.md)!

### Basic simplified architecture overview

![](./images/simplified-architecture-02.png)

### Navigate to operator-application

```sh
cd operator-application
```

### Create database resource

```sh
kubectl create namespace database
kubectl apply -f ../operator-database/config/crd/bases/database.sample.third.party_databases.yaml
```

### Run operator locally

We will start two terminals:

* From a terminal run this command to run the operator locally:

```sh
make generate
make manifests
make install run ENABLE_WEBHOOKS=false
```

>  🔴 IMPORTANT - Known issue: The repo has been tested with **operator-sdk v1.18.1**. Note that there is an issue with this version. It doesn't download the **tools** in the **'bin'** directory. You need to init a new temporary new project for example `operator-sdk init --domain example.com --repo github.com/example/memcached-operator` and copy the downloaded four files from the 'bin' directoy into both operators directories (Application Operator and the Database Operator).

* From another terminal run this command to deploy a custom resoure inside the Kubernetes cluster:

```sh
kubectl apply -f config/samples/application.sample_v1beta1_application.yaml
```

Debug the operator (without webhooks):

To debug, press F5 (Run - Start Debugging) instead of 'make install run'. The directory 'operator-application' needs to be root in VSCode.

### Verify the setup

* Get the `Custom Resource Definition` for the `Application Operator`

```sh
kubectl get applications.application.sample.ibm.com/application -n application-beta -oyaml
```

```sh
kubectl exec -n application-beta $(kubectl get pods -n application-beta | awk '/application-deployment-microservice/ {print $1;exit}') --container application-microservice -- curl -s http://localhost:8081/hello
```

### Delete all resources

```
$ kubectl delete -f config/samples/application.sample_v1beta1_application.yaml
$ make uninstall
```