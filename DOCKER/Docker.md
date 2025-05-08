# 📘 DOCKER: NỀN TẢNG CONTAINER HÓA

- [📘 DOCKER: NỀN TẢNG CONTAINER HÓA](#-docker-nền-tảng-container-hóa)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu về Container và Docker](#-bài-1-giới-thiệu-về-container-và-docker)
    - [Khái niệm container](#khái-niệm-container)
    - [Container vs Virtual Machine](#container-vs-virtual-machine)
    - [So với máy ảo](#so-với-máy-ảo)
    - [Lợi ích của container](#lợi-ích-của-container)
    - [Docker là gì?](#docker-là-gì)
    - [Các thành phần chính của Docker](#các-thành-phần-chính-của-docker)
  - [🧑‍🏫 Bài 2: Cài đặt và cấu hình Docker](#-bài-2-cài-đặt-và-cấu-hình-docker)
    - [Cài đặt Docker trên Ubuntu](#cài-đặt-docker-trên-ubuntu)
    - [Cài đặt Docker trên Windows](#cài-đặt-docker-trên-windows)
    - [Cài đặt Docker trên macOS](#cài-đặt-docker-trên-macos)
    - [Kiểm tra cài đặt](#kiểm-tra-cài-đặt)
    - [Quản lý Docker Service](#quản-lý-docker-service)
    - [Cấu hình sau cài đặt](#cấu-hình-sau-cài-đặt)
    - [Vị trí các file cấu hình](#vị-trí-các-file-cấu-hình)
  - [🧑‍🏫 Bài 3: Làm việc với Docker Images và Containers](#-bài-3-làm-việc-với-docker-images-và-containers)
    - [Docker Images](#docker-images)
    - [Quản lý Docker Images](#quản-lý-docker-images)
    - [Vòng đời của Container](#vòng-đời-của-container)
    - [Quản lý Docker Containers](#quản-lý-docker-containers)
    - [Các cờ quan trọng của lệnh `docker run`](#các-cờ-quan-trọng-của-lệnh-docker-run)
  - [🧑‍🏫 Bài 4: Xây dựng Docker Images với Dockerfile](#-bài-4-xây-dựng-docker-images-với-dockerfile)
    - [Dockerfile là gì?](#dockerfile-là-gì)
    - [Cấu trúc Dockerfile cơ bản](#cấu-trúc-dockerfile-cơ-bản)
    - [Các lệnh phổ biến trong Dockerfile](#các-lệnh-phổ-biến-trong-dockerfile)
    - [Build Docker Image](#build-docker-image)
    - [Multi-stage builds](#multi-stage-builds)
    - [Các nguyên tắc tốt khi viết Dockerfile](#các-nguyên-tắc-tốt-khi-viết-dockerfile)
    - [Ví dụ về file .dockerignore](#ví-dụ-về-file-dockerignore)
  - [🧑‍🏫 Bài 5: Docker Networking và Volumes](#-bài-5-docker-networking-và-volumes)
    - [Docker Networking Models](#docker-networking-models)
    - [Quản lý Docker Networks](#quản-lý-docker-networks)
    - [Truyền thông giữa các container](#truyền-thông-giữa-các-container)
    - [Docker Volumes](#docker-volumes)
    - [Quản lý Docker Volumes](#quản-lý-docker-volumes)
    - [Các cách gắn kết dữ liệu](#các-cách-gắn-kết-dữ-liệu)
    - [Các use cases cho volumes](#các-use-cases-cho-volumes)
  - [🧑‍🏫 Bài 6: Docker Compose](#-bài-6-docker-compose)
    - [Docker Compose là gì?](#docker-compose-là-gì)
    - [Cài đặt Docker Compose](#cài-đặt-docker-compose)
    - [Cấu trúc file docker-compose.yml](#cấu-trúc-file-docker-composeyml)
    - [Các lệnh Docker Compose cơ bản](#các-lệnh-docker-compose-cơ-bản)
    - [Các thành phần chính trong docker-compose.yml](#các-thành-phần-chính-trong-docker-composeyml)
    - [Ví dụ nâng cao - Ứng dụng MERN stack](#ví-dụ-nâng-cao---ứng-dụng-mern-stack)
    - [Biến môi trường và Compose](#biến-môi-trường-và-compose)
    - [Ví dụ file .env](#ví-dụ-file-env)
    - [Tham chiếu trong docker-compose.yml](#tham-chiếu-trong-docker-composeyml)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Triển khai ứng dụng web đa tầng](#-bài-tập-lớn-cuối-phần-triển-khai-ứng-dụng-web-đa-tầng)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)
    - [Kết quả đạt được](#kết-quả-đạt-được)

## 🎯 Mục tiêu tổng quát

- Hiểu được khái niệm về công nghệ container và lợi ích của nó
- Thành thạo cài đặt, cấu hình và sử dụng Docker
- Làm chủ việc tạo, quản lý và triển khai ứng dụng với container
- Hiểu được kiến trúc mạng và lưu trữ dữ liệu trong Docker
- Phát triển và triển khai ứng dụng đa container với Docker Compose

---

## 🧑‍🏫 Bài 1: Giới thiệu về Container và Docker

### Khái niệm container

- **Container là gì?**: Một gói phần mềm nhẹ chứa mọi thứ cần thiết để chạy một ứng dụng
  - Code của ứng dụng
  - Thư viện và phần mềm hỗ trợ
  - Cấu hình và các biến môi trường

- **Cách hoạt động**: 
  - Tách biệt ứng dụng khỏi môi trường
  - Nhiều container chạy trên cùng một máy 
  - Tất cả chia sẻ hệ điều hành của máy chủ
  - Mỗi container hoạt động như một tiến trình riêng biệt

- **Ưu điểm nổi bật**:
  - **Nhất quán**: Hoạt động giống nhau ở mọi nơi - máy tính cá nhân, máy chủ hay cloud
  - **Nhẹ**: Khởi động trong vài giây và sử dụng ít tài nguyên
  - **Cô lập**: Các ứng dụng không ảnh hưởng lẫn nhau
  - **Dễ triển khai**: Chỉ cần một lệnh để khởi chạy

### Container vs Virtual Machine

```text
+--------------------------+      +--------------------------+
|       Container 1        |      |       Container 2        |
| +----------------------+ |      | +----------------------+ |
| |      Ứng dụng A      | |      | |      Ứng dụng B      | |
| +----------------------+ |      | +----------------------+ |
| | Thư viện & Phụ thuộc | |      | | Thư viện & Phụ thuộc | |
| +----------------------+ |      | +----------------------+ |
+-----------+--------------+      +-----------+--------------+
            |                                 |
            v                                 v
    +--------------------------------------------------+
    |                  Docker Engine                   |
    +--------------------------------------------------+
    |                  Hệ điều hành                    |
    +--------------------------------------------------+
    |                    Phần cứng                     |
    +--------------------------------------------------+
```

### So với máy ảo

```text
+----------------+ +----------------+
|   Ứng dụng A   | |   Ứng dụng B   |
+----------------+ +----------------+
|  Guest OS (VM1)| |  Guest OS (VM2)|
+----------------+ +----------------+
|            Hypervisor             |
+-----------------------------------+
|           Hệ điều hành            |
+-----------------------------------+
|            Phần cứng              |
+-----------------------------------+
```

### Lợi ích của container

- Nhẹ hơn VM (không cần OS đầy đủ)
- Khởi động nhanh (giây thay vì phút)
- Tài nguyên sử dụng hiệu quả hơn
- Dễ dàng mở rộng và di chuyển

### Docker là gì?

- Nền tảng mã nguồn mở để xây dựng, chuyển giao và chạy ứng dụng trong container
- Được phát hành năm 2013, đã trở thành tiêu chuẩn công nghiệp de facto
- Cung cấp công cụ và API để quản lý vòng đời của container

### Các thành phần chính của Docker

- Docker Engine: Runtime và công cụ đóng gói
- Docker Hub: Kho lưu trữ images trực tuyến
- Docker Compose: Công cụ định nghĩa và chạy ứng dụng đa container
- Docker Swarm: Giải pháp quản lý cluster container tích hợp

---

## 🧑‍🏫 Bài 2: Cài đặt và cấu hình Docker

### Cài đặt Docker trên Ubuntu

```bash
# Cập nhật package index
sudo apt-get update

# Cài đặt các gói phụ thuộc
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Thêm GPG key của Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Thêm repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Cài đặt Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```

### Cài đặt Docker trên Windows

- Tải Docker Desktop từ [docker.com](https://www.docker.com/products/docker-desktop)
- Cài đặt và đảm bảo Hyper-V hoặc WSL2 được bật
- Khởi động Docker Desktop

### Cài đặt Docker trên macOS

- Tải Docker Desktop cho Mac từ [docker.com](https://www.docker.com/products/docker-desktop)
- Kéo vào thư mục Applications để cài đặt

### Kiểm tra cài đặt

```bash
# Kiểm tra phiên bản Docker
docker --version

# Kiểm tra cài đặt đầy đủ
docker info

# Chạy container hello-world
docker run hello-world
```

### Quản lý Docker Service

```bash
# Kiểm tra trạng thái service
sudo systemctl status docker

# Start Docker service
sudo systemctl start docker

# Đảm bảo Docker khởi động cùng hệ thống
sudo systemctl enable docker
```

### Cấu hình sau cài đặt

```bash
# Thêm người dùng hiện tại vào nhóm docker
sudo usermod -aG docker $USER

# Áp dụng thay đổi (đăng nhập lại hoặc)
newgrp docker

# Kiểm tra quyền
docker run hello-world
```

### Vị trí các file cấu hình

- `/etc/docker/daemon.json` - File cấu hình Docker daemon
- `~/.docker/` - Cấu hình client Docker

---

## 🧑‍🏫 Bài 3: Làm việc với Docker Images và Containers

### Docker Images

- Image là template chỉ đọc chứa hướng dẫn để tạo container
- Bao gồm hệ điều hành, ứng dụng, phụ thuộc và cấu hình
- Được tạo thành từ nhiều layer, mỗi layer tương ứng với một instruction trong Dockerfile

### Quản lý Docker Images

```bash
# Tìm kiếm images từ Docker Hub
docker search nginx

# Tải image về máy
docker pull nginx:latest

# Liệt kê images đã tải
docker images

# Xem thông tin chi tiết của image
docker inspect nginx:latest

# Xóa một image
docker rmi nginx:latest

# Xóa tất cả images không sử dụng
docker image prune
```

### Vòng đời của Container

```text
+------------+        +----------+        +----------+
|   Created  | -----> |  Running | -----> |  Stopped |
+------------+        +----------+        +----------+
       |                                        |
       |                                        |
       v                                        v
+------------+                            +----------+
|  Deleted   | <------------------------- |  Deleted |
+------------+                            +----------+
```

### Quản lý Docker Containers

```bash
# Tạo và chạy container
docker run --name webserver -p 80:80 -d nginx

# Liệt kê containers đang chạy
docker ps

# Liệt kê tất cả containers (cả đã dừng)
docker ps -a

# Dừng container
docker stop webserver

# Khởi động lại container
docker start webserver

# Xem logs
docker logs webserver

# Thực thi lệnh trong container
docker exec -it webserver bash

# Xóa container
docker rm webserver

# Xóa tất cả containers đã dừng
docker container prune
```

### Các cờ quan trọng của lệnh `docker run`

```bash
# -d: Chạy ở chế độ detached (nền)
docker run -d nginx

# -p: Port mapping (HOST:CONTAINER)
docker run -p 8080:80 nginx

# -v: Gắn volume (HOST:CONTAINER)
docker run -v /host/path:/container/path nginx

# -e: Biến môi trường
docker run -e MYSQL_ROOT_PASSWORD=secret mysql

# --name: Đặt tên container
docker run --name database mysql

# --network: Kết nối container với mạng
docker run --network my-network nginx

# --restart: Chính sách khởi động lại
docker run --restart always nginx
```

---

## 🧑‍🏫 Bài 4: Xây dựng Docker Images với Dockerfile

### Dockerfile là gì?

- File văn bản chứa các lệnh để xây dựng Docker image
- Mỗi lệnh tạo một layer trong image
- Sử dụng cú pháp đơn giản, dễ đọc

### Cấu trúc Dockerfile cơ bản

```dockerfile
# Chọn image cơ sở
FROM ubuntu:20.04

# Thông tin về người tạo
LABEL maintainer="example@example.com"

# Thiết lập biến môi trường
ENV APP_HOME /app

# Thực thi lệnh shell
RUN apt-get update && apt-get install -y python3 python3-pip

# Thiết lập thư mục làm việc
WORKDIR $APP_HOME

# Sao chép file từ host vào image
COPY requirements.txt .
COPY app.py .

# Cài đặt dependencies
RUN pip3 install -r requirements.txt

# Mở port
EXPOSE 5000

# Lệnh khởi chạy khi container được tạo
CMD ["python3", "app.py"]
```

### Các lệnh phổ biến trong Dockerfile

- `FROM`: Chọn image cơ sở
- `RUN`: Thực thi lệnh và tạo layer mới
- `COPY`/`ADD`: Sao chép files/directories từ host vào image
- `WORKDIR`: Thiết lập thư mục làm việc
- `ENV`: Thiết lập biến môi trường
- `EXPOSE`: Khai báo port sẽ được sử dụng
- `VOLUME`: Tạo mount point
- `CMD`: Định nghĩa lệnh mặc định khi chạy container
- `ENTRYPOINT`: Cấu hình container chạy như một executable

### Build Docker Image

```bash
# Cú pháp cơ bản
docker build -t my-app:1.0 .

# Chỉ định Dockerfile
docker build -f Dockerfile.dev -t my-app:dev .

# Sử dụng build argument
docker build --build-arg VERSION=1.0 -t my-app:1.0 .
```

### Multi-stage builds

```dockerfile
# Stage 1: Build
FROM node:14 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Các nguyên tắc tốt khi viết Dockerfile

1. Sử dụng image cơ sở phù hợp và nhỏ gọn
2. Kết hợp các RUN commands để giảm số lượng layers
3. Sắp xếp các lệnh theo tần suất thay đổi (ít thay đổi trước)
4. Loại bỏ các công cụ không cần thiết
5. Sử dụng .dockerignore để loại trừ các file không cần thiết
6. Sử dụng multi-stage builds cho ứng dụng production
7. Thiết lập user non-root

### Ví dụ về file .dockerignore

```text
node_modules
npm-debug.log
Dockerfile
.git
.gitignore
README.md
```

---

## 🧑‍🏫 Bài 5: Docker Networking và Volumes

### Docker Networking Models

- **Bridge**: Mạng mặc định cho container (driver: bridge)
- **Host**: Container sử dụng mạng của host (driver: host)
- **None**: Vô hiệu hóa tất cả networking (driver: null)
- **Overlay**: Mạng phân tán nhiều Docker daemons (driver: overlay)
- **Macvlan**: Gán địa chỉ MAC cho container (driver: macvlan)

### Quản lý Docker Networks

```bash
# Liệt kê networks
docker network ls

# Tạo network
docker network create my-network

# Kiểm tra thông tin chi tiết network
docker network inspect my-network

# Kết nối container vào network
docker network connect my-network container-name

# Ngắt kết nối container khỏi network
docker network disconnect my-network container-name

# Xóa network
docker network rm my-network
```

### Truyền thông giữa các container

```bash
# Tạo network
docker network create app-network

# Chạy container MySQL và thêm vào network
docker run -d --name mysql --network app-network -e MYSQL_ROOT_PASSWORD=secret mysql:5.7

# Chạy container WordPress và kết nối với MySQL
docker run -d --name wordpress --network app-network -p 8080:80 \
    -e WORDPRESS_DB_HOST=mysql \
    -e WORDPRESS_DB_PASSWORD=secret \
    wordpress
```

### Docker Volumes

- Cơ chế quản lý dữ liệu bền vững cho container
- Dữ liệu tồn tại độc lập với vòng đời của container
- Ba loại storage trong Docker:
  - **Volumes**: Được quản lý hoàn toàn bởi Docker
  - **Bind mounts**: Mount trực tiếp thư mục host
  - **tmpfs mounts**: Lưu trữ tạm thời trong memory

### Quản lý Docker Volumes

```bash
# Tạo volume
docker volume create my-data

# Liệt kê volumes
docker volume ls

# Kiểm tra thông tin chi tiết volume
docker volume inspect my-data

# Sử dụng volume khi chạy container
docker run -d --name mysql -v my-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=secret mysql:5.7

# Xóa volume
docker volume rm my-data

# Xóa volumes không sử dụng
docker volume prune
```

### Các cách gắn kết dữ liệu

```bash
# Sử dụng volumes (quản lý bởi Docker)
docker run -v my-data:/app/data nginx

# Sử dụng bind mounts (thư mục trên host)
docker run -v $(pwd)/data:/app/data nginx

# Sử dụng readonly mount
docker run -v my-data:/app/data:ro nginx

# Sử dụng tmpfs mount (lưu trữ trong memory)
docker run --tmpfs /app/temp nginx
```

### Các use cases cho volumes

1. **Database storage**: Lưu trữ dữ liệu database
2. **Configuration**: Chia sẻ cấu hình giữa container và host
3. **Sharing data**: Chia sẻ dữ liệu giữa các container
4. **Development**: Mount code giữa host và container

---

## 🧑‍🏫 Bài 6: Docker Compose

### Docker Compose là gì?

- Công cụ định nghĩa và chạy ứng dụng Docker đa container
- Sử dụng file YAML để cấu hình các service
- Quản lý vòng đời hoàn chỉnh của ứng dụng

### Cài đặt Docker Compose

```bash
# Linux
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Kiểm tra phiên bản
docker-compose --version
```

### Cấu trúc file docker-compose.yml

```yaml
version: '3'

services:
  webapp:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
    depends_on:
      - database

  database:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=secret
      - MYSQL_DATABASE=myapp

volumes:
  db_data:
```

### Các lệnh Docker Compose cơ bản

```bash
# Khởi chạy các services
docker-compose up

# Chạy ở chế độ detached (nền)
docker-compose up -d

# Xem logs
docker-compose logs

# Xem status của các services
docker-compose ps

# Dừng các services
docker-compose stop

# Dừng và xóa tất cả containers, networks
docker-compose down

# Xóa volumes của services
docker-compose down -v

# Scale services
docker-compose up -d --scale webapp=3
```

### Các thành phần chính trong docker-compose.yml

1. **version**: Phiên bản Compose file format
2. **services**: Định nghĩa các services (containers)
3. **networks**: Định nghĩa networks
4. **volumes**: Định nghĩa volumes
5. **configs**: Định nghĩa configuration (từ v3.3)
6. **secrets**: Định nghĩa secrets (từ v3.1)

### Ví dụ nâng cao - Ứng dụng MERN stack

```yaml
version: '3'

services:
  frontend:
    build: ./client
    ports:
      - "3000:3000"
    depends_on:
      - backend
    environment:
      - REACT_APP_API_URL=http://localhost:5000/api

  backend:
    build: ./server
    ports:
      - "5000:5000"
    depends_on:
      - mongodb
    environment:
      - MONGO_URI=mongodb://mongodb:27017/myapp
      - PORT=5000
    volumes:
      - ./server:/app
      - /app/node_modules

  mongodb:
    image: mongo:latest
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db

volumes:
  mongo_data:
```

### Biến môi trường và Compose

- Sử dụng file `.env` cho các biến môi trường
- Tham chiếu với cú pháp `${VARIABLE_NAME}`
- Ghi đè với `-e` flag hoặc `environment` section

### Ví dụ file .env

```conf
MYSQL_ROOT_PASSWORD=secret_password
MYSQL_DATABASE=production_db
EXTERNAL_PORT=8080
```

### Tham chiếu trong docker-compose.yml

```yaml
services:
  webapp:
    image: my-webapp
    ports:
      - "${EXTERNAL_PORT}:80"
  
  database:
    image: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_DATABASE=${MYSQL_DATABASE}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Triển khai ứng dụng web đa tầng

### Mô tả bài toán

Xây dựng và triển khai một ứng dụng web đa tầng sử dụng Docker và Docker Compose, bao gồm:

- Frontend (React/Vue/Angular)
- Backend API (Node.js/Python/JAVA)
- Database (MySQL/MongoDB/PostgreSQL)
- Web server/reverse proxy (Nginx)

### Yêu cầu

1. Tạo Dockerfile cho mỗi thành phần
2. Cấu hình Docker Compose để kết nối các services
3. Thiết lập volumes để lưu trữ dữ liệu và cấu hình
4. Cấu hình networking cho các services
5. Đảm bảo ứng dụng có thể build và deploy bằng một lệnh
6. Triển khai hot-reload cho môi trường phát triển
7. Viết tài liệu hướng dẫn sử dụng

### Kết quả đạt được

- Ứng dụng chạy trên Docker với đầy đủ các thành phần
- Source code cùng với Dockerfile và docker-compose.yml
- Các volumes được cấu hình đúng để dữ liệu tồn tại giữa các lần khởi động
- Tài liệu hướng dẫn triển khai và sử dụng

---

[⬅️ Trở lại: PHP/Part6.md](../PHP/Part6.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: DOCKER/Kubernetes.md](../DOCKER/Kubernetes.md)
