---
prev:
  text: '🐳 Docker: Orchestration'
  link: '/DEVOPS/Docker2'
next:
  text: '📋 Summary & Roadmap'
  link: '/CONCLUSION'
---

# 📘 KUBERNETES: CONTAINER ORCHESTRATION SYSTEM

## 🎯 General Objectives

- Understand the operating principles and architecture of Kubernetes.
- Master Kubernetes installation and configuration.
- Know how to deploy and manage containerized applications on Kubernetes.
- Understand the basic components of Kubernetes.
- Deploy highly available and scalable applications.

## 🧑‍🏫 Lesson 1: Introduction to Kubernetes

### What is Kubernetes?

- Kubernetes (K8s) is an open-source platform for automating the deployment, scaling, and management of containerized applications.
- Developed by Google, based on their experience with the Borg system.
- Currently maintained by the Cloud Native Computing Foundation (CNCF).

### Development History

- 2014: Google announced Kubernetes as an open-source project.
- 2015: Kubernetes v1.0 was released, CNCF was founded.
- 2016-present: Kubernetes has become the de-facto standard for container orchestration.

### Benefits of Kubernetes

1. **Automated Deployment**: Deploy applications reliably and consistently.
2. **Self-healing**: Automatically restarts containers that fail.
3. **Automatic Scaling**: Automatically scales the number of containers up or down based on load.
4. **Load Balancing**: Distributes network traffic to ensure stable deployments.
5. **Service Discovery**: Containers can find each other via internal DNS.

### Alternatives to Kubernetes

- Docker Swarm: Simpler, tightly integrated with Docker.
- Apache Mesos: Focuses on running diverse workloads (not just containers).
- Amazon ECS: AWS's container management service.
- Nomad: From HashiCorp, simpler and lighter.

### Common Use Cases

- Microservices: Managing complex applications with many small components.
- CI/CD: Continuous deployment with zero-downtime.
- DevOps: Supporting automated DevOps workflows.
- Big Data: Processing large data with scalability.
- Hybrid Cloud: Running workloads across various cloud environments.

## 🧑‍🏫 Lesson 2: Kubernetes Architecture

### Architecture Overview

```text
+-------------------------------------------------------+
|                  Kubernetes Cluster                   |
|                                                       |
|  +--------------------+       +--------------------+  |
|  |                    |       |                    |  |
|  |   Control Plane    |       |    Worker Nodes    |  |
|  |                    |       |                    |  |
|  |  +--------------+  |       |  +--------------+  |  |
|  |  | API Server   |  |       |  | Kubelet      |  |  |
|  |  +--------------+  |       |  +--------------+  |  |
|  |                    |       |                    |  |
|  |  +--------------+  |       |  +--------------+  |  |
|  |  | Scheduler    |  |       |  | Kube-proxy   |  |  |
|  |  +--------------+  |       |  +--------------+  |  |
|  |                    |       |                    |  |
|  |  +--------------+  |       |  +--------------+  |  |
|  |  | Controller   |  |       |  | Container    |  |  |
|  |  | Manager      |  |       |  | Runtime      |  |  |
|  |  +--------------+  |       |  +--------------+  |  |
|  |                    |       |                    |  |
|  |  +--------------+  |       |                    |  |
|  |  | etcd         |  |       |                    |  |
|  |  +--------------+  |       |                    |  |
|  +--------------------+       +--------------------+  |
+-------------------------------------------------------+
```

### Control Plane Components

1. **API Server (kube-apiserver)**:

   - HTTP API endpoint for interacting with Kubernetes.
   - The main gateway for controlling the cluster.
   - Authenticates and authorizes all requests.

2. **Scheduler (kube-scheduler)**:

   - Watches for newly created pods with no assigned node.
   - Selects a suitable node for them to run on.
   - Considers resources, constraints, affinity, anti-affinity, etc.

3. **Controller Manager (kube-controller-manager)**:

   - Runs controller processes.
   - Controls the state of the cluster.
   - Contains various controllers: Node Controller, Replication Controller, Endpoint Controller, etc.

