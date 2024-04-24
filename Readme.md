# Docker image for troubleshooting
## Contains:
 * ping
 * telnet  
 * curl
 * net-tools
 * dns tools (`nslookup`, `dig`)
 * simple http_server - `http_server`
 * grpcurl - curl for GRPC


## Usage
### Docker
```shell
docker pull szalik/troubleshooting-image
docker run -it -P szalik/troubleshooting-image 
```

### Kubernetes pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: troubleshooting
  labels:
    app: troubleshooting
spec:
  containers:
  - name: shell
    image: szalik/troubleshooting-image
    command: ["sleep", "7200"]
    imagePullPolicy: Always
    ports:
      - containerPort: 8080
        protocol: TCP
```

```shell
kubectl exec -it troubleshooting -- /bin/bash
```

