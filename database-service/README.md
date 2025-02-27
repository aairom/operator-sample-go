# Database Service

The database-service directory contains a simple database implementation that writes and reads data to and from JSON files. The service can be deployed to Kubernetes via StatefulSets. There is one 'leader' pod and multiple 'follower' pods. Watch the video [Kubernetes StatefulSet simply explained | Deployment vs StatefulSet](https://youtu.be/pPQKAR1pA9U) to understand how this service works.


### Getting started

The easiest way to use this service is to deploy it to Kubernetes by applying the provided yaml which uses an existing image.

```
$ git clone https://github.com/ibm/operator-sample-go.git
$ cd database-service
$ kubectl apply -f kubernetes/
$ kubectl get all -n database
```


### Running the Service locally via Quarkus Dev Mode

You can run some parts locally for development and debugging purposes via Quarkus dev mode. However leader election and data synchronization do not work.

```
$ git clone https://github.com/ibm/operator-sample-go.git
$ cd database-service
$ mvn clean quarkus:dev
$ open http://localhost:8089/q/swagger-ui/
```


### Running the Service locally via Container

You can run some parts locally for testing via containers. However leader election and data synchronization do not work.

```
$ git clone https://github.com/ibm/operator-sample-go.git
$ cd database-service
$ mvn clean install
$ podman build -t database-service:latest .
$ podman run -i --rm -p 8089:8089 database-service:latest
$ open http://localhost:8089/q/swagger-ui/
```


### Testing APIs locally

```
$ curl http://localhost:8089/persons
$ curl -X 'GET' 'http://localhost:8089/persons/e0a08c5b-62d5-4b20-a024-e1c270d901c2'
$ curl -X 'POST' 'http://localhost:8089/api/leader?setAsLeader=true'
$ curl -X 'DELETE' \
  'http://localhost:8089/persons' \
  -H 'Content-Type: application/json' \
  -d '{"id": "e0a08c5b-62d5-4b20-a024-e1c270d901c2"}'
$ curl http://localhost:8089/persons
$ curl -X 'POST' \
  'http://localhost:8089/persons' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "firstName": "Johanna",
  "lastName": "Koester",
  "id": "e956b5d0-fa0c-40e8-9da9-333c214dcaf7"
}'
$ curl http://localhost:8089/persons
$ curl -X 'POST' 'http://localhost:8089/api/leader?setAsLeader=false'
$ curl -X 'GET' 'http://localhost:8089/api/leader'
$ curl -X 'GET' 'http://localhost:8089/api/query'
$ curl -X 'POST' 'http://localhost:8089/api/statement'
$ curl -X 'GET' 'http://localhost:8089/api/metadata'
```

To change the directory of the stored files, set the environment variable 'DATA_DIRECTORY', for example locally via:

```
$ export DATA_DIRECTORY=./temp
$ unset DATA_DIRECTORY
```


### Building new Image Versions

```
$ cd database-service
$ code ../versions.env
$ source ../versions.env
$ podman build -t "$REGISTRY/$ORG/$IMAGE_DATABASE_SERVICE" .
$ podman push "$REGISTRY/$ORG/$IMAGE_DATABASE_SERVICE"
```


### Testing APIs on Kubernetes

database-cluster-0 is leader, database-cluster-1 is follower. You can only write to the leader. After data has been written to the leader, the followers synchronize this data to their volumes.

```
$ kubectl exec -n database database-cluster-1 -- curl -s http://localhost:8089/persons
$ kubectl exec -n database database-cluster-1 -- curl -s http://localhost:8089/api/leader
$ kubectl logs -n database database-cluster-1
$ kubectl exec -n database database-cluster-1 -- curl -s -X 'POST' 'http://localhost:8089/persons' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"firstName": "Johanna","lastName": "Koester","id": "e956b5d0-fa0c-40e8-9da9-333c214dcaf7"}'
$ kubectl exec -n database database-cluster-1 -- curl -s http://localhost:8089/persons
```

```
$ kubectl exec -n database database-cluster-0 -- curl -s http://localhost:8089/persons
$ kubectl exec -n database database-cluster-0 -- curl -s http://localhost:8089/api/leader
$ kubectl logs -n database database-cluster-0
$ kubectl exec -n database database-cluster-0 -- curl -s -X 'POST' 'http://localhost:8089/persons' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"firstName": "Johanna","lastName": "Koester","id": "e956b5d0-fa0c-40e8-9da9-333c214dcaf7"}'
$ kubectl exec -n database database-cluster-0 -- curl -s http://localhost:8089/persons
$ kubectl exec -n database database-cluster-1 -- curl -s http://localhost:8089/persons
```

```
$ kubectl delete pod database-cluster-0 -n database
$ kubectl exec -n database database-cluster-0 -- curl -s http://localhost:8089/persons
```

```
$ kubectl scale statefulsets database-cluster --replicas=3 -n database
$ kubectl exec -n database database-cluster-2 -- curl -s http://localhost:8089/persons
```