4. **etcd**:
   - Distributed key-value store.
   - Stores all cluster data.
   - Ensures consistency and high availability.

### Node Components

1. **Kubelet**:

   - An agent that runs on each node.
   - Ensures containers are running in a pod.
   - Reports node status to the control plane.

2. **Kube-proxy**:

   - Maintains network rules on nodes.
   - Allows network communication to pods from inside or outside the cluster.
   - Performs load balancing for services.

3. **Container Runtime**:
   - Software responsible for running containers.
   - Examples: Docker, containerd, CRI-O.

### Important Add-ons

- **CoreDNS**: Provides DNS for the cluster.
- **Dashboard**: UI for Kubernetes management.
- **Ingress Controller**: Manages external traffic to services.
- **CNI (Container Network Interface)**: Plugin for networking between pods.

### Operation Model

- When a request is made (e.g., deploy an app), the client sends a request to the API Server.
- API Server authenticates and processes the request, saves the state to etcd.
- Controllers detect state changes and perform actions.
- Scheduler decides which node the pod will run on.
- Kubelet on the node receives the info and creates the pod.
- Kube-proxy configures networking for the pod.

## 🧑‍🏫 Lesson 3: Installing and Configuring Kubernetes

### Installation Methods

1. **Minikube**: For development environments, runs Kubernetes locally.
2. **kubeadm**: Official tool for bootstrapping Kubernetes clusters.
3. **kind (Kubernetes IN Docker)**: Runs Kubernetes clusters using Docker containers nodes.
4. **Managed Services**: EKS (AWS), GKE (Google), AKS (Azure).

### Installing Minikube for Development

```bash
# Install Minikube on Linux
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

# Start the cluster
minikube start

# Check status
minikube status
```

### Installing kubectl - CLI tool for Kubernetes

```bash
# Linux
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Check version
kubectl version --client
```

### Installing a cluster with kubeadm

```bash
# 1. Install container runtime (e.g., Docker)
# 2. Install kubeadm, kubelet, and kubectl
apt-get update
apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt-get update
apt-get install -y kubelet kubeadm kubectl

# 3. Initialize control plane
kubeadm init --pod-network-cidr=10.244.0.0/16

# 4. Configure kubectl for user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 5. Install network plugin (e.g., Calico)
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# 6. Join worker nodes
# Use the command output from kubeadm init
kubeadm join <control-plane-ip>:<port> --token <token> --discovery-token-ca-cert-hash <hash>
```

### Verifying Installation

```bash
# Check node status
kubectl get nodes

# Check pods in kube-system namespace
kubectl get pods -n kube-system

# Check server and client version
kubectl version
```

### Configuring Kubernetes

1. **Contexts and Clusters**:

   ```bash
   # List contexts
   kubectl config get-contexts

   # Switch context
   kubectl config use-context my-cluster

   # View current config
   kubectl config view
   ```

2. **Important Config Files**:

   - `/etc/kubernetes/`: Contains cluster configuration.
   - `~/.kube/config`: kubectl configuration.
   - `/etc/systemd/system/kubelet.service.d/`: Kubelet configuration.

3. **Roles and RBAC (Role-Based Access Control)**:

   ```bash
   # Create Role
   kubectl create role pod-reader --verb=get,list,watch --resource=pods

   # Create RoleBinding
   kubectl create rolebinding read-pods --role=pod-reader --user=jane

   # Check permissions
   kubectl auth can-i list pods --as jane
   ```

4. **Namespaces**:

```bash
# Create namespace
kubectl create namespace my-namespace

# List namespaces
kubectl get namespaces

# Execute command in specific namespace
kubectl get pods -n my-namespace
```

## 🧑‍🏫 Lesson 4: Kubernetes Objects and Workloads

### What are Kubernetes Objects?

- Persistent entities in the Kubernetes system.
- Represent the state of the cluster.
- Described using YAML or JSON files.

### Common Objects

