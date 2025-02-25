# Setup and Deployment via Operator Lifecycle Manager

Follow the same steps described in [Setup and manual Deployment](SetupManualDeployment.md) up to the step 'Deploy Operator'.

### Navigate to operator-application

```sh
cd operator-application
```

### Build and push the bundle image

#### Step 1: Set the environment variables

```sh
source ../versions.env
```

#### Step 2: Create a bundle using the operator SDK

```sh
make bundle IMG="$REGISTRY/$ORG/$IMAGE_APPLICATION_OPERATOR"
```

#### Step 3: Create a bundle container image using the operator SDK

```sh
podman build -f bundle.Dockerfile -t "$REGISTRY/$ORG/$IMAGE_APPLICATION_OPERATOR_BUNDLE" .
```

#### Step 4: Push the container image a container registry

```sh
podman push "$REGISTRY/$ORG/$IMAGE_APPLICATION_OPERATOR_BUNDLE"
```

### Deploy the operator

There are two ways to deploy the operator:

#### 1. Deploy via operator-sdk

```sh
operator-sdk run bundle "$REGISTRY/$ORG/$IMAGE_APPLICATION_OPERATOR_BUNDLE" -n operators
```

* Example output:

```sh
...
```

_Note:_ In case you have problem use following commands to clean the installation.

```sh
operator-sdk cleanup operator-application -n operators --delete-all
```

Find the installplans

```sh
kubectl get installplans -n operators | grep operator-application
```

Delete the installplans

```sh
kubectl delete installplan install-76xlj -n operators 
```

### Create database resource

* Create a namespace for the `Database Operator`

```sh
kubectl create namespace database
```

* Create the `Custom Resource Definition` for the `Database Operator`

```sh
kubectl apply -f ../operator-database/config/crd/bases/database.sample.third.party_databases.yaml
```


#### 2. Deploy via kubectl

Build and push the catalog image:

```
$ ./bin/opm index add --build-tool podman --mode semver --tag "$REGISTRY/$ORG/$IMAGE_APPLICATION_OPERATOR_CATALOG" --bundles "$REGISTRY/$ORG/$IMAGE_APPLICATION_OPERATOR_BUNDLE"
$ podman push "$REGISTRY/$ORG/$IMAGE_APPLICATION_OPERATOR_CATALOG"
```

Define "$REGISTRY/$ORG/$IMAGE_APPLICATION_OPERATOR_CATALOG" in olm/catalogsource.yaml and invoke these commands.

```
$ kubectl apply -f olm/catalogsource.yaml
$ kubectl apply -f olm/subscription.yaml 
$ kubectl get installplans -n operators
```

If the install plan requires manual approval, use this command:

```
$ kubectl -n operators patch installplan install-xxxxx -p '{"spec":{"approved":true}}' --type merge
```

### Verify the setup

In both cases the setup can be verified via these commands:

```
$ kubectl get all -n operators
$ kubectl get catalogsource operator-application-catalog -n operators -oyaml
$ kubectl get subscriptions operator-application-v0-0-1-sub -n operators -oyaml
$ kubectl get csv operator-application.v0.0.1 -n operators -oyaml
$ kubectl get installplans -n operators
$ kubectl get installplans install-xxxxx -n operators -oyaml
$ kubectl get operators operator-application.operators -n operators -oyaml
```

In both cases an application resource can be created via this command: 

```
$ kubectl apply -f config/samples/application.sample_v1beta1_application.yaml
$ kubectl get applications.application.sample.ibm.com/application -n application-beta -oyaml
$ kubectl exec -n application-beta $(kubectl get pods -n application-beta | awk '/application-deployment-microservice/ {print $1;exit}') --container application-microservice -- curl http://localhost:8081/hello
$ kubectl logs -n operators $(kubectl get pods -n operators | awk '/operator-application-controller-manager/ {print $1;exit}') -c manager
```

### Delete all resources

**1. Delete all resources (operator-sdk):**

```
$ kubectl delete -f config/samples/application.sample_v1beta1_application.yaml
$ operator-sdk cleanup operator-application -n operators --delete-all
$ kubectl apply -f ../operator-database/config/crd/bases/database.sample.third.party_databases.yaml
$ operator-sdk olm uninstall
```

**2. Delete all resources (kubectl):**

```
$ kubectl delete -f config/samples/application.sample_v1beta1_application.yaml
$ kubectl delete -f olm/subscription.yaml
$ kubectl delete -f olm/catalogsource.yaml
$ operator-sdk olm uninstall
```