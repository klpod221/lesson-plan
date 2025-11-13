# 📘 KUBERNETES: HỆ THỐNG ĐIỀU PHỐI CONTAINER

- [📘 KUBERNETES: HỆ THỐNG ĐIỀU PHỐI CONTAINER](#-kubernetes-hệ-thống-điều-phối-container)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu về Kubernetes](#-bài-1-giới-thiệu-về-kubernetes)
    - [Kubernetes là gì?](#kubernetes-là-gì)
    - [Lịch sử phát triển](#lịch-sử-phát-triển)
    - [Lợi ích của Kubernetes](#lợi-ích-của-kubernetes)
    - [Các giải pháp thay thế cho Kubernetes](#các-giải-pháp-thay-thế-cho-kubernetes)
    - [Use cases phổ biến](#use-cases-phổ-biến)
  - [🧑‍🏫 Bài 2: Kiến trúc Kubernetes](#-bài-2-kiến-trúc-kubernetes)
    - [Tổng quan kiến trúc](#tổng-quan-kiến-trúc)
    - [Control Plane Components](#control-plane-components)
    - [Node Components](#node-components)
    - [Các Add-ons quan trọng](#các-add-ons-quan-trọng)
    - [Mô hình hoạt động](#mô-hình-hoạt-động)
  - [🧑‍🏫 Bài 3: Cài đặt và Cấu hình Kubernetes](#-bài-3-cài-đặt-và-cấu-hình-kubernetes)
    - [Các phương pháp cài đặt Kubernetes](#các-phương-pháp-cài-đặt-kubernetes)
    - [Cài đặt Minikube cho môi trường phát triển](#cài-đặt-minikube-cho-môi-trường-phát-triển)
    - [Cài đặt kubectl - công cụ CLI để tương tác với Kubernetes](#cài-đặt-kubectl---công-cụ-cli-để-tương-tác-với-kubernetes)
    - [Cài đặt cluster với kubeadm](#cài-đặt-cluster-với-kubeadm)
    - [Xác nhận cài đặt Kubernetes](#xác-nhận-cài-đặt-kubernetes)
    - [Cấu hình Kubernetes](#cấu-hình-kubernetes)
  - [🧑‍🏫 Bài 4: Kubernetes Objects và Workloads](#-bài-4-kubernetes-objects-và-workloads)
    - [Kubernetes Objects là gì?](#kubernetes-objects-là-gì)
    - [Các Objects phổ biến](#các-objects-phổ-biến)
    - [Pod](#pod)
    - [Deployment](#deployment)
    - [Service](#service)
    - [DaemonSet](#daemonset)
    - [StatefulSet](#statefulset)
    - [Job và CronJob](#job-và-cronjob)
    - [Quản lý Kubernetes Objects](#quản-lý-kubernetes-objects)
  - [🧑‍🏫 Bài 5: Networking trong Kubernetes](#-bài-5-networking-trong-kubernetes)
    - [Mô hình networking của Kubernetes](#mô-hình-networking-của-kubernetes)
    - [Các thành phần networking](#các-thành-phần-networking)
    - [Network Plugins (CNI)](#network-plugins-cni)
    - [Service ()](#service-)
    - [Các loại Services](#các-loại-services)
    - [Ingress](#ingress)
    - [Network Policies](#network-policies)
    - [Debugging Network Issues](#debugging-network-issues)
  - [🧑‍🏫 Bài 6: Storage và Persistence](#-bài-6-storage-và-persistence)
    - [Persistent Storage trong Kubernetes](#persistent-storage-trong-kubernetes)
    - [Volumes](#volumes)
    - [Các loại Volumes phổ biến](#các-loại-volumes-phổ-biến)
      - [emptyDir](#emptydir)
      - [hostPath](#hostpath)
    - [Persistent Storage Architecture](#persistent-storage-architecture)
      - [PersistentVolume (PV)](#persistentvolume-pv)
      - [PersistentVolumeClaim (PVC)](#persistentvolumeclaim-pvc)
      - [Sử dụng PVC trong Pod](#sử-dụng-pvc-trong-pod)
      - [StorageClass](#storageclass)
      - [Volume Snapshots](#volume-snapshots)
      - [StatefulSet với Storage](#statefulset-với-storage)
    - [Best Practices](#best-practices)
  - [🧑‍🏫 Bài 7: ConfigMaps và Secrets](#-bài-7-configmaps-và-secrets)
    - [ConfigMaps](#configmaps)
    - [Tạo ConfigMap](#tạo-configmap)
    - [Sử dụng ConfigMap](#sử-dụng-configmap)
    - [Secrets](#secrets)
    - [Tạo Secret](#tạo-secret)
    - [Tạo Secret từ command line](#tạo-secret-từ-command-line)
    - [Sử dụng Secret](#sử-dụng-secret)
    - [Secret Types](#secret-types)
    - [Docker Registry Secret](#docker-registry-secret)
    - [Sử dụng Docker Registry Secret](#sử-dụng-docker-registry-secret)
    - [Best Practices (Bí quyết bảo mật Secrets)](#best-practices-bí-quyết-bảo-mật-secrets)
  - [🧑‍🏫 Bài 8: Helm - Package Manager cho Kubernetes](#-bài-8-helm---package-manager-cho-kubernetes)
    - [Helm là gì?](#helm-là-gì)
    - [Khái niệm cơ bản của Helm](#khái-niệm-cơ-bản-của-helm)
    - [Cài đặt Helm](#cài-đặt-helm)
    - [Cấu trúc của một Helm Chart](#cấu-trúc-của-một-helm-chart)
      - [Chart.yaml](#chartyaml)
      - [values.yaml](#valuesyaml)
      - [Template file (deployment.yaml)](#template-file-deploymentyaml)
    - [Helm Commands](#helm-commands)
      - [Tạo Helm Chart mới](#tạo-helm-chart-mới)
      - [Helm Template Functions](#helm-template-functions)
    - [Chart Hooks](#chart-hooks)
    - [Best Practices (Bí quyết sử dụng Helm)](#best-practices-bí-quyết-sử-dụng-helm)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng và triển khai ứng dụng microservices trên Kubernetes](#-bài-tập-lớn-cuối-phần-xây-dựng-và-triển-khai-ứng-dụng-microservices-trên-kubernetes)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)
    - [Kết quả đạt được](#kết-quả-đạt-được)

## 🎯 Mục tiêu tổng quát

- Hiểu được nguyên lý hoạt động và kiến trúc của Kubernetes
- Thành thạo việc cài đặt và cấu hình Kubernetes
- Biết cách triển khai và quản lý ứng dụng container trên Kubernetes
- Hiểu được các thành phần cơ bản của Kubernetes
- Triển khai ứng dụng có tính sẵn sàng cao và khả năng mở rộng

---

## 🧑‍🏫 Bài 1: Giới thiệu về Kubernetes

### Kubernetes là gì?

- Kubernetes (K8s) là một nền tảng mã nguồn mở để tự động hóa việc triển khai, mở rộng và quản lý ứng dụng container
- Được phát triển bởi Google, dựa trên kinh nghiệm của họ với hệ thống Borg
- Hiện nay được duy trì bởi Cloud Native Computing Foundation (CNCF)

### Lịch sử phát triển

- 2014: Google công bố Kubernetes như một dự án mã nguồn mở
- 2015: Kubernetes v1.0 được phát hành, CNCF được thành lập
- 2016-nay: Kubernetes trở thành tiêu chuẩn chính cho điều phối container

### Lợi ích của Kubernetes

1. **Tự động hóa triển khai**: Triển khai ứng dụng một cách đáng tin cậy và nhất quán
2. **Self-healing**: Tự động khởi động lại containers khi chúng bị lỗi
3. **Mở rộng tự động**: Tự động mở rộng/thu hẹp số lượng container dựa trên tải
4. **Cân bằng tải**: Phân phối lưu lượng mạng để đảm bảo triển khai ổn định
5. **Service discovery**: Containers có thể tìm nhau thông qua DNS nội bộ

### Các giải pháp thay thế cho Kubernetes

- Docker Swarm: Đơn giản hơn, tích hợp chặt chẽ với Docker
- Apache Mesos: Tập trung vào việc chạy workloads đa dạng (không chỉ containers)
- Amazon ECS: Dịch vụ quản lý container của AWS
- Nomad: Từ HashiCorp, đơn giản và nhẹ hơn

### Use cases phổ biến

- Microservices: Quản lý ứng dụng phức tạp với nhiều thành phần nhỏ
- CI/CD: Triển khai liên tục với zero-downtime
- DevOps: Hỗ trợ quy trình DevOps tự động
- Big Data: Xử lý dữ liệu lớn với khả năng mở rộng
- Hybrid Cloud: Chạy workloads trên nhiều môi trường cloud khác nhau

---

## 🧑‍🏫 Bài 2: Kiến trúc Kubernetes

### Tổng quan kiến trúc

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

   - Điểm cuối HTTP API để tương tác với Kubernetes
   - Cổng chính để kiểm soát cluster
   - Xác thực và phân quyền tất cả các requests

2. **Scheduler (kube-scheduler)**:

   - Quan sát các pods mới chưa được gán node
   - Lựa chọn node phù hợp để chạy pod
   - Cân nhắc tài nguyên, ràng buộc, affinity, anti-affinity...

3. **Controller Manager (kube-controller-manager)**:

   - Chạy các quy trình controller
   - Điều khiển trạng thái của cluster
   - Chứa nhiều loại controllers: Node Controller, Replication Controller, Endpoint Controller,...

4. **etcd**:
   - Cơ sở dữ liệu phân tán key-value
   - Lưu trữ tất cả dữ liệu của cluster
   - Đảm bảo tính nhất quán và sẵn sàng cao

### Node Components

1. **Kubelet**:

   - Agent chạy trên mỗi node
   - Đảm bảo containers chạy trong pod
   - Báo cáo tình trạng node lên control plane

2. **Kube-proxy**:

   - Duy trì network rules trên node
   - Cho phép giao tiếp mạng đến pods từ trong hoặc ngoài cluster
   - Thực hiện chức năng load balancing cho services

3. **Container Runtime**:
   - Phần mềm chịu trách nhiệm chạy containers
   - Ví dụ: Docker, containerd, CRI-O

### Các Add-ons quan trọng

- **CoreDNS**: Cung cấp DNS cho cluster
- **Dashboard**: Giao diện UI cho quản trị Kubernetes
- **Ingress Controller**: Quản lý traffic từ bên ngoài vào services
- **CNI (Container Network Interface)**: Plugin quản lý mạng giữa các pods

### Mô hình hoạt động

- Khi có yêu cầu (ví dụ: triển khai ứng dụng), client gửi request đến API Server
- API Server xác thực và xử lý request, lưu trạng thái vào etcd
- Controllers phát hiện thay đổi trạng thái và thực hiện các hành động
- Scheduler quyết định pod sẽ chạy trên node nào
- Kubelet trên node nhận thông tin và tạo pod
- Kube-proxy cấu hình mạng cho pod

---

## 🧑‍🏫 Bài 3: Cài đặt và Cấu hình Kubernetes

### Các phương pháp cài đặt Kubernetes

1. **Minikube**: Cho môi trường phát triển, chạy Kubernetes cục bộ
2. **kubeadm**: Công cụ chính thức để cài đặt và cấu hình Kubernetes
3. **kind (Kubernetes IN Docker)**: Chạy Kubernetes trên Docker containers
4. **Dịch vụ quản lý**: EKS (AWS), GKE (Google), AKS (Azure)

### Cài đặt Minikube cho môi trường phát triển

```bash
# Cài đặt Minikube trên Linux
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

# Khởi động cluster
minikube start

# Kiểm tra trạng thái
minikube status
```

### Cài đặt kubectl - công cụ CLI để tương tác với Kubernetes

```bash
# Linux
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Kiểm tra phiên bản
kubectl version --client
```

### Cài đặt cluster với kubeadm

```bash
# 1. Cài đặt container runtime (ví dụ: Docker)
# 2. Cài đặt kubeadm, kubelet và kubectl
apt-get update
apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt-get update
apt-get install -y kubelet kubeadm kubectl

# 3. Khởi tạo control plane
kubeadm init --pod-network-cidr=10.244.0.0/16

# 4. Cấu hình kubectl cho user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 5. Cài đặt network plugin (ví dụ: Calico)
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# 6. Join worker nodes
# Sử dụng lệnh từ output của kubeadm init
kubeadm join <control-plane-ip>:<port> --token <token> --discovery-token-ca-cert-hash <hash>
```

### Xác nhận cài đặt Kubernetes

```bash
# Kiểm tra trạng thái các nodes
kubectl get nodes

# Kiểm tra các pods trong namespace kube-system
kubectl get pods -n kube-system

# Kiểm tra phiên bản server và client
kubectl version
```

### Cấu hình Kubernetes

1. **Contexts và Clusters**:

   ```bash
   # Liệt kê contexts
   kubectl config get-contexts

   # Chuyển đổi context
   kubectl config use-context my-cluster

   # Xem cấu hình hiện tại
   kubectl config view
   ```

2. **Các file cấu hình quan trọng**:

   - `/etc/kubernetes/`: Chứa cấu hình của cluster
   - `~/.kube/config`: Cấu hình của kubectl
   - `/etc/systemd/system/kubelet.service.d/`: Cấu hình kubelet

3. **Roles và RBAC (Điều khiển truy cập dựa trên vai trò)**:

   ```bash
   # Tạo Role
   kubectl create role pod-reader --verb=get,list,watch --resource=pods

   # Tạo RoleBinding
   kubectl create rolebinding read-pods --role=pod-reader --user=jane

   # Kiểm tra quyền
   kubectl auth can-i list pods --as jane
   ```

4. **Namespace**:

```bash
# Tạo namespace
kubectl create namespace my-namespace

# Liệt kê namespaces
kubectl get namespaces

# Thực hiện lệnh trong namespace cụ thể
kubectl get pods -n my-namespace
```

---

## 🧑‍🏫 Bài 4: Kubernetes Objects và Workloads

### Kubernetes Objects là gì?

- Các thực thể bền vững trong hệ thống Kubernetes
- Đại diện cho trạng thái của cluster
- Được mô tả bằng files YAML hoặc JSON

### Các Objects phổ biến

1. **Pods**: Đơn vị nhỏ nhất có thể deploy trong Kubernetes
2. **ReplicaSets**: Đảm bảo số lượng Pods mong muốn
3. **Deployments**: Quản lý ReplicaSets, hỗ trợ cập nhật và rollback
4. **Services**: Định nghĩa cách truy cập vào Pods
5. **ConfigMaps** và Secrets: Cấu hình và dữ liệu nhạy cảm
6. **Volumes**: Lưu trữ dữ liệu cho Pods
7. **Namespaces**: Phân chia cluster thành nhiều môi trường ảo

### Pod

- Nhóm các containers chia sẻ storage và network
- Mô hình "sidecar" phổ biến: container chính + container phụ trợ

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

- Mức cao hơn Pod và ReplicaSet
- Quản lý việc deploy và update ứng dụng
- Hỗ trợ rollout và rollback

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

- Cung cấp một endpoint ổn định để truy cập Pods
- Cân bằng tải giữa nhiều Pods

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

- Đảm bảo tất cả (hoặc một số) Nodes chạy một bản sao của Pod
- Thường dùng cho logging, monitoring, storage

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

- Quản lý các Pods có định danh duy nhất
- Duy trì thứ tự và tính duy nhất của Pods
- Thích hợp cho databases và ứng dụng stateful

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

### Job và CronJob

- Job: Chạy Pod đến khi hoàn thành
- CronJob: Job chạy theo lịch trình

```yaml
# cronjob.yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: backup-database
spec:
  schedule: "0 1 * * *" # Mỗi ngày lúc 1 giờ sáng
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

### Quản lý Kubernetes Objects

```bash
# Tạo từ file YAML
kubectl apply -f deployment.yaml

# Cập nhật image
kubectl set image deployment/nginx-deployment nginx=nginx:1.20

# Rollback
kubectl rollout undo deployment/nginx-deployment

# Scale
kubectl scale deployment/nginx-deployment --replicas=5

# Xóa
kubectl delete deployment nginx-deployment
```

---

## 🧑‍🏫 Bài 5: Networking trong Kubernetes

### Mô hình networking của Kubernetes

- Flat network: Pods giao tiếp với nhau không cần NAT
- Mỗi Pod có IP duy nhất
- Containers trong Pod chia sẻ IP

### Các thành phần networking

1. **Pod Network**: Giao tiếp giữa các pods
2. **Service Network**: Truy cập đến các pods
3. **Cluster DNS**: Service discovery
4. **Ingress**: Routing HTTP/HTTPS từ bên ngoài vào cluster

### Network Plugins (CNI)

- Calico: Hiệu suất cao, hỗ trợ network policy
- Flannel: Đơn giản, dễ cài đặt
- Weave Net: Dễ sử dụng, mã hóa
- Cilium: Dựa trên eBPF, hiệu năng cao

### Service ()

- Cung cấp địa chỉ IP và DNS cố định
- Load balancing giữa các pods

### Các loại Services

1. **ClusterIP**: (mặc định)
   - IP nội bộ trong cluster
   - Chỉ truy cập được từ bên trong cluster

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
   - Mở port cố định trên tất cả các nodes
   - Truy cập từ bên ngoài qua `<NodeIP>:<NodePort>`

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
   - Sử dụng load balancer của cloud provider
   - Cung cấp IP công khai

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
   - CNAME record tới service bên ngoài

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

- Layer 7 (HTTP) load balancer
- Định tuyến traffic dựa trên URL path hoặc hostname
- Cần Ingress Controller (nginx, traefik, ...)

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

- Kiểm soát traffic giữa Pods
- Tương tự như firewall rules

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
# Kiểm tra service
kubectl get svc my-service

# Debug DNS
kubectl run -i --tty --rm debug --image=busybox -- sh
# Trong container debug
nslookup my-service

# Kiểm tra endpoints
kubectl get endpoints my-service

# Xem network policies
kubectl get networkpolicies
```

---

## 🧑‍🏫 Bài 6: Storage và Persistence

### Persistent Storage trong Kubernetes

- Dữ liệu tồn tại độc lập với vòng đời của Pod
- Kubernetes abstraction để quản lý storage

### Volumes

- Storage gắn vào Pod
- Tồn tại trong suốt vòng đời của Pod

### Các loại Volumes phổ biến

1. **emptyDir**: Thư mục tạm thời, bị xóa khi Pod bị xóa
2. **hostPath**: Sử dụng path trên Node
3. **PersistentVolume (PV)**: Storage độc lập với Pod
4. **ConfigMap/Secret as Volume**: Mount cấu hình/bí mật

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

1. **PersistentVolume (PV)**: Tài nguyên storage thực tế
2. **PersistentVolumeClaim (PVC)**: Yêu cầu sử dụng storage
3. **StorageClass**: Định nghĩa loại storage và provisioner

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

#### Sử dụng PVC trong Pod

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

- Cung cấp storage động theo yêu cầu
- Tích hợp với cloud providers

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

- Sao lưu dữ liệu từ PVC
- Khôi phục từ snapshot

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

#### StatefulSet với Storage

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

1. Sử dụng PVs và PVCs thay vì volumes trực tiếp
2. Định nghĩa StorageClass phù hợp cho từng loại workload
3. Cấu hình backup và disaster recovery
4. Sử dụng StatefulSets với volumeClaimTemplates cho ứng dụng stateful
5. Giám sát dung lượng và hiệu suất storage

---

## 🧑‍🏫 Bài 7: ConfigMaps và Secrets

### ConfigMaps

- Lưu trữ dữ liệu cấu hình dạng key-value
- Tách cấu hình ra khỏi image container

### Tạo ConfigMap

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

### Sử dụng ConfigMap

1. **Biến môi trường**:

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

2. **envFrom - tất cả keys làm biến môi trường**:

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

- Lưu trữ dữ liệu nhạy cảm (passwords, tokens, keys)
- Tương tự ConfigMap nhưng an toàn hơn
- Mã hóa Base64 (không phải mã hóa mạnh)

### Tạo Secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
data:
  # Giá trị phải ở dạng base64
  username: YWRtaW4= # admin
  password: c2VjcmV0 # secret
```

### Tạo Secret từ command line

```bash
# Tạo từ file
kubectl create secret generic ssl-cert --from-file=cert.pem --from-file=key.pem

# Tạo từ literal
kubectl create secret generic api-keys --from-literal=api_key=123456 --from-literal=secret_key=abcdef
```

### Sử dụng Secret

1. **Biến môi trường**:

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

- Opaque: Default, dữ liệu tùy ý
- kubernetes.io/service-account-token: Service account token
- kubernetes.io/dockerconfigjson: Docker registry auth
- kubernetes.io/tls: TLS certificates

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

### Sử dụng Docker Registry Secret

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

### Best Practices (Bí quyết bảo mật Secrets)

1. Không lưu trữ Secrets trong git repositories
2. Hạn chế access đến Secrets bằng RBAC
3. Sử dụng solutions bên ngoài như Vault cho quản lý bí mật
4. Thiết lập network policies cho Pods với Secrets
5. Encrypt etcd để bảo vệ Secrets khi lưu trữ

---

## 🧑‍🏫 Bài 8: Helm - Package Manager cho Kubernetes

### Helm là gì?

- Package manager cho Kubernetes
- Giúp định nghĩa, cài đặt và nâng cấp ứng dụng phức tạp
- Tương tự npm, pip hoặc apt nhưng cho Kubernetes

### Khái niệm cơ bản của Helm

1. **Chart**: Package của Helm, chứa tất cả tài nguyên Kubernetes
2. **Repository**: Nơi lưu trữ và chia sẻ charts
3. **Release**: Instance của chart đã được deploy

### Cài đặt Helm

```bash
# Linux
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# macOS
brew install helm

# Windows
choco install kubernetes-helm
```

### Cấu trúc của một Helm Chart

```text
mychart/
  Chart.yaml          # Thông tin về chart
  values.yaml         # Giá trị mặc định cho templates
  templates/          # Thư mục chứa templates
    deployment.yaml
    service.yaml
    ingress.yaml
    _helpers.tpl      # Partial templates
  charts/             # Charts phụ thuộc
  templates/NOTES.txt # Notes hiển thị sau khi cài đặt
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
# Tìm kiếm charts
helm search hub wordpress

# Thêm repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Cài đặt chart
helm install my-release bitnami/wordpress

# Xem các releases đã cài đặt
helm list

# Kiểm tra trạng thái
helm status my-release

# Nâng cấp release
helm upgrade my-release bitnami/wordpress --values=custom-values.yaml

# Rollback
helm rollback my-release 1

# Gỡ cài đặt
helm uninstall my-release
```

#### Tạo Helm Chart mới

```bash
# Tạo chart mới
helm create mychart

# Kiểm tra cấu trúc chart
helm lint mychart

# Đóng gói chart
helm package mychart

# Cài đặt chart local
helm install my-app ./mychart

# Cài đặt với custom values
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

### Best Practices (Bí quyết sử dụng Helm)

1. Sử dụng Helm repo để quản lý charts
2. Phân chia values.yaml theo các thành phần logic
3. Đặt thực nghiệm với templates trong values.yaml
4. Sử dụng helpers để tái sử dụng code
5. Thêm NOTES.txt để hướng dẫn người dùng

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng và triển khai ứng dụng microservices trên Kubernetes

### Mô tả bài toán

Xây dựng hệ thống microservices hoàn chỉnh và triển khai trên Kubernetes cluster, với các thành phần:

- Frontend SPA (Single Page Application)
- API Gateway
- 2-3 Microservices backend
- Database (SQL hoặc NoSQL)
- Hệ thống xác thực/phân quyền

### Yêu cầu

1. Xây dựng Docker images cho từng microservice
2. Tạo các Kubernetes manifests cho tất cả các components
3. Cấu hình Services, Ingress để quản lý traffic
4. Thiết lập PersistentVolumes cho database
5. Cấu hình ConfigMaps và Secrets
6. Triển khai Prometheus và Grafana để monitoring
7. Cấu hình Horizontal Pod Autoscaler
8. Tạo Helm chart cho toàn bộ ứng dụng
9. Viết scripts cho CI/CD pipeline

### Kết quả đạt được

- Ứng dụng chạy ổn định trên Kubernetes
- Tài liệu triển khai chi tiết và kiến trúc hệ thống
- Khả năng mở rộng tự động theo tải
- Monitoring và alerting đầy đủ
- CI/CD pipeline cho việc cập nhật ứng dụng