1. **Pods**: The smallest deployable units in Kubernetes.
2. **ReplicaSets**: Maintain a stable set of replica Pods.
3. **Deployments**: Manage ReplicaSets, support updates and rollbacks.
4. **Services**: Define how to access Pods.
5. **ConfigMaps** and Secrets: Configuration and sensitive data.
6. **Volumes**: Storage for Pods.
7. **Namespaces**: Divide cluster resources between multiple users.

### Pod

- A group of one or more containers sharing storage and network.
- Common "sidecar" pattern: main container + helper container.

```yaml
# pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:1.19
      ports:
        - containerPort: 80
    - name: log-sidecar
      image: busybox
      command: ["sh", "-c", "tail -f /var/log/nginx/access.log"]
      volumeMounts:
        - name: logs-volume
          mountPath: /var/log/nginx
  volumes:
    - name: logs-volume
      emptyDir: {}
```

### Deployment

- Higher level than Pod and ReplicaSet.
- Manages deployment and updates of applications.
- Supports rollouts and rollbacks.

```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.19
          ports:
            - containerPort: 80
```

### Service

- Provides a stable endpoint to access Pods.
- Load balances between multiple Pods.

```yaml
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
  type: ClusterIP
```

### DaemonSet

- Ensures that all (or some) Nodes run a copy of a Pod.
- Typically used for logging, monitoring, storage daemons.

```yaml
# daemonset.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: prometheus-node-exporter
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      containers:
        - name: node-exporter
          image: prom/node-exporter
          ports:
            - containerPort: 9100
```

### StatefulSet

- Manages stateful applications.
- Maintains a sticky identity for each of their Pods.
- Suitable for databases and stateful applications.

```yaml
# statefulset.yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mongodb
spec:
  serviceName: "mongodb"
  replicas: 3
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
        - name: mongodb
          image: mongo:4.4
          ports:
            - containerPort: 27017
          volumeMounts:
            - name: data
              mountPath: /data/db
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 1Gi
```

### Job and CronJob

- Job: Runs a Pod until completion.
- CronJob: Creates Jobs on a repeating schedule.

```yaml
# cronjob.yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: backup-database
spec:
  schedule: "0 1 * * *" # Every day at 1 AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: backup
              image: mybackup:1.0
              command: ["/bin/sh", "-c", "backup.sh"]
          restartPolicy: OnFailure
```

### Managing Kubernetes Objects

```bash
# Create from YAML file
kubectl apply -f deployment.yaml

# Update image
kubectl set image deployment/nginx-deployment nginx=nginx:1.20

# Rollback
kubectl rollout undo deployment/nginx-deployment

# Scale
kubectl scale deployment/nginx-deployment --replicas=5

# Delete
kubectl delete deployment nginx-deployment
```

## 🧑‍🏫 Lesson 5: Networking in Kubernetes

### Kubernetes Networking Model

- Flat network: Pods communicate with each other without NAT.
- Each Pod has a unique IP.
- Containers in a Pod share the same IP.

### Networking Components

1. **Pod Network**: Communication between pods.
2. **Service Network**: Access to pods via services.
3. **Cluster DNS**: Service discovery.
4. **Ingress**: Routing HTTP/HTTPS traffic from outside to the cluster.

### Network Plugins (CNI)

- Calico: High performance, supports network policy.
- Flannel: Simple, easy to setup.
- Weave Net: Easy to use, encrypted.
- Cilium: Based on eBPF, high performance.

### Service Types

1. **ClusterIP**: (default)
   - Internal IP within the cluster.
   - Only accessible from within the cluster.

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: backend-service
   spec:
     selector:
       app: backend
     ports:
       - port: 80
         targetPort: 8080
     type: ClusterIP
   ```

2. **NodePort**:
   - Opens a specific port on all nodes.
   - Accessible externally via `<NodeIP>:<NodePort>`.

     ```yaml
     apiVersion: v1
     kind: Service
     metadata:
       name: web-service
     spec:
       selector:
         app: web
       ports:
         - port: 80
           targetPort: 8080
           nodePort: 30080 # Port 30000-32767
       type: NodePort
     ```

3. **LoadBalancer**:
   - Uses the cloud provider's load balancer.
   - Provides a public IP.

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: web-service
   spec:
     selector:
       app: web
     ports:
       - port: 80
         targetPort: 8080
     type: LoadBalancer
   ```

4. **ExternalName**:
   - Maps the service to a DNS name.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: external-db
spec:
  type: ExternalName
  externalName: database.example.com
```

### Ingress

- Layer 7 (HTTP) load balancer.
- Routes traffic based on URL path or hostname.
- Requires an Ingress Controller (nginx, traefik, ...).

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
spec:
  rules:
    - host: app.example.com
      http:
        paths:
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: api-service
                port:
                  number: 80
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web-service
                port:
                  number: 80
```

### Network Policies

- Control traffic flow between Pods.
- Similar to firewall rules.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-policy
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              role: backend
      ports:
        - protocol: TCP
          port: 5432
```

### Debugging Network Issues

```bash
# Check service
kubectl get svc my-service

# Debug DNS
kubectl run -i --tty --rm debug --image=busybox -- sh
# Inside debug container
nslookup my-service

# Check endpoints
kubectl get endpoints my-service

# View network policies
kubectl get networkpolicies
```

## 🧑‍🏫 Lesson 6: Storage and Persistence

### Persistent Storage in Kubernetes

- Data persists independently of the Pod lifecycle.
- Kubernetes abstraction for managing storage.

### Volumes

- Storage attached to a Pod.
- Exists as long as the Pod exists.

### Common Volume Types

1. **emptyDir**: Temporary directory, deleted when Pod is removed.
2. **hostPath**: Uses a path on the Node.
3. **PersistentVolume (PV)**: Storage independent of the Pod.
4. **ConfigMap/Secret as Volume**: Mount configuration/secrets.

#### emptyDir

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: cache-pod
spec:
  containers:
    - name: app
      image: nginx
      volumeMounts:
        - name: cache-volume
          mountPath: /cache
  volumes:
    - name: cache-volume
      emptyDir: {}
```

#### hostPath

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: log-pod
spec:
  containers:
    - name: app
      image: nginx
      volumeMounts:
        - name: log-volume
          mountPath: /var/log/nginx
  volumes:
    - name: log-volume
      hostPath:
        path: /var/log/pods
        type: DirectoryOrCreate
```

### Persistent Storage Architecture

1. **PersistentVolume (PV)**: Actual storage resource.
2. **PersistentVolumeClaim (PVC)**: Request for storage.
3. **StorageClass**: Defines storage type and provisioner.

#### PersistentVolume (PV)

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-storage
spec:
  capacity:
    storage: 10Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: standard
  hostPath:
    path: /data/pv0001
```

#### PersistentVolumeClaim (PVC)

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-storage-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: standard
```

#### Using PVC in a Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: db-pod
spec:
  containers:
    - name: db
      image: postgres:13
      volumeMounts:
        - name: db-data
          mountPath: /var/lib/postgresql/data
  volumes:
    - name: db-data
      persistentVolumeClaim:
        claimName: db-storage-claim
```

#### StorageClass

- Provides dynamic storage provisioning.
- Integrates with cloud providers.

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  fsType: ext4
reclaimPolicy: Delete
allowVolumeExpansion: true
```

#### Volume Snapshots

- Back up data from PVC.
- Restore from snapshot.

```yaml
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshot
metadata:
  name: db-snapshot
spec:
  volumeSnapshotClassName: csi-hostpath-snapclass
  source:
    persistentVolumeClaimName: db-storage-claim
```

#### StatefulSet with Storage

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
spec:
  serviceName: "postgres"
  replicas: 3
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:13
          volumeMounts:
            - name: data
              mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes: ["ReadWriteOnce"]
        storageClassName: "standard"
        resources:
          requests:
            storage: 10Gi
```

### Best Practices

1. Use PVs and PVCs instead of direct volumes.
2. Define appropriate StorageClass for each workload type.
3. Configure backup and disaster recovery.
4. Use StatefulSets with volumeClaimTemplates for stateful apps.
5. Monitor storage capacity and performance.

## 🧑‍🏫 Lesson 7: ConfigMaps and Secrets

