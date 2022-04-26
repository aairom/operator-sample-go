# Kubernetes Operator Patterns and Best Practises

This project contains Kubernetes operator samples that demonstrate best practices how to develop operators with [Golang](https://go.dev/), [Operator SDK](https://sdk.operatorframework.io/) including [Kubebuilder](https://github.com/kubernetes-sigs/kubebuilder) and the [Operator Lifecycle Manager Framework](https://operatorframework.io/).

Therefor the project includes two example application implementations, which will deployed and operated by the different examples for operator implementations.

* [Simple microservice application](simple-microservice/README.md)
* [Simple database implementation](database-service/README.md)

### Setup

The repo contains four operators:

1) [Application operator](operator-application/README.md): Deploys and manages a simple microservice application.
2) [Database operator](operator-database/README.md): Deploys and manages a simple database. Used by the application.
3) [operator-application-scaler](operator-application-scaler/README.md): **TBD**
4) [operator-database-backup](operator-database-backup/README.md): **TBD**




The easiest way to get started is to run the application operator which uses prebuilt images of the database controller, the microservice and all other required components.

There are three ways to run the application operator:

1) [Local Go Operator](documentation/SetupLocal.md) 
2) [Kubernetes Operator manually deployed](documentation/SetupManualDeployment.md)
3) [Kubernetes Operator deployed via OLM](documentation/SetupDeploymentViaOLM.md)
    * via operator-sdk
    * via kubectl

### Documentation

*Overview and Scenarios*

* [Why you should build Kubernetes Operators](http://heidloff.net/article/why-you-should-build-kubernetes-operators/)
* [Day 2 Scenario: Automatically Archiving Data](http://heidloff.net/article/automatically-archiving-data-kubernetes-operators/)
* [Day 2 Scenario: Automatically Scaling Applications](http://heidloff.net/article/scaling-applications-automatically-operators/)
* [The Kubernetes Operator Metamodel](http://heidloff.net/article/the-kubernetes-operator-metamodel/)

*Basic Capabilities*

* [Creating and updating Resources](http://heidloff.net/article/updating-resources-kubernetes-operators/)
* [Deleting Resources](http://heidloff.net/article/deleting-resources-kubernetes-operators/)
* [Storing State of Resources with Conditions](http://heidloff.net/article/storing-state-status-kubernetes-resources-conditions-operators-go/)
* [Finding out the Kubernetes Versions and Capabilities](http://heidloff.net/article/finding-kubernetes-version-capabilities-operators/)
* [Configuring Webhooks](http://heidloff.net/article/configuring-webhooks-kubernetes-operators/)
* [Initialization and Validation Webhooks](http://heidloff.net/article/developing-initialization-validation-webhooks-kubernetes-operators/)
* [Converting Custom Resource Versions](http://heidloff.net/article/converting-custom-resource-versions-kubernetes-operators/)
* [Defining Dependencies](http://heidloff.net/article/defining-dependencies-kubernetes-operators/)

*Advanced Capabilities*

* [Exporting Metrics from Kubernetes Apps for Prometheus](http://heidloff.net/article/exporting-metrics-kubernetes-applications-prometheus/)
* [Accessing Kubernetes from Go Applications](http://heidloff.net/article/accessing-kubernetes-from-go-applications/)
* [How to build your own Database on Kubernetes](http://heidloff.net/article/how-to-build-your-own-database-on-kubernetes/)
* [Building Databases on Kubernetes with Quarkus](http://heidloff.net/quarkus/building-databases-kubernetes-quarkus/)

*Development and Deployment*

* [Manually deploying Operators to Kubernetes](http://heidloff.net/article/manually-deploying-operators-to-kubernetes/)
* [Deploying Operators with the Operator Lifecycle Manager](http://heidloff.net/article/deploying-operators-operator-lifecycle-manager-olm/)

*Golang*

* [Importing Go Modules in Operators](http://heidloff.net/article/importing-go-modules-kubernetes-operators/)
* [Accessing third Party Custom Resources in Go Operators](http://heidloff.net/article/accessing-third-party-custom-resources-go-operators/)
* [Using object-oriented Concepts in Golang based Operators](http://heidloff.net/article/object-oriented-concepts-golang/)



To start developing operators, we recommend to get familiar with the [Kubernetes Operator Metamodel](http://heidloff.net/article/the-kubernetes-operator-metamodel/) first.

<img src="documentation/OperatorMetamodel.png" />

### Resources

* [Operator SDK Documentation](https://sdk.operatorframework.io/docs/overview/)
* [Kubebuilder Book](https://book.kubebuilder.io/)
* [Operator Framework (OLM) Documentation](https://olm.operatorframework.io/docs/)
* [Kubernetes API Conventions](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md)