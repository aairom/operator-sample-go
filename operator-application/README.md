# Application Operator

See project [readme](../README.md).

### Basic overview of the Application Operator

The current Application Operator implementation includes following features:

* Webhook to update older API versions of the operator
* [Monitoring and metrics](./controllers/application/monitor.go)
* [Verify Kubernetes versions](./controllers/application/prerequisites.go) 
* Deploys the [simple microservice](../simple-microservice/) application with related Kubernetes objects to access the application from the internet
* Delete the [simple microservice](../simple-microservice/) application with related Kubernetes objects to access the `simple microservice` from the internet
* Verifies if the custom resource definition of the [Database Operator](../operator-database/README.md) exists

### Simplified architecture overview 

#### 1. Kubernetes deployment

The following simplifed diagram shows:

* (orange arrows) The local machine invokation of the simple mircoservice endpoint and the needed custom resources files to create an instance of the `simple mircoservice` application by the `Application Operator`.

* (blue and dark blue) The simplified usage of the Kubernetes service on IBM Cloud

* (black arrows) The `namespaces`, `pods`with their main depencencies

* (purple arrows)  `container registry` container images with their main depencencies

> KEEP IN MIND: The`simple microservice` application will only becreated, if you deploy a `custom resource` of the `Application Operator` (you find an example `yaml` [here](./config/samples/application.sample_v1beta1_application.yaml)) and you need to deploy the `Custom Resource Definion` of the `Database Operator` (you find [here](../operator-database/config/crd/bases/database.sample.third.party_databases.yaml). Because, the `Application Operator` validates, if there is a `Custom Resource Definion` in a namespace called `database`.

![](../documentation/images/simplified-architecture-01.png)

### Current configurations of the `Application Operator`

The `Application Operator` currently as two different API versions.

* [v1alpha1](operator-application/api/v1alpha1)


```yaml
apiVersion: application.sample.ibm.com/v1alpha1
kind: Application
metadata:
  name: application
  namespace: application-alpha
spec:
  version: "1.0.0"
  amountPods: 1
  databaseName: database
  databaseNamespace: database
```

* [v1beta1](operator-application/api/v1beta1)

The difference to `v1alpha1` is the `title` was added.

```yaml
apiVersion: application.sample.ibm.com/v1beta1
kind: Application
metadata:
  name: application
  namespace: application-beta
spec:
  version: "1.0.0"
  amountPods: 1
  databaseName: database
  databaseNamespace: database
  title: movies
```

> The latest operator implementation uses the [v1beta1](operator-application/api/v1beta1) API.