### ConfigMaps

- Stores configuration data as key-value pairs.
- Decouples configuration artifacts from image content.

### Create ConfigMap

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  database.host: "mysql"
  database.port: "3306"
  ui.theme: "dark"
  config.json: |
    {
      "log_level": "info",
      "debug": false,
      "features": {
        "billing": true,
        "notifications": false
      }
    }
```

### Using ConfigMap

1. **Environment variables**:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: web
   spec:
     containers:
       - name: web
         image: nginx
         env:
           - name: DB_HOST
             valueFrom:
               configMapKeyRef:
                 name: app-config
                 key: database.host
           - name: DB_PORT
             valueFrom:
               configMapKeyRef:
                 name: app-config
                 key: database.port
   ```

2. **envFrom - all keys as environment variables**:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: web
   spec:
     containers:
       - name: web
         image: nginx
         envFrom:
           - configMapRef:
               name: app-config
   ```

3. **Volume mount**:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: web
   spec:
     containers:
       - name: web
         image: nginx
         volumeMounts:
           - name: config-volume
             mountPath: /etc/config
     volumes:
       - name: config-volume
         configMap:
           name: app-config
   ```

### Secrets

- Stores sensitive information (passwords, tokens, keys).
- Similar to ConfigMap but safer.
- Base64 encoded (not strong encryption).

### Create Secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
data:
  # Values must be base64 encoded
  username: YWRtaW4= # admin
  password: c2VjcmV0 # secret
```

### Create Secret from command line

```bash
# From file
kubectl create secret generic ssl-cert --from-file=cert.pem --from-file=key.pem

# From literal
kubectl create secret generic api-keys --from-literal=api_key=123456 --from-literal=secret_key=abcdef
```

### Using Secret

1. **Environment variables**:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: db-client
   spec:
     containers:
       - name: app
         image: myapp
         env:
           - name: DB_USERNAME
             valueFrom:
               secretKeyRef:
                 name: db-credentials
                 key: username
           - name: DB_PASSWORD
             valueFrom:
               secretKeyRef:
                 name: db-credentials
                 key: password
   ```

2. **Volume mount:**

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: db-client
   spec:
     containers:
       - name: app
         image: myapp
         volumeMounts:
           - name: secret-volume
             mountPath: /etc/secrets
             readOnly: true
     volumes:
       - name: secret-volume
         secret:
           secretName: db-credentials
   ```

### Secret Types

- Opaque: Default, arbitrary data.
- kubernetes.io/service-account-token: Service account token.
- kubernetes.io/dockerconfigjson: Docker registry auth.
- kubernetes.io/tls: TLS certificates.

### Docker Registry Secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: docker-registry-cred
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: <base64-encoded-docker-config>
```

### Using Docker Registry Secret

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: private-app
spec:
  containers:
    - name: app
      image: myprivate/repo:tag
  imagePullSecrets:
    - name: docker-registry-cred
```

### Best Practices (Secrets Security)

1. Do not store Secrets in git repositories.
2. Restrict access to Secrets using RBAC.
3. Use external solutions like Vault for secret management.
4. Set network policies for Pods using Secrets.
5. Encrypt etcd to protect stored Secrets.

## 🧑‍🏫 Lesson 8: Helm - Package Manager for Kubernetes

### What is Helm?

- Package manager for Kubernetes.
- Helps define, install, and upgrade complex Kubernetes applications.
- Similar to npm, pip, or apt but for Kubernetes.

### Basic Helm Concepts

1. **Chart**: A Helm package, contains all resource definitions.
2. **Repository**: Place where charts are collected and shared.
3. **Release**: An instance of a chart running in a Kubernetes cluster.

### Installing Helm

```bash
# Linux
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# macOS
brew install helm

# Windows
choco install kubernetes-helm
```

### Structure of a Helm Chart

```text
mychart/
  Chart.yaml          # Information about the chart
  values.yaml         # Default configuration values
  templates/          # Directory of templates
    deployment.yaml
    service.yaml
    ingress.yaml
    _helpers.tpl      # Partial templates
  charts/             # Chart dependencies
  templates/NOTES.txt # Notes displayed after installation
