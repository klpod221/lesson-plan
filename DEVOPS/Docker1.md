# 🐳 DOCKER: NẮM VỮNG NỀN TẢNG

- [🐳 DOCKER: NẮM VỮNG NỀN TẢNG](#-docker-nắm-vững-nền-tảng)
  - [🎯 Mục Tiêu Tổng Quát](#-mục-tiêu-tổng-quát)
  - [🎯 Mục Tiêu](#-mục-tiêu)
  - [1. 🌟 Giới Thiệu](#1--giới-thiệu)
    - [Vấn đề "It works on my machine!"](#vấn-đề-it-works-on-my-machine)
    - [Giải pháp là gì? VMs vs Containers](#giải-pháp-là-gì-vms-vs-containers)
  - [2. 🐧 Linux Cơ Bản Cho Docker](#2--linux-cơ-bản-cho-docker)
    - [Di chuyển \& Quản lý file/thư mục](#di-chuyển--quản-lý-filethư-mục)
    - [Quyền (Permissions) cơ bản](#quyền-permissions-cơ-bản)
    - [Một số lệnh hữu ích khác](#một-số-lệnh-hữu-ích-khác)
  - [3. 💡 Docker Core Concepts](#3--docker-core-concepts)
    - [Docker Engine](#docker-engine)
    - [Image](#image)
    - [Container](#container)
    - [Dockerfile](#dockerfile)
    - [Registry (Docker Hub)](#registry-docker-hub)
  - [4. ⚙️ Docker CLI Cơ Bản](#4-️-docker-cli-cơ-bản)
    - [Quản lý Images](#quản-lý-images)
    - [Quản lý Containers](#quản-lý-containers)
    - [Tương tác với Container](#tương-tác-với-container)
  - [5. 📝 Dockerfile: Công Thức Tạo Image](#5--dockerfile-công-thức-tạo-image)
    - [Các chỉ thị (Instructions) phổ biến](#các-chỉ-thị-instructions-phổ-biến)
    - [Ví dụ Dockerfile đơn giản (Node.js App)](#ví-dụ-dockerfile-đơn-giản-nodejs-app)
  - [6. 🛠️ Thực Hành: Dockerize Ứng Dụng "Hello World" với Nginx](#6-️-thực-hành-dockerize-ứng-dụng-hello-world-với-nginx)
  - [7. 🏋️ Bài Tập](#7-️-bài-tập)

---

## 🎯 Mục Tiêu Tổng Quát

- Hiểu rõ **Docker** và **Docker Compose** là gì, tại sao chúng quan trọng trong phát triển phần mềm hiện đại.
- Nắm vững các **khái niệm cốt lõi** và **lệnh Docker cơ bản**.
- Biết cách **Dockerize** một ứng dụng đơn giản.
- Sử dụng **Docker Compose** để quản lý các ứng dụng đa-container.
- Làm quen với các **lệnh Linux cơ bản** thường dùng khi làm việc với Docker.
- Tự tin áp dụng Docker vào **workflow phát triển hàng ngày** để tăng hiệu suất và tính nhất quán.

---

## 🎯 Mục Tiêu

- Hiểu được vấn đề Docker giải quyết (**"It works on my machine!"**).
- Nắm vững các khái niệm: `Image`, `Container`, `Dockerfile`, `Registry`.
- Thành thạo các lệnh `Docker CLI` cơ bản.
- Làm quen với các lệnh `Linux` cơ bản cần thiết khi làm việc với Docker.
- Thực hành xây dựng `Dockerfile` đầu tiên và chạy `container`.

---

## 1. 🌟 Giới Thiệu

### Vấn đề "It works on my machine!"

- Môi trường khác nhau giữa dev, staging, production.
- Xung đột thư viện, phiên bản phần mềm.
- Khó khăn khi setup môi trường cho người mới.

[Hình ảnh minh họa: meme "works on my machine"](../images/devops/itworksonmymachine.webp)

### Giải pháp là gì? VMs vs Containers

| Tính năng        | Virtual Machines (VMs)                                   | Containers (Docker)                             |
| :--------------- | :------------------------------------------------------- | :---------------------------------------------- |
| **Isolation**    | OS Level (mỗi VM có Kernel riêng)                        | Process Level (chia sẻ Kernel của Host OS)      |
| **Overhead**     | Cao (RAM, CPU, Disk cho cả OS khách)                     | Thấp (chỉ tài nguyên cho ứng dụng)              |
| **Startup Time** | Chậm (phút)                                              | Nhanh (giây)                                    |
| **Portability**  | Khá (image VM lớn)                                       | Rất cao (image container nhỏ gọn)               |
| **Density**      | Thấp (ít VM trên một host)                               | Cao (nhiều container trên một host)             |
| **Use Case**     | Cần OS khác hoàn toàn, yêu cầu bảo mật kernel riêng biệt | Đóng gói và chạy ứng dụng, microservices, CI/CD |

**Sơ đồ kiến trúc:**

```text
      App A | App B             App A | App B | App C
      Bins/Libs | Bins/Libs     Bins/Libs | Bins/Libs | Bins/Libs
      Guest OS | Guest OS       ---------------------
      Hypervisor                Container Engine (Docker)
      ---------------------     ---------------------
      Host OS                   Host OS
      ---------------------     ---------------------
      Infrastructure            Infrastructure

      (VM Architecture)         (Container Architecture)
```

Docker là một nền tảng **containerization** giúp đóng gói ứng dụng và các dependencies của nó thành một đơn vị gọi là **container**.

## 2. 🐧 Linux Cơ Bản Cho Docker

Nhiều `Docker image` được xây dựng dựa trên Linux. Hiểu một số lệnh cơ bản giúp bạn tương tác với `container` và viết `Dockerfile` hiệu quả hơn.

### Di chuyển & Quản lý file/thư mục

- `pwd` (print working directory): Hiển thị thư mục hiện tại.
- `ls` (list): Liệt kê file và thư mục.
  - `ls -l`: Hiển thị chi tiết.
  - `ls -a`: Hiển thị cả file ẩn.
- `cd <directory>` (change directory): Chuyển thư mục.
  - `cd ..`: Lên thư mục cha.
  - `cd ~` hoặc `cd`: Về thư mục home.
- `mkdir <directory_name>` (make directory): Tạo thư mục mới.
- `rm <file_name>` (remove): Xóa file.
  - `rm -r <directory_name>`: Xóa thư mục và nội dung bên trong (cẩn thận!).
  - `rm -rf <directory_name>`: Xóa thư mục và nội dung bên trong, không hỏi (RẤT CẨN THẬN!).
- `cp <source> <destination>` (copy): Sao chép file hoặc thư mục.
  - `cp -r <source_dir> <destination_dir>`: Sao chép thư mục.
- `mv <source> <destination>` (move): Di chuyển hoặc đổi tên file/thư mục.

### Quyền (Permissions) cơ bản

- Lệnh `ls -l` sẽ hiển thị quyền dạng `-rwxr-xr--`.
- `chmod <permissions> <file/directory>`: Thay đổi quyền.
  - Ví dụ: `chmod +x script.sh` (thêm quyền execute cho file script).
  - Ví dụ: `chmod 755 data_folder` (set quyền rwxr-xr-x).

### Một số lệnh hữu ích khác

- `cat <file_name>`: Xem nội dung file.
- `echo "text"`: In text ra màn hình.
  - `echo "text" > file.txt`: Ghi text vào file (ghi đè).
  - `echo "text" >> file.txt`: Ghi text vào cuối file (append).
- `grep "pattern" <file_name>`: Tìm kiếm text trong file.
- `find <directory> -name "<pattern>"`: Tìm kiếm file/thư mục.
- `apt update` / `apt install <package>` (Debian/Ubuntu) hoặc `yum update` / `yum install <package>` (CentOS/RHEL): Quản lý package (thường dùng trong `Dockerfile`).

## 3. 💡 Docker Core Concepts

```text
+----------------------+                         +------------------------------------------------------+                         +-----------------------+
|                      |                         |                    DOCKER HOST                       |                         |                       |
|    DOCKER CLIENT     |------------------------>|  +-----------------------------------------------+   |<------------------------|       REGISTRY        |
|  (e.g., `docker` CLI)|  1. Lệnh từ người dùng  |  |                 Docker Daemon                 |   |  3. Pull/Push Images    |  (e.g., Docker Hub,   |
|                      |  (build, run, pull,     |  |                   (`dockerd`)                 |   |                         |  AWS ECR, Google GCR) |
|                      |   push, ps, etc.)       |  |       (Lắng nghe API, Quản lý Objects)        |   |                         |                       |
+----------------------+                         |  +---------------------▲--┬----------------------+   |                         +-----------------------+
                                                 |                        |  |                          |
                                                 |     (Tải/Lưu Images)   |  | 2. Tạo/Chạy/Quản lý      |
                                                 |                        |  |    Containers từ Images  |
                                                 |                        |  |    Build Images từ       |
                                                 |                        |  |    Dockerfile            |
                                                 |                        |  |                          |
                                                 |  +---------------------┴--▼----------------------+   |
                                                 |  |       IMAGES          |       CONTAINERS      |   |
                                                 |  | (Templates Read-Only) | (Running Instances)   |   |
                                                 |  |  - ubuntu:latest      |  - my_app_container   |   |
                                                 |  |  - nginx:alpine       |  - db_container       |   |
                                                 |  |  - my_custom_app:v1   |  - ...                |   |
                                                 |  +-----------------------+-----------------------+   |
                                                 +------------------------------------------------------+

```

### Docker Engine

```text
  +-----------------+      +-----------------+      +-------------------------+
  |   Người dùng    |----->|   Docker CLI    |----->|        REST API         |<---+
  +-----------------+      |   (`docker`)    |      +-------------------------+    |
                           +-----------------+                                     |
                                                                                   |
                                +--------------------------------------------------+
                                |                 Docker Daemon                    |
                                |                 (`dockerd`) 🧠                   |
                                |  - Lắng nghe API requests                        |
                                |  - Quản lý Images, Containers, Networks, Volumes |
                                +--------------------------------------------------+
```

- **Docker Daemon (`dockerd`)**:
  - "Bộ não" 🧠 của Docker.
  - Chạy ngầm trên máy chủ.
  - Lắng nghe các yêu cầu từ Docker API.
  - Chịu trách nhiệm quản lý các đối tượng Docker như images, containers, networks, và volumes.
- **REST API**:
  - Một giao diện (interface) mà các chương trình có thể sử dụng để "nói chuyện" với Daemon.
  - Docker CLI sử dụng API này để gửi lệnh.
- **Docker CLI (`docker`)**:
  - Công cụ dòng lệnh (Command Line Interface) cho người dùng.
  - Bạn gõ lệnh `docker run`, `docker ps`, v.v., và CLI sẽ gửi yêu cầu tương ứng đến Daemon thông qua REST API.

### Image

- Là một **template read-only** (chỉ đọc), giống như một bản thiết kế hoặc một khuôn mẫu để tạo container.
- Chứa mọi thứ cần thiết để chạy một ứng dụng: mã nguồn, một runtime, thư viện, biến môi trường, và file cấu hình.
- Giống như một "snapshot" 📸 của một hệ thống file thu nhỏ.
- Images được xây dựng theo **lớp (layers)**. Mỗi lệnh trong Dockerfile tạo ra một lớp mới.
  - **Ví dụ về Layers:**

```text
+------------------------------------+  Layer 3 (Ứng dụng của bạn)
|         your_app_code              |
+------------------------------------+
|              nginx                 |  Layer 2 (Thêm Nginx)
+------------------------------------+
|              ubuntu                |  Layer 1 (Base Image)
+------------------------------------+
==> Final Image (ubuntu + nginx + your_app_code)
```

- Lợi ích của layers:
  - **Tái sử dụng**: Các lớp chung (như `ubuntu`) có thể được chia sẻ giữa nhiều image.
  - **Tối ưu lưu trữ**: Chỉ lưu trữ phần thay đổi ở mỗi lớp.
  - **Tốc độ build nhanh hơn**: Docker cache lại các lớp không thay đổi.

### Container

- Là một **phiên bản chạy (runnable instance)** của một Image.
- Khi bạn "chạy" một Image, bạn tạo ra một Container.
- Bạn có thể tạo, khởi động, dừng, di chuyển, và xóa Containers.
- Mỗi Container là một môi trường **isolated** (cô lập):

  - Nó có hệ thống file, process, network riêng.
  - Cô lập với các Containers khác và với máy chủ (host machine).
  - Tuy nhiên, tất cả Containers trên cùng một host **chia sẻ kernel của host**.

- **So sánh dễ hiểu:**
  - **Image** giống như một `Class` trong lập trình hướng đối tượng.
  - **Container** giống như một `Object` (thể hiện cụ thể) của `Class` đó.

```text
+-----------------------+         +-----------------------+
|     Image: my_app     |         |     Image: database   |
|  (Template Read-Only) |         |  (Template Read-Only) |
+-----------------------+         +-----------------------+
          |                                  |
          | .------------ chạy ------------. |
          V                                  V
+-----------------------+         +-----------------------+
|  Container A (my_app) |         | Container B (database)|
| (Isolated Environment)|         | (Isolated Environment)|
+-----------------------+         +-----------------------+

Trên cùng một Host Machine (chia sẻ Kernel)
```

### Dockerfile

- Là một **file text** đơn giản, không có phần mở rộng (nhưng thường đặt tên là `Dockerfile`).
- Chứa một chuỗi các **instructions** (chỉ dẫn) để Docker Engine tự động **build** (xây dựng) một Image.
- Giống như một "kịch bản" hoặc "công thức" để tạo ra Image.
- **Luồng làm việc:**
  `Dockerfile` --(`docker build . -t my_image_name`)--> `Image` 🖼️

### Registry (Docker Hub)

- Là một **kho lưu trữ (repository)** tập trung cho các Docker Images.
- Cho phép bạn lưu trữ, quản lý và chia sẻ Images.
- **Docker Hub**:
  - Là registry **công cộng** lớn nhất và mặc định của Docker.
  - Chứa hàng ngàn Images được tạo sẵn bởi cộng đồng và các nhà cung cấp (ví dụ: `ubuntu`, `nginx`, `python`, `mysql`).
  - Bạn có thể tạo tài khoản và push (đẩy) Image của mình lên Docker Hub (public hoặc private).
- **Private Registries**:
  - Bạn cũng có thể tự host registry riêng hoặc sử dụng các dịch vụ private registry từ các nhà cung cấp cloud.
  - Ví dụ: Amazon ECR (Elastic Container Registry), Google GCR (Google Container Registry), Azure ACR, Harbor.
- **Các lệnh cơ bản:**

  - `docker pull <image_name>:<tag>`: Tải (download) một Image từ Registry về máy local.

    ```text
    [Local Machine] <--- (docker pull ubuntu) --- [☁️ Docker Hub / Registry]
    ```

  - `docker push <your_username>/<image_name>:<tag>`: Đẩy (upload) một Image từ máy local lên Registry.

    ```text
    [Local Machine] --- (docker push myuser/myimage) ---> [☁️ Docker Hub / Registry]
    ```

  ```text
                             +-----------------------+
                             | Docker Hub / Registry |
                             | (e.g., AWS ECR, GCR)  |
                             +-----------┬-----------+
                                         |
                      docker pull <image>|  docker push <image>
                                         |
                   ┌─────────────────────┴─────────────────────┐
                   │                                           │
                   ▼                                           ▲
      +---------------------------+               +---------------------------+
      |      Local Machine 1      |               |      Local Machine 2      |
      | (Dev, CI/CD Server, etc.) |               | (Production Server, etc.) |
      +---------------------------+               +---------------------------+
  ```

## 4. ⚙️ Docker CLI Cơ Bản

Cú pháp chung: `docker [COMMAND] [OPTIONS] [ARGUMENTS]`

### Quản lý Images

- `docker images`: Liệt kê các images có trên local machine.
- `docker pull <image_name>:<tag>`: Tải image từ registry.
  - Ví dụ: `docker pull nginx:latest`
  - Ví dụ: `docker pull ubuntu:20.04`
- `docker rmi <image_id_or_name>`: Xóa một image.
  - `docker rmi $(docker images -q -f dangling=true)`: Xóa các image "dangling" (không được tag và không được container nào sử dụng).
- `docker build -t <image_name>:<tag> <path_to_dockerfile_directory>`: Build image từ Dockerfile.
  - Ví dụ: `docker build -t myapp:1.0 .` (dấu `.` là thư mục hiện tại)

### Quản lý Containers

- `docker run [OPTIONS] <image_name>:<tag> [COMMAND] [ARG...]`: Tạo và chạy một container mới từ image.
  - `docker run hello-world`: Chạy container `hello-world` đơn giản.
  - `docker run -d -p 8080:80 nginx`:
    - `-d` (detached): Chạy container ở background.
    - `-p 8080:80` (port mapping): Map port `8080` của host tới port `80` của container.
  - `docker run --name my_nginx -d -p 8081:80 nginx`: Đặt tên cho container là `my_nginx`.
  - `docker run -it ubuntu bash`: Chạy container `ubuntu` và mở terminal `bash` tương tác.
    - `-i` (interactive): Giữ STDIN mở.
    - `-t` (tty): Cấp một pseudo-TTY.
- `docker ps`: Liệt kê các container đang chạy.
  - `docker ps -a`: Liệt kê tất cả container (cả đang chạy và đã dừng).
- `docker stop <container_id_or_name>`: Dừng một container đang chạy.
- `docker start <container_id_or_name>`: Khởi động lại một container đã dừng.
- `docker rm <container_id_or_name>`: Xóa một container (phải dừng trước).
  - `docker rm -f <container_id_or_name>`: Xóa container (kể cả đang chạy - force).
  - `docker container prune`: Xóa tất cả các container đã dừng.

### Tương tác với Container

- `docker logs <container_id_or_name>`: Xem logs của container.
  - `docker logs -f <container_id_or_name>`: Theo dõi logs (follow).
- `docker exec -it <container_id_or_name> <command>`: Chạy một lệnh bên trong container đang chạy.
  - Ví dụ: `docker exec -it my_nginx bash` (mở shell `bash` trong container `my_nginx`).
- `docker cp <host_path> <container_id_or_name>:<container_path>`: Copy file/folder từ host vào container.
- `docker cp <container_id_or_name>:<container_path> <host_path>`: Copy file/folder từ container ra host.

## 5. 📝 Dockerfile: Công Thức Tạo Image

`Dockerfile` là file text không có đuôi, mặc định tên là `Dockerfile`.

### Các chỉ thị (Instructions) phổ biến

- `FROM <image>:<tag>`: Chỉ định base image. _Luôn là instruction đầu tiên._
  - Ví dụ: `FROM ubuntu:22.04`
  - Ví dụ: `FROM node:18-alpine`
- `WORKDIR /path/to/workdir`: Thiết lập thư mục làm việc cho các instruction tiếp theo (`RUN`, `CMD`, `ENTRYPOINT`, `COPY`, `ADD`).
  - Ví dụ: `WORKDIR /app`
- `COPY <src_on_host> <dest_in_image>`: Sao chép file/thư mục từ host vào image.
  - Ví dụ: `COPY . .` (sao chép toàn bộ nội dung thư mục build context vào WORKDIR)
  - Ví dụ: `COPY package.json .`
- `RUN <command>`: Thực thi lệnh trong một layer mới của image (thường dùng để cài đặt packages, dependencies).
  - Ví dụ: `RUN apt-get update && apt-get install -y nginx`
  - Ví dụ: `RUN npm install`
- `EXPOSE <port>`: Thông báo Docker rằng container sẽ lắng nghe trên port này khi chạy. _Không tự động publish port, cần `-p` khi `docker run`._
  - Ví dụ: `EXPOSE 80`
- `CMD ["executable","param1","param2"]` (exec form, ưu tiên) hoặc `CMD command param1 param2` (shell form): Cung cấp lệnh mặc định sẽ được thực thi khi container khởi động. _Chỉ có một `CMD` có hiệu lực, nếu có nhiều `CMD` thì `CMD` cuối cùng sẽ được dùng._ Có thể bị override bởi command khi `docker run`.
  - Ví dụ: `CMD ["nginx", "-g", "daemon off;"]`
  - Ví dụ: `CMD ["npm", "start"]`
- `ENTRYPOINT ["executable","param1","param2"]` (exec form, ưu tiên) hoặc `ENTRYPOINT command param1 param2` (shell form): Cấu hình container sẽ chạy như một executable. Các tham số truyền vào `docker run` sẽ được nối vào sau `ENTRYPOINT`. `CMD` có thể được dùng để cung cấp tham số mặc định cho `ENTRYPOINT`.
- `ENV <key>=<value>`: Thiết lập biến môi trường.
  - Ví dụ: `ENV NODE_ENV=production`

### Ví dụ Dockerfile đơn giản (Node.js App)

```dockerfile
# Sử dụng Node.js phiên bản 18-alpine làm base image
FROM node:18-alpine

# Thiết lập thư mục làm việc bên trong container
WORKDIR /usr/src/app

# Sao chép package.json và package-lock.json (nếu có)
COPY package*.json ./

# Cài đặt các dependencies
RUN npm install

# Sao chép toàn bộ source code của ứng dụng
COPY . .

# Thông báo port mà ứng dụng sẽ chạy trên đó
EXPOSE 3000

# Lệnh để chạy ứng dụng khi container khởi động
CMD [ "node", "server.js" ]
```

## 6. 🛠️ Thực Hành: Dockerize Ứng Dụng "Hello World" với Nginx

Mục tiêu: Tạo một `Dockerfile` để phục vụ một trang `index.html` đơn giản bằng `Nginx`.

1. **Tạo file `index.html`:**

   ```html
   <!-- index.html -->
   <!DOCTYPE html>
   <html>
     <head>
       <title>Hello Docker!</title>
     </head>
     <body>
       <h1>Hello from Nginx inside Docker!</h1>
       <p>This is my first Dockerized web page.</p>
     </body>
   </html>
   ```

2. **Tạo file `Dockerfile`:**

   ```dockerfile
   # Sử dụng Nginx image chính thức từ Docker Hub
   FROM nginx:alpine

   # Xóa file index.html mặc định của Nginx
   RUN rm /usr/share/nginx/html/index.html

   # Sao chép file index.html tùy chỉnh của chúng ta vào thư mục phục vụ web của Nginx
   COPY index.html /usr/share/nginx/html/

   # Expose port 80 (Nginx mặc định chạy trên port 80)
   EXPOSE 80

   # Lệnh mặc định để Nginx chạy ở foreground (cần thiết cho Docker)
   CMD ["nginx", "-g", "daemon off;"]
   ```

3. **Build Docker image:**
   Mở terminal trong thư mục chứa `index.html` và `Dockerfile`.

   ```bash
   docker build -t my-first-nginx .
   ```

   Kiểm tra image: `docker images` (bạn sẽ thấy `my-first-nginx`).

4. **Chạy container từ image vừa build:**

   ```bash
   docker run -d -p 8080:80 --name web_test my-first-nginx
   ```

   - `-d`: chạy background
   - `-p 8080:80`: map port 8080 của host tới port 80 của container
   - `--name web_test`: đặt tên cho container

5. **Kiểm tra:**
   Mở trình duyệt và truy cập `http://localhost:8080`. Bạn sẽ thấy trang "Hello Docker!".

6. **Dọn dẹp:**

   ```bash
   docker stop web_test
   docker rm web_test
   # docker rmi my-first-nginx # Nếu muốn xóa cả image
   ```

## 7. 🏋️ Bài Tập

**Yêu cầu:** Dockerize một ứng dụng web tĩnh đơn giản.

1. **Chuẩn bị:**

   - Tạo một thư mục mới cho bài tập, ví dụ `my-static-app`.
   - Bên trong thư mục đó, tạo một file `index.html` với nội dung HTML tùy ý của bạn (ví dụ: giới thiệu bản thân, một trang "Coming Soon" đơn giản, v.v.).
   - (Tùy chọn) Thêm một file CSS (`style.css`) và một hình ảnh (`logo.png`) và liên kết chúng từ `index.html`.

2. **Viết `Dockerfile`:**

   - Sử dụng một base image web server phù hợp (ví dụ: `nginx:alpine` hoặc `httpd:alpine`).
   - `COPY` các file tĩnh của bạn (`index.html`, `style.css`, `logo.png`) vào thư mục thích hợp của web server bên trong image (ví dụ: `/usr/share/nginx/html` cho Nginx, hoặc `/usr/local/apache2/htdocs/` cho httpd).
   - `EXPOSE` port mà web server lắng nghe (thường là port 80).
   - Đảm bảo web server chạy ở foreground khi container khởi động (tham khảo `CMD` của Nginx hoặc httpd).

3. **Build và Run:**

   - Build image với một tên và tag tùy chọn (ví dụ: `my-page:1.0`).
   - Chạy container từ image đó, map một port trên host (ví dụ: 9090) tới port 80 của container.
   - Truy cập trang web của bạn qua trình duyệt (`http://localhost:9090`).

4. **Thao tác thêm (optional):**
   - Xem logs của container.
   - Chạy một lệnh `ls` bên trong container đang chạy để kiểm tra xem file đã được copy đúng chỗ chưa (sử dụng `docker exec`).
   - Dừng và xóa container.

**Gợi ý:**

- Nếu dùng Nginx, bạn có thể cần `COPY` các file vào `/usr/share/nginx/html/`.
- Nếu dùng Apache httpd, bạn có thể cần `COPY` các file vào `/usr/local/apache2/htdocs/`.

---

[⬅️ Trở lại: PHP/Part6.md](../PHP/Part6.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: DEVOPS/Docker2.md](../DEVOPS/Docker2.md)