```

#### Chart.yaml

```yaml
apiVersion: v2
name: myapp
version: 1.0.0
description: My Application Helm Chart
type: application
appVersion: "1.0.0"
dependencies:
  - name: mysql
    version: 8.8.5
    repository: https://charts.bitnami.com/bitnami
```

#### values.yaml

```yaml
# Default values
replicaCount: 2

image:
  repository: nginx
  tag: 1.19.0
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: false
  hosts:
    - host: chart-example.local
      paths: ["/"]
```

#### Template file (deployment.yaml)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: { { include "myapp.fullname" . } }
  labels: { { - include "myapp.labels" . | nindent 4 } }
spec:
  replicas: { { .Values.replicaCount } }
  selector:
    matchLabels: { { - include "myapp.selectorLabels" . | nindent 6 } }
  template:
    metadata:
      labels: { { - include "myapp.selectorLabels" . | nindent 8 } }
    spec:
      containers:
        - name: { { .Chart.Name } }
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: { { .Values.image.pullPolicy } }
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
```

### Helm Commands

```bash
# Search charts
helm search hub wordpress

# Add repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Install chart
helm install my-release bitnami/wordpress

# List releases
helm list

# Check status
helm status my-release

# Upgrade release
helm upgrade my-release bitnami/wordpress --values=custom-values.yaml

# Rollback
helm rollback my-release 1

# Uninstall
helm uninstall my-release
```

#### Create new Helm Chart

```bash
# Create new chart
helm create mychart

# Lint chart
helm lint mychart

# Package chart
helm package mychart

# Install local chart
helm install my-app ./mychart

# Install with custom values
helm install my-app ./mychart -f my-values.yaml
```

#### Helm Template Functions

```yaml
# Quote
app: {{ .Values.appName | quote }}

# Default
replicas: {{ .Values.replicas | default 1 }}

# Indent
data:
  {{- .Values.configuration | nindent 2 }}

# toYaml
labels:
  {{- toYaml .Values.labels | nindent 4 }}

# if/else
{{- if .Values.ingress.enabled }}
# ingress configuration
{{- end }}
```

### Chart Hooks

- `pre-install`, `post-install`
- `pre-delete`, `post-delete`
- `pre-upgrade`, `post-upgrade`
- `pre-rollback`, `post-rollback`
- `test`

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "mychart.fullname" . }}-db-init
  annotations:
    "helm.sh/hook": post-install
    "helm.sh/hook-weight": "0"
    "helm.sh/hook-delete-policy": hook-succeeded
spec:
  template:
    spec:
      containers:
      - name: db-init
        image: postgres
        command: ["psql", "--command", "CREATE DATABASE app"]
      restartPolicy: Never
```

### Best Practices (Helm Tips)

1. Use Helm repo to manage charts.
2. Split values.yaml into logical components.
3. Experiment with templates in values.yaml.
4. Use helpers to reuse code.
5. Add NOTES.txt to guide users.

## 🧪 FINAL PROJECT: Building and Deploying a Microservices App on Kubernetes

### Project Description

Build a complete microservices system and deploy it on a Kubernetes cluster, with the following components:

- Frontend SPA (Single Page Application).
- API Gateway.
- 2-3 Backend Microservices.
- Database (SQL or NoSQL).
- Authentication/Authorization system.

### Requirements

1. Build Docker images for each microservice.
2. Create Kubernetes manifests for all components.
3. Configure Services, Ingress to manage traffic.
4. Setup PersistentVolumes for database.
5. Configure ConfigMaps and Secrets.
6. Deploy Prometheus and Grafana for monitoring.
7. Configure Horizontal Pod Autoscaler.
8. Create Helm chart for the entire application.
9. Write scripts for CI/CD pipeline.

### Expected Outcome

- Application runs stably on Kubernetes.
- Detailed deployment documentation and system architecture.
- Automatic scaling capability based on load.
- Complete monitoring and alerting.
- CI/CD pipeline for application updates.