# 🐳 DOCKER: ORCHESTRATION & BEST PRACTICES

- [🐳 DOCKER: ORCHESTRATION \& BEST PRACTICES](#-docker-orchestration--best-practices)
  - [🎯 Mục Tiêu](#-mục-tiêu)
  - [1. ⏪ Ôn Lại phần trước](#1--ôn-lại-phần-trước)
    - [Key Concepts: Image, Container, Dockerfile, Registry](#key-concepts-image-container-dockerfile-registry)
    - [Basic Docker CLI Commands](#basic-docker-cli-commands)
  - [2. 🚀 Giới Thiệu Docker Compose](#2--giới-thiệu-docker-compose)
    - [Tại sao cần Docker Compose? Vấn đề với nhiều `docker run`](#tại-sao-cần-docker-compose-vấn-đề-với-nhiều-docker-run)
    - [Docker Compose là gì?](#docker-compose-là-gì)
    - [Cài đặt Docker Compose](#cài-đặt-docker-compose)
  - [3. 🎼 Cú Pháp `docker-compose.yml`](#3--cú-pháp-docker-composeyml)
    - [`version`](#version)
    - [`services`](#services)
    - [`build` vs `image`](#build-vs-image)
    - [`ports`](#ports)
    - [`volumes`](#volumes)
    - [`environment`](#environment)
    - [`env_file`](#env_file)
    - [`depends_on`](#depends_on)
    - [`networks`](#networks)
    - [`command`](#command)
    - [`entrypoint`](#entrypoint)
    - [`restart`](#restart)
    - [`healthcheck`](#healthcheck)
    - [`expose`](#expose)
    - [`extends`](#extends)
    - [`secrets` và `configs`](#secrets-và-configs)
    - [Ví dụ `docker-compose.yml` đơn giản](#ví-dụ-docker-composeyml-đơn-giản)
    - [Các lệnh Docker Compose cơ bản](#các-lệnh-docker-compose-cơ-bản)
  - [4. 🔗 Docker Networking (với Compose)](#4--docker-networking-với-compose)
    - [Mạng mặc định (Default Bridge Network)](#mạng-mặc-định-default-bridge-network)
    - [Kết nối giữa các services (Service Discovery)](#kết-nối-giữa-các-services-service-discovery)
    - [Custom Networks](#custom-networks)
  - [5. 💾 Docker Volumes (với Compose)](#5--docker-volumes-với-compose)
    - [Tại sao cần Volumes? (Data Persistence)](#tại-sao-cần-volumes-data-persistence)
    - [Các loại Volumes trong Docker](#các-loại-volumes-trong-docker)
    - [Khai báo và sử dụng Volumes trong Compose](#khai-báo-và-sử-dụng-volumes-trong-compose)
  - [6. 🛠️ Thực Hành: Xây Dựng Ứng Dụng Web + Database + Cache với Docker Compose](#6-️-thực-hành-xây-dựng-ứng-dụng-web--database--cache-với-docker-compose)
  - [7. ✨ Best Practices \& Mẹo](#7--best-practices--mẹo)
    - [Dockerfile Best Practices (Nhắc lại và bổ sung)](#dockerfile-best-practices-nhắc-lại-và-bổ-sung)
    - [Docker Compose Best Practices](#docker-compose-best-practices)
    - [Sử dụng `.dockerignore`](#sử-dụng-dockerignore)
    - [Quản lý môi trường (Dev, Staging, Prod)](#quản-lý-môi-trường-dev-staging-prod)
  - [8. 🏋️ Bài Tập](#8-️-bài-tập)
  - [9. 📚 Tài Liệu Tham Khảo \& Next Steps](#9--tài-liệu-tham-khảo--next-steps)

---

## 🎯 Mục Tiêu

- Hiểu rõ vai trò, lợi ích của **Docker Compose** trong việc quản lý ứng dụng đa-container.
- Nắm vững cú pháp và các chỉ thị quan trọng của file `docker-compose.yml`.
- Biết cách định nghĩa và quản lý **services**, **networks**, và **volumes** một cách hiệu quả với Docker Compose.
- Thực hành xây dựng một ứng dụng **multi-container** phức tạp hơn, bao gồm web, database và caching.
- Tìm hiểu và áp dụng các **best practices** khi làm việc với Docker và Docker Compose để tối ưu hóa quy trình phát triển và triển khai.
- Hiểu cách Docker Compose đơn giản hóa việc thiết lập môi trường phát triển và đảm bảo tính nhất quán.

---

## 1. ⏪ Ôn Lại phần trước

### Key Concepts: Image, Container, Dockerfile, Registry

- **Image**: Template read-only, chứa mọi thứ cần để chạy ứng dụng (code, runtime, libraries, environment variables, config files). Được build từ Dockerfile.
- **Container**: Instance chạy của một image. Là một môi trường isolated, có filesystem, process, network riêng, nhưng chia sẻ kernel của Host OS.
- **Dockerfile**: File text chứa các instructions (lệnh) để Docker Engine tự động build một image.
- **Registry**: Kho lưu trữ và phân phối Docker images (VD: Docker Hub, AWS ECR, Google GCR).

### Basic Docker CLI Commands

- `docker build -t <name:tag> .`: Build image từ Dockerfile.
- `docker run [OPTIONS] <image>`: Chạy container từ image.
  - Options quan trọng: `-d` (detached), `-p HOST_PORT:CONTAINER_PORT`, `--name`, `-it` (interactive), `--rm` (auto-remove), `-v HOST_PATH:CONTAINER_PATH` (volume), `-e VAR=value`.
- `docker ps [-a]`: Liệt kê containers (đang chạy / tất cả).
- `docker images`: Liệt kê images.
- `docker stop/start/restart <container>`: Quản lý lifecycle container.
- `docker rm <container>`: Xóa container (phải dừng trước, hoặc dùng `-f`).
- `docker rmi <image>`: Xóa image (phải không có container nào dùng, hoặc dùng `-f`).
- `docker logs [-f] <container>`: Xem logs.
- `docker exec -it <container> <command>`: Chạy lệnh trong container đang chạy.
- `docker pull <image>` / `docker push <repo/image>`: Tương tác với registry.

## 2. 🚀 Giới Thiệu Docker Compose

### Tại sao cần Docker Compose? Vấn đề với nhiều `docker run`

Hãy tưởng tượng một ứng dụng web hiện đại thường bao gồm nhiều thành phần (services) phối hợp với nhau:

- Một `web server` (Nginx, Apache) để phục vụ static files hoặc làm reverse proxy.
- Một `application server` (Node.js, Python/Django/Flask, Java/Spring Boot, Ruby/Rails, PHP/Laravel) chứa business logic.
- Một `database` (PostgreSQL, MySQL, MongoDB, etc.) để lưu trữ dữ liệu.
- Có thể thêm một `caching service` (Redis, Memcached) để tăng tốc độ.
- Có thể thêm `message queue` (RabbitMQ, Kafka) cho xử lý bất đồng bộ.

Nếu dùng `docker run` cho từng service, bạn sẽ phải đối mặt với:

```bash
# Chạy database (VD: Postgres)
docker run -d --name my_db \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=appdb \
  -v db_data:/var/lib/postgresql/data \
  --network app_net \
  postgres:14-alpine

# Chạy backend app, link tới DB, expose port
# Cần đợi DB sẵn sàng, biết IP của DB (hoặc dùng Docker network và tên service)
docker run -d --name my_app \
  --network app_net \
  -p 3000:3000 \
  -e DATABASE_URL="postgresql://user:secret@my_db:5432/appdb" \
  -e NODE_ENV=development \
  -v ./app_src:/usr/src/app \
  my_backend_image:latest

# Chạy frontend (VD: Nginx phục vụ static files và proxy API)
docker run -d --name my_frontend \
  --network app_net \
  -p 80:80 \
  -v ./frontend_static:/usr/share/nginx/html \
  -v ./nginx.conf:/etc/nginx/nginx.conf:ro \
  nginx:alpine

# Và có thể còn nhiều services khác...
```

**Những khó khăn:**

- **Quá nhiều lệnh `docker run` dài và phức tạp:** Khó nhớ, dễ gõ sai.
- **Quản lý dependencies:** Service A cần Service B chạy trước và sẵn sàng (VD: app cần DB). `docker run` không có cơ chế `depends_on` rõ ràng.
- **Quản lý network:** Phải tự tạo Docker network (`docker network create app_net`) và kết nối các container vào đó để chúng thấy nhau.
- **Quản lý volumes:** Khai báo volumes cho từng service.
- **Cấu hình:** Truyền biến môi trường, mount config files cho từng service.
- **Khó chia sẻ và tái tạo:** Đưa cho đồng nghiệp một loạt lệnh `docker run` để setup môi trường là không hiệu quả và dễ lỗi.
- **Khó scale (ở mức cơ bản):** Muốn chạy nhiều instance của một service sẽ phức tạp.
- **Dừng và dọn dẹp:** Phải `docker stop` và `docker rm` từng container một.

Docker Compose được sinh ra để giải quyết tất cả những vấn đề này.

### Docker Compose là gì?

- Là một công cụ dòng lệnh (CLI tool) để **định nghĩa (define)** và **chạy (run)** các ứng dụng Docker **đa-container (multi-container)** một cách dễ dàng.
- Sử dụng một file cấu hình duy nhất viết bằng **YAML** (thường là `docker-compose.yml`) để mô tả toàn bộ "stack" ứng dụng của bạn, bao gồm:
  - Các `services` (tương ứng với các containers).
  - Cấu hình cho từng service: image nào để build/pull, ports, volumes, environment variables, dependencies, networks, etc.
  - `Networks` mà các services sẽ kết nối vào.
  - `Volumes` để lưu trữ dữ liệu bền bỉ.
- Với một lệnh duy nhất (ví dụ: `docker-compose up`), bạn có thể khởi tạo, cấu hình và chạy toàn bộ ứng dụng với tất cả các services liên quan.

**Lợi ích chính của Docker Compose:**

- **Đơn giản hóa quản lý:** Tất cả cấu hình nằm trong một file, dễ đọc, dễ hiểu, dễ quản lý.
- **Tái tạo môi trường nhất quán:** Đảm bảo môi trường phát triển, testing, staging giống nhau cho mọi thành viên trong team và trên các máy khác nhau.
- **Phát triển nhanh hơn:** Setup môi trường nhanh chóng, tập trung vào code thay vì loay hoay cấu hình.
- **Tích hợp tốt với Docker Engine:** Sử dụng các khái niệm Docker quen thuộc.
- **Quản lý vòng đời ứng dụng dễ dàng:** `up`, `down`, `start`, `stop`, `restart` toàn bộ stack hoặc từng service.
- **Cô lập môi trường:** Mỗi project Compose có thể chạy độc lập mà không ảnh hưởng đến nhau.

```text
                            +----------------------------+
                            |     docker-compose.yml     |
                            | (Định nghĩa App Stack)      |
                            +-------------+--------------+
                                          | (Input cho)
                                          v
+---------------------------------------+----------------------------------------+
|                               DOCKER COMPOSE CLI                               |
| (`docker-compose up`, `down`, `ps`, `logs`, `exec`, etc.)                      |
+---------------------------------------+----------------------------------------+
                                          | (Ra lệnh cho Docker Daemon)
                                          v
+--------------------------------------------------------------------------------+
|                                  DOCKER HOST                                   |
| +----------------------------------------------------------------------------+ |
| |                              Docker Daemon                                 | |
| |  (Tạo và quản lý containers, networks, volumes dựa trên docker-compose.yml) | |
| |                                                                            | |
| |  +------------------ Network: myproject_default ------------------------+  | |
| |  |                                                                      |  | |
| |  | +-----------------+  <-- communicates via service name --> +---------+ |  | |
| |  | | Service: web    |                                      | Service:db| |  | |
| |  | | (Container 1)   |                                      | (Cont. 3) | |  | |
| |  | | - Nginx/Node.js |  <-- communicates via service name --> +---------+ |  | |
| |  | | - Port 80 mapped|                                      | - Postgres| |  | |
| |  | +-----------------+  <-- communicates via service name --> +---------+ |  | |
| |  |         ^                                                  | Service:api| |  | |
| |  |         | (communicates via service name)                  | (Cont. 2) | |  | |
| |  |         +--------------------------------------------------+ - Python  | |  | |
| |  |                                                              +---------+ |  | |
| |  +--------------------------------------------------------------------------+  | |
| +----------------------------------------------------------------------------+ |
+--------------------------------------------------------------------------------+
  (Volume: myproject_db_data) <--- (Persists data for db service)
```

### Cài đặt Docker Compose

- **Docker Desktop (Windows, macOS):** Docker Compose thường được cài đặt sẵn cùng với Docker Desktop. Bạn không cần cài riêng.
- **Linux:**

  - Thường phải cài đặt riêng. Cách phổ biến là tải binary từ GitHub releases của Docker Compose.
  - Tham khảo hướng dẫn cài đặt chính thức: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)
  - Lệnh ví dụ (phiên bản có thể thay đổi, luôn kiểm tra trang chủ):

    ```bash
    # Tải phiên bản ổn định mới nhất
    LATEST_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
    sudo curl -L "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Kiểm tra cài đặt
    docker-compose --version
    ```

  - Một số bản phân phối Linux có thể cung cấp Docker Compose qua package manager (`apt`, `yum`), nhưng phiên bản có thể cũ hơn.

Lưu ý: `docker-compose` (có dấu gạch nối) là phiên bản V1. `docker compose` (không có dấu gạch nối) là phiên bản V2, được tích hợp trực tiếp vào Docker CLI. Hiện tại, V2 được khuyến khích sử dụng. Nếu Docker Desktop của bạn mới, `docker compose` sẽ hoạt động. Trên Linux, cài đặt trên có thể là V1 hoặc V2 tùy phiên bản. Về cơ bản, cú pháp file YAML và các lệnh chính là tương tự.

## 3. 🎼 Cú Pháp `docker-compose.yml`

File `docker-compose.yml` là một file text định dạng YAML, là trái tim của Docker Compose. YAML (YAML Ain't Markup Language) là một định dạng tuần tự hóa dữ liệu dễ đọc cho con người, sử dụng thụt đầu dòng (indentation) để biểu thị cấu trúc. **QUAN TRỌNG: YAML rất nhạy cảm với thụt đầu dòng. Luôn sử dụng spaces, không dùng tabs, và thụt đầu dòng nhất quán (thường là 2 spaces).**

File này thường nằm ở thư mục gốc của project.

### `version`

Chỉ định phiên bản của cú pháp file Compose mà bạn đang sử dụng. Điều này quan trọng vì các phiên bản khác nhau có thể hỗ trợ các tính năng và cú pháp khác nhau.

```yaml
version:
  "3.8" # Hoặc "3.9", "3.x". Nên dùng phiên bản mới nhất được Docker Engine của bạn hỗ trợ.
  # Version "2.x" cũ hơn, "3.x" phổ biến hiện nay.
  # Docker Compose V2 (docker compose) không yêu cầu version string, nhưng vẫn nên có.
```

### `services`

Đây là nơi bạn định nghĩa các thành phần (containers) của ứng dụng. Mỗi key dưới `services` là **tên của một service**. Tên này quan trọng vì nó sẽ được Docker Compose sử dụng để tham chiếu giữa các services (ví dụ: service `web` có thể kết nối đến service `db` bằng hostname `db`).

```yaml
services:
  web:# Tên service 1 (ví dụ:
    frontend hoặc web server)
    # ... cấu hình cho service 'web' ...
  api:# Tên service 2 (ví dụ:
    backend application)
    # ... cấu hình cho service 'api' ...
  db:# Tên service 3 (ví dụ:
    database)
    # ... cấu hình cho service 'db' ...
```

Dưới mỗi tên service, bạn sẽ khai báo các chi tiết cấu hình cho nó:

### `build` vs `image`

Chỉ định image Docker sẽ được sử dụng cho service. Bạn có thể dùng một trong hai (hoặc đôi khi cả hai).

- **`image: <image_name>:<tag>`**:
  Sử dụng một image đã có sẵn từ Docker Hub hoặc một private registry. Docker Compose sẽ `pull` image này nếu nó chưa có ở local.

  ```yaml
  services:
    database:
      image: postgres:14-alpine # Lấy image postgres phiên bản 14-alpine
    redis:
      image: redis:7-alpine
  ```

- **`build: <path_to_context>`** hoặc **`build: { context: <path>, dockerfile: <name>, args: ... }`**:
  Docker Compose sẽ build một image từ Dockerfile.
  - Dạng string đơn giản:

    ```yaml
    services:
      backend:
        build:
          ./app_folder # Đường dẫn đến thư mục chứa Dockerfile (build context)
          # Docker Compose sẽ tìm file tên 'Dockerfile' trong đó.
    ```

  - Dạng object để cung cấp thêm chi tiết:

    ```yaml
    services:
      backend:
        build:
          context: ./app_folder # Thư mục build context.
          dockerfile: Dockerfile.dev # Tên Dockerfile (nếu khác 'Dockerfile').
          args: # Các biến --build-arg truyền vào Dockerfile.
            NODE_VERSION: 18
            APP_ENV: development
          # target: builder          # (Tùy chọn) Chỉ build một stage cụ thể trong multi-stage Dockerfile.
          # cache_from:              # (Tùy chọn) Sử dụng cache từ các image khác.
          #   - myapp_cache:latest
    ```

  - Bạn có thể dùng cả `image` và `build`. Docker Compose sẽ build (nếu `build` được định nghĩa) và tag image đó với tên bạn cung cấp trong `image`. Nếu image đó đã tồn tại và bạn không yêu cầu build lại, nó sẽ dùng image đó.

  ```yaml
  services:
    custom_app:
      build: ./my_app_src
      image: myusername/my_custom_app:latest # Sau khi build, image sẽ được tag thế này
  ```

### `ports`

Ánh xạ ports giữa máy host và container. Định dạng: `"HOST_PORT:CONTAINER_PORT"`.
Nếu chỉ ghi `"CONTAINER_PORT"`, Docker sẽ tự động chọn một port ngẫu nhiên trên host.

```yaml
services:
  frontend:
    image: nginx:latest
    ports:
      - "8080:80" # Map port 8080 của host tới port 80 của container frontend.
      - "127.0.0.1:8081:81" # Map port 8081 của host (chỉ trên localhost) tới port 81 của container.
      # - "443:443"     # Map port 443 của host tới port 443 của container (cho HTTPS).
      # - "9000"        # Expose port 9000 của container ra một port ngẫu nhiên trên host.
```

### `volumes`

Mount (gắn) thư mục từ host vào container (bind mount) hoặc quản lý data volumes (named volumes) để lưu trữ dữ liệu bền bỉ.
Định dạng:

- Bind mount: `"HOST_PATH:CONTAINER_PATH"` hoặc `"HOST_PATH:CONTAINER_PATH:ro"` (read-only).
- Named volume: `"VOLUME_NAME:CONTAINER_PATH"`.
- Anonymous volume: `"CONTAINER_PATH"` (ít dùng trực tiếp trong compose, Docker tự quản lý).

```yaml
services:
  backend:
    build: ./backend_app
    volumes:
      # Bind mount: thay đổi code ở host -> thay đổi trong container (rất tiện cho dev)
      - ./backend_app/src:/app/src
      # Named volume: lưu trữ logs bền bỉ, tách biệt với lifecycle của container
      - app_logs:/app/logs
      # Anonymous volume (trong trường hợp này, để node_modules trong container không bị ghi đè bởi host)
      - /app/node_modules
  database:
    image: postgres:14
    volumes:
      # Named volume: lưu trữ data của DB, đảm bảo dữ liệu không mất khi container bị xóa/tạo lại
      - db_data:/var/lib/postgresql/data
      # Bind mount: mount file cấu hình tùy chỉnh
      - ./custom-postgres.conf:/etc/postgresql/postgresql.conf:ro

# Khai báo top-level named volumes (nếu không khai báo, Docker tự tạo với tên project_prefix)
volumes:
  db_data:# Docker sẽ tạo và quản lý volume tên là 'myproject_db_data' (nếu project tên myproject)
    # driver: local # Mặc định
    # external: true # Nếu volume đã được tạo bên ngoài Docker Compose
    # name: my_existing_db_data # Nếu dùng external volume với tên khác
  app_logs:
```

(Sẽ nói chi tiết hơn ở phần Docker Volumes)

### `environment`

Thiết lập biến môi trường cho container. Có nhiều cách khai báo:

- Dạng list (mảng các string `KEY=VALUE`):

  ```yaml
  services:
    api:
      image: my-api-image
      environment:
        - NODE_ENV=development
        - API_KEY=your_api_key_here
        - DATABASE_URL=postgresql://user:pass@db_service_name:5432/mydb
  ```

- Dạng map (dictionary `KEY: VALUE`):

  ```yaml
  services:
    api:
      image: my-api-image
      environment:
        NODE_ENV: development
        API_KEY: your_api_key_here # Giá trị có thể là số, boolean, hoặc string (nên để trong "" nếu có ký tự đặc biệt)
        DEBUG_MODE: "true"
  ```

- Tham chiếu từ file `.env` (file tên `.env` nằm cùng cấp với `docker-compose.yml`):
  Docker Compose tự động đọc file `.env` và các biến trong đó có thể được sử dụng trong `docker-compose.yml` bằng cú pháp `${VARIABLE_NAME}`.

  ```bash
  # .env file
  POSTGRES_USER=mysecretuser
  POSTGRES_PASSWORD=supersecretpassword123
  WEB_PORT=8000
  ```

  ```yaml
  # docker-compose.yml
  services:
    db:
      image: postgres
      environment:
        POSTGRES_USER: ${POSTGRES_USER} # Tham chiếu từ .env
        POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
        # POSTGRES_DB: ${POSTGRES_DB:-default_db_name} # Cú pháp với giá trị mặc định
    web:
      image: my_web_app
      ports:
        - "${WEB_PORT}:3000"
  ```

### `env_file`

Chỉ định một hoặc nhiều file chứa biến môi trường để load vào container. Mỗi dòng trong file phải theo định dạng `KEY=VALUE`.

```yaml
services:
  api:
    image: my-api
    env_file:
      - ./common.env # Đường dẫn tới file env chung
      - ./api.prod.env # File env cụ thể cho production (ghi đè giá trị từ common.env nếu trùng key)
      # - .env             # Có thể load cả file .env mặc định
```

**Thứ tự ưu tiên của biến môi trường:**

1. Giá trị được set trong `docker-compose.yml` (phần `environment`).
2. Giá trị được truyền qua CLI (`docker-compose run -e KEY=VAL ...`).
3. Giá trị từ `env_file`.
4. Giá trị từ file `.env` (nếu dùng `${VAR}` substitution).
5. Giá trị mặc định trong image (từ `ENV` trong Dockerfile).

### `depends_on`

Chỉ định thứ tự khởi động và phụ thuộc giữa các services. Service A `depends_on` Service B nghĩa là Docker Compose sẽ đảm bảo Service B được **khởi động** _trước_ Service A.
**Lưu ý quan trọng:** `depends_on` chỉ đảm bảo container của service phụ thuộc đã _khởi động_, **không đảm bảo** ứng dụng bên trong container đó đã _sẵn sàng_ để nhận kết nối (ví dụ: database cần thời gian để initialize, web server cần thời gian để load).

```yaml
services:
  api:
    build: ./api_app
    depends_on:
      - db # api sẽ khởi động sau khi container 'db' đã khởi động
      - redis # và sau khi container 'redis' đã khởi động
  db:
    image: postgres
  redis:
    image: redis
```

Để xử lý việc "chờ service sẵn sàng", bạn thường cần:

- Sử dụng `healthcheck` (xem bên dưới). `depends_on` có thể được cấu hình để chờ service phụ thuộc thành `healthy`.

  ```yaml
  services:
    api:
      build: ./api
      depends_on:
        db:
          condition: service_healthy # Chờ db báo healthy
    db:
      image: postgres
      healthcheck: # Cấu hình healthcheck cho db
        test: ["CMD-SHELL", "pg_isready -U postgres"]
        interval: 10s
        timeout: 5s
        retries: 5
  ```

- Hoặc dùng các script như `wait-for-it.sh` hoặc `dockerize` bên trong entrypoint/command của service phụ thuộc.

### `networks`

Cho phép services kết nối với nhau.

- **Mặc định:** Docker Compose tự động tạo một **default bridge network** cho tất cả services trong file. Tên network thường là `<project_name>_default` (project_name là tên thư mục chứa `docker-compose.yml`). Các services trong cùng network này có thể giao tiếp với nhau bằng tên service.
- **Custom networks:** Bạn có thể định nghĩa network riêng để kiểm soát tốt hơn.

```yaml
services:
  frontend:
    image: nginx
    networks: # Kết nối service 'frontend' vào network 'front-tier'
      - front-tier
  api:
    image: my-api
    networks: # Kết nối service 'api' vào cả 'front-tier' và 'back-tier'
      - front-tier
      - back-tier
  db:
    image: postgres
    networks: # Kết nối service 'db' chỉ vào 'back-tier' (tăng bảo mật)
      - back-tier

# Khai báo top-level networks
networks:
  front-tier:
    driver: bridge # Mặc định
  back-tier:
    driver: bridge
    # internal: true # (Tùy chọn) Nếu true, network này không có kết nối ra ngoài
```

(Sẽ nói chi tiết hơn ở phần Docker Networking)

### `command`

Ghi đè lệnh `CMD` mặc định được định nghĩa trong Dockerfile của image.

```yaml
services:
  worker:
    image: my-worker-image
    command: ["python", "process_queue.py", "--verbose"] # Ghi đè CMD của image
    # command: /app/start-worker.sh # Dạng shell
```

### `entrypoint`

Ghi đè `ENTRYPOINT` mặc định được định nghĩa trong Dockerfile của image.

```yaml
services:
  app:
    image: my-app-image
    entrypoint: /usr/local/bin/custom-entrypoint.sh
    # entrypoint: ["python", "manage.py"]
    # command: ["runserver", "0.0.0.0:8000"] # command trở thành đối số cho entrypoint mới
```

**Lưu ý:** Nếu bạn ghi đè `entrypoint`, `command` sẽ trở thành đối số cho `entrypoint` mới đó. Nếu bạn chỉ ghi đè `command`, nó sẽ là đối số cho `entrypoint` gốc của image (hoặc là lệnh chính nếu image không có `entrypoint`).

### `restart`

Chính sách khởi động lại container nếu nó bị dừng hoặc lỗi.

- `no`: (Mặc định) Không tự khởi động lại.
- `always`: Luôn khởi động lại container nếu nó dừng, trừ khi bị dừng một cách tường minh (bằng `docker stop` hoặc `docker-compose stop`).
- `on-failure`: Chỉ khởi động lại nếu container thoát với exit code khác 0 (lỗi).
  - `on-failure:5`: Khởi động lại tối đa 5 lần.
- `unless-stopped`: Luôn khởi động lại, trừ khi container bị dừng tường minh bởi người dùng hoặc Docker daemon bị dừng/khởi động lại.

```yaml
services:
  backend:
    image: my-backend
    restart: always # Luôn cố gắng chạy service này
  worker:
    image: my-worker
    restart: on-failure # Khởi động lại nếu worker bị lỗi
```

### `healthcheck`

Cấu hình kiểm tra "sức khỏe" cho service, tương tự `HEALTHCHECK` trong Dockerfile. Docker Compose sẽ sử dụng thông tin này để biết service có đang hoạt động bình thường không. Hữu ích khi kết hợp với `depends_on` và trong các môi trường orchestration.

```yaml
services:
  db:
    image: postgres:14
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB || exit 1",
        ]
      interval: 15s # Kiểm tra mỗi 15 giây
      timeout: 5s # Chờ tối đa 5 giây cho lệnh test hoàn thành
      retries: 3 # Thử lại 3 lần nếu thất bại
      start_period: 30s # Thời gian chờ ban đầu trước khi bắt đầu healthcheck (cho DB có thời gian khởi tạo)
    environment:
      POSTGRES_USER: user
      POSTGRES_DB: appdb
```

Trạng thái healthcheck có thể xem bằng `docker ps` hoặc `docker inspect`.

### `expose`

Expose ports của container **chỉ cho các services khác trong cùng network**, không publish ra host.
Hữu ích khi bạn có một service nội bộ (ví dụ: database) không cần truy cập từ bên ngoài host, nhưng các service khác trong Compose stack cần kết nối đến nó.

```yaml
services:
  db:
    image: mysql:8.0
    expose:
      - "3306" # Các service khác trong cùng network có thể kết nối đến 'db:3306'
    # ports: # Không dùng 'ports' nếu không muốn map ra host
    #  - "3306:3306" # Điều này sẽ map ra host
```

Thực tế, với default network của Docker Compose, các service đã có thể giao tiếp với nhau qua tên service và port mà ứng dụng trong container lắng nghe, ngay cả khi không có `expose`. `expose` chủ yếu mang tính tài liệu hóa hoặc khi dùng với các network driver khác.

### `extends`

Cho phép chia sẻ cấu hình chung giữa các services hoặc giữa các file Compose khác nhau.

```yaml
# common-services.yml
version: "3.8"
services:
  base_app:
    image: alpine
    environment:
      COMMON_VAR: "shared_value"
    logging:
      driver: "json-file"
      options:
        max-size: "200k"
        max-file: "10"
```

```yaml
# docker-compose.yml
version: "3.8"
services:
  web:
    extends:
      file: common-services.yml # File chứa cấu hình chung
      service: base_app # Tên service trong file đó để kế thừa
    build: ./web_app
    ports:
      - "80:8000"
    environment: # Ghi đè hoặc thêm biến môi trường
      APP_SPECIFIC_VAR: "web_value"
  worker:
    extends:
      file: common-services.yml
      service: base_app
    build: ./worker_app
    environment:
      APP_SPECIFIC_VAR: "worker_value"
```

### `secrets` và `configs`

(Nâng cao, thường dùng với Docker Swarm, nhưng Compose cũng hỗ trợ ở mức độ nào đó cho local dev)

- `secrets`: Quản lý dữ liệu nhạy cảm (passwords, API keys). Secrets được mount vào container dưới dạng file trong `/run/secrets/` (read-only).
- `configs`: Quản lý file cấu hình không nhạy cảm. Tương tự secrets, được mount vào container.

```yaml
version: "3.8"
services:
  myapp:
    image: myapp:latest
    secrets:
      - db_password
    configs:
      - app_config
secrets:
  db_password:
    file: ./db_password.txt # File trên host chứa password
    # external: true # Nếu secret đã được tạo trong Docker
configs:
  app_config:
    file: ./app_config.json
    # external: true
```

Trong container, `db_password` sẽ có tại `/run/secrets/db_password` và `app_config` tại `/run/configs/app_config` (hoặc tên file gốc nếu dùng `target`).

### Ví dụ `docker-compose.yml` đơn giản

Ứng dụng gồm một web app (Node.js) và một Redis instance.

```yaml
version: "3.8" # Luôn khai báo version

services:
  # Service 1: Web application (ví dụ: Node.js app)
  web:
    build: ./app # Thư mục chứa Dockerfile của app (ví dụ: ./app/Dockerfile)
    image: myusername/my-web-app:1.0 # (Tùy chọn) Tên image sau khi build
    container_name: my_web_container # (Tùy chọn) Tên cụ thể cho container
    ports:
      - "3000:3000" # Map port 3000 của host tới port 3000 của container
    volumes:
      # Mount source code từ thư mục 'app' trên host vào '/usr/src/app' trong container
      # Giúp live reload khi code thay đổi (cho môi trường dev)
      - ./app:/usr/src/app
      # Mount anonymous volume cho node_modules để không bị ghi đè bởi node_modules trên host (nếu có)
      # Điều này đảm bảo node_modules được cài đặt bởi 'RUN npm install' trong Dockerfile được sử dụng.
      - /usr/src/app/node_modules
    environment:
      - NODE_ENV=development
      - REDIS_HOST=cache # Tên service của Redis
      - REDIS_PORT=6379
    depends_on: # web app phụ thuộc vào Redis
      - cache # Đảm bảo 'cache' service khởi động trước 'web'
    restart: unless-stopped

  # Service 2: Redis (caching)
  cache: # Tên service là 'cache', web app sẽ kết nối tới Redis qua hostname 'cache'
    image: "redis:7-alpine" # Sử dụng image Redis chính thức từ Docker Hub
    container_name: my_redis_cache
    # ports: # Không nhất thiết phải expose port Redis ra host nếu chỉ app nội bộ dùng
    #   - "6379:6379" # Ví dụ nếu muốn kết nối từ host vào Redis này để debug
    volumes:
      - redis_data:/data # Sử dụng named volume 'redis_data' để lưu trữ dữ liệu Redis bền bỉ
    restart: always
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 3

# Khai báo named volumes ở top-level
volumes:
  redis_data:# Docker Compose sẽ tự tạo volume này (nếu chưa có) với tên project_redis_data
  # driver: local # (Mặc định)
```

**Cấu trúc thư mục ví dụ cho ví dụ trên:**

```text
my_project/
├── docker-compose.yml
├── .env               # (Tùy chọn) Chứa các biến môi trường chung
└── app/
    ├── Dockerfile
    ├── package.json
    └── server.js
    └── ... (các file khác của app)
```

### Các lệnh Docker Compose cơ bản

Chạy các lệnh này từ thư mục chứa file `docker-compose.yml`.

- `docker-compose up`: Build (nếu `build` được định nghĩa và image chưa có hoặc cần build lại), tạo và khởi động tất cả các services. Logs của tất cả services sẽ được stream ra terminal. Nhấn `Ctrl+C` để dừng.
  - `docker-compose up -d`: Chạy ở background (detached mode).
  - `docker-compose up --build`: Luôn build lại images trước khi khởi động (kể cả khi image đã tồn tại).
  - `docker-compose up <service_name> [<service_name2>...]`: Chỉ khởi động các service được chỉ định (và các dependencies của chúng).
- `docker-compose down`: Dừng và xóa containers, networks, (tùy chọn) volumes.
  - `docker-compose down -v`: Xóa cả named volumes được định nghĩa trong `volumes` section (và anonymous volumes). **CẨN THẬN: Mất dữ liệu trong volumes!**
  - `docker-compose down --rmi all`: Xóa cả images được build bởi Compose.
  - `docker-compose down --remove-orphans`: Xóa các container không còn được định nghĩa trong compose file.
- `docker-compose ps`: Liệt kê trạng thái của các containers do Compose quản lý cho project hiện tại.
- `docker-compose logs <service_name>`: Xem logs của một service cụ thể.
  - `docker-compose logs -f <service_name>`: Theo dõi logs (live stream).
  - `docker-compose logs --tail=50 <service_name>`: Xem 50 dòng log cuối.
  - `docker-compose logs`: Xem logs của tất cả services.
- `docker-compose exec <service_name> <command>`: Chạy một lệnh bên trong một service **đang chạy**.
  - Ví dụ: `docker-compose exec web bash` (mở bash shell trong service `web`).
  - Ví dụ: `docker-compose exec db psql -U myuser -d mydb`
- `docker-compose build <service_name>`: Build (hoặc rebuild) image cho một hoặc nhiều service. Nếu không có `service_name`, build tất cả.
  - `docker-compose build --no-cache <service_name>`: Build không dùng cache.
- `docker-compose pull <service_name>`: Pull image mới nhất cho một hoặc nhiều service (nếu service đó dùng `image:`).
- `docker-compose start <service_name>`: Khởi động các service đã được tạo nhưng đang dừng.
- `docker-compose stop <service_name>`: Dừng các service đang chạy mà không xóa chúng.
- `docker-compose restart <service_name>`: Khởi động lại các service.
- `docker-compose rm <service_name>`: Xóa các container đã dừng của service.
  - `docker-compose rm -f <service_name>`: Xóa kể cả đang chạy.
- `docker-compose run --rm <service_name> <command>`: Chạy một container "one-off" cho một service (thường để chạy task, test). `--rm` tự xóa sau khi chạy xong. Lệnh này sẽ không map ports đã định nghĩa trong `ports` (trừ khi dùng `--service-ports`).
  - Ví dụ: `docker-compose run --rm web npm test`
- `docker-compose config`: Kiểm tra cú pháp file `docker-compose.yml` và hiển thị cấu hình đã được tính toán (sau khi đã xử lý `extends`, `env_file`, biến môi trường, etc.). Rất hữu ích để debug file compose.
  - `docker-compose -f docker-compose.yml -f docker-compose.override.yml config`: Xem cấu hình kết hợp từ nhiều file.
- `docker-compose top <service_name>`: Hiển thị các process đang chạy trong service.

(Lưu ý: Nếu bạn dùng Docker Compose V2, các lệnh sẽ là `docker compose ...` thay vì `docker-compose ...`)

## 4. 🔗 Docker Networking (với Compose)

Docker Compose giúp việc quản lý network cho ứng dụng đa-container trở nên rất đơn giản.

### Mạng mặc định (Default Bridge Network)

- Khi bạn chạy `docker-compose up` lần đầu cho một project (một thư mục chứa `docker-compose.yml`), Compose sẽ tự động tạo một **user-defined bridge network** mặc định cho ứng dụng đó.
- Tên của network này thường được đặt theo quy tắc: `<project_name>_default`.
  - `<project_name>` là tên của thư mục chứa `docker-compose.yml` (ví dụ: nếu thư mục là `my_app`, network sẽ là `my_app_default`). Bạn có thể ghi đè tên project bằng option `-p <custom_project_name>` hoặc biến môi trường `COMPOSE_PROJECT_NAME`.
- Tất cả các `services` được định nghĩa trong file `docker-compose.yml` sẽ tự động được kết nối vào network mặc định này.

### Kết nối giữa các services (Service Discovery)

- Đây là một trong những tính năng mạnh mẽ nhất của Docker Compose networking.
- Bên trong network này, các containers (services) có thể **tham chiếu và kết nối lẫn nhau bằng tên service** đã định nghĩa trong `docker-compose.yml`.
- Docker Engine cung cấp một **DNS server nội bộ** cho network này. Khi service `web` muốn kết nối đến service `db`, nó chỉ cần dùng hostname là `db`. Docker DNS sẽ tự động phân giải (resolve) tên `db` thành địa chỉ IP nội bộ của container đang chạy service `db`.
  - Ví dụ: Trong code của service `web` (Node.js), chuỗi kết nối database có thể là:
    `const dbUrl = "postgres://user:password@db:5432/mydb";`
    (Với `db` là tên service của PostgreSQL trong `docker-compose.yml`).
- **Bạn không cần phải `expose` (hay `ports`) port của service nội bộ (như database, redis) ra host machine nếu chỉ có các service khác trong cùng Compose network cần truy cập.** Điều này giúp tăng cường bảo mật. Chỉ `ports` những service cần truy cập từ bên ngoài (thường là web server/frontend).

**Sơ đồ minh họa:**

```text
  Host Machine (Ví dụ: IP 192.168.1.100)
  ---------------------------------------------------------------------------------
  |                                                                               |
  |   Docker Network: myproject_default (VD: 172.18.0.0/16)                       |
  |   -------------------------------------------------------------------------   |
  |   | Service: web (Container A)                                            |   |
  |   | - IP nội bộ: 172.18.0.2                                               |   |
  |   | - Code kết nối: connect_to('api:5000'), connect_to('db:5432')         |   |
  |   | - Mapped port: Host:8080 -> Container:80 (Truy cập từ ngoài vào đây)  |   |
  |   -------------------------------------------------------------------------   |
  |   | Service: api (Container B)                                            |   |
  |   | - IP nội bộ: 172.18.0.3                                               |   |
  |   | - Lắng nghe trên port 5000 (nội bộ)                                   |   |
  |   | - Code kết nối: connect_to('db:5432')                                 |   |
  |   -------------------------------------------------------------------------   |
  |   | Service: db (Container C)                                             |   |
  |   | - IP nội bộ: 172.18.0.4                                               |   |
  |   | - Lắng nghe trên port 5432 (nội bộ, không map ra host)                |   |
  |   -------------------------------------------------------------------------   |
  |                                                                               |
  ---------------------------------------------------------------------------------
  Người dùng truy cập http://localhost:8080 hoặc http://192.168.1.100:8080
      -> Host OS chuyển đến Container A (web) port 80
          -> Container A (web) có thể gọi Container B (api) qua 'api:5000'
          -> Container B (api) có thể gọi Container C (db) qua 'db:5432'
```

### Custom Networks

Bạn cũng có thể định nghĩa các network tùy chỉnh trong `docker-compose.yml` để:

- Tạo nhiều network và kết nối các service vào các network khác nhau để cô lập (ví dụ: `frontend_net`, `backend_net`).
- Kết nối với các network đã tồn tại bên ngoài Docker Compose.
- Tinh chỉnh driver hoặc options của network.

```yaml
version: "3.8"
services:
  proxy:
    image: nginx
    networks:
      - frontnet # Chỉ kết nối vào frontnet
    ports:
      - "80:80"
  app:
    build: ./app
    networks:
      - frontnet
      - backnet # Kết nối vào cả frontnet và backnet
  db:
    image: postgres
    networks:
      - backnet # Chỉ kết nối vào backnet

networks:
  frontnet:
    driver: bridge
    # driver_opts:
    #   com.docker.network.enable_ipv6: "true"
  backnet:
    driver: bridge
    internal: true # Network này không có kết nối ra ngoài Internet, tăng bảo mật cho DB.
  # existing_net: # Kết nối tới network đã tồn tại
  #   external: true
  #   name: my_preexisting_bridge_network
```

Trong ví dụ này:

- `proxy` và `app` có thể giao tiếp với nhau qua `frontnet`.
- `app` và `db` có thể giao tiếp với nhau qua `backnet`.
- `proxy` không thể trực tiếp giao tiếp với `db`.

## 5. 💾 Docker Volumes (với Compose)

### Tại sao cần Volumes? (Data Persistence)

- Containers là **ephemeral** (tạm thời, có tính chất "thoáng qua"). Khi một container bị xóa (`docker rm` hoặc `docker-compose down`), mọi dữ liệu được ghi vào filesystem của nó (lớp writable trên cùng của container) sẽ bị **mất vĩnh viễn**.
- Điều này không thành vấn đề với các stateless application server, nhưng lại là thảm họa đối với:
  - **Databases:** Dữ liệu là tài sản quý giá.
  - **User uploads:** Hình ảnh, tài liệu người dùng tải lên.
  - **Logs quan trọng:** Cần lưu trữ để phân tích, gỡ lỗi.
  - **File cấu hình:** Cần được duy trì qua các lần khởi động lại container.
- **Volumes** là cơ chế của Docker để **lưu trữ dữ liệu một cách bền bỉ (persistently)**, tách biệt khỏi vòng đời của container. Dữ liệu trong volume vẫn tồn tại ngay cả khi container sử dụng nó bị xóa và tạo lại.

### Các loại Volumes trong Docker

Docker hỗ trợ một số loại volumes/mounts:

1. **Bind Mounts**:

    - **Khái niệm:** Mount (gắn) một file hoặc thư mục từ **filesystem của máy host** vào một đường dẫn bên trong container.
    - **Đặc điểm:**
      - Rất tiện cho development: Bạn sửa code trên host, thay đổi đó được phản ánh ngay lập tức vào container, hỗ trợ live-reloading.
      - Dữ liệu được quản lý trực tiếp trên host.
      - Đường dẫn trên host phải tồn tại (hoặc Docker sẽ tạo thư mục rỗng).
      - Có thể gây vấn đề về performance trên một số OS (macOS, Windows do cơ chế chia sẻ file).
      - Vấn đề về quyền (permissions): UID/GID của file trên host có thể không khớp với user bên trong container, gây lỗi permission denied.
    - **Cú pháp trong Compose:** `- ./path/on/host:/path/in/container` hoặc `- ./path/on/host:/path/in/container:ro` (read-only).

2. **Named Volumes (hoặc chỉ là "Volumes")**:

    - **Khái niệm:** Volumes được **Docker quản lý hoàn toàn**. Dữ liệu được lưu trữ trong một phần đặc biệt của host filesystem do Docker quản lý (thường là `/var/lib/docker/volumes/` trên Linux). Bạn không cần quan tâm đến vị trí chính xác này.
    - **Đặc điểm:**
      - **Cách được khuyến khích để lưu trữ dữ liệu ứng dụng bền bỉ** (VD: database data, logs).
      - Độc lập với cấu trúc thư mục của host.
      - Dễ dàng backup, migrate, chia sẻ giữa các containers.
      - Performance tốt hơn bind mounts trên macOS và Windows.
      - Docker tự tạo volume nếu chưa tồn tại.
      - Có thể được quản lý bằng các lệnh `docker volume ...` (create, ls, inspect, rm, prune).
    - **Cú pháp trong Compose:** `- volume_name:/path/in/container`. `volume_name` được khai báo ở top-level `volumes:` section.

3. **Anonymous Volumes**:

    - **Khái niệm:** Tương tự named volumes, nhưng Docker tự gán một tên ngẫu nhiên (một chuỗi hash dài) cho volume đó.
    - **Đặc điểm:**
      - Khó tham chiếu lại nếu bạn không biết tên ngẫu nhiên của nó.
      - Thường được tạo khi bạn chỉ định đường dẫn container trong `Dockerfile` (`VOLUME /app/data`) hoặc trong `docker-compose.yml` (`- /app/data`) mà không đặt tên cho volume.
      - Dữ liệu vẫn bền bỉ, nhưng khó quản lý hơn named volumes.
      - Sẽ bị xóa bởi `docker-compose down -v` hoặc `docker volume prune`.
    - **Cú pháp trong Compose (ít dùng trực tiếp):** `- /path/in/container`

4. **tmpfs Mounts (Linux only)**:
    - **Khái niệm:** Mount một thư mục vào bộ nhớ RAM của container, không ghi xuống đĩa.
    - **Đặc điểm:**
      - Dữ liệu rất nhanh nhưng **hoàn toàn không bền bỉ**. Mất khi container dừng.
      - Hữu ích cho việc lưu trữ file tạm thời, nhạy cảm mà bạn không muốn ghi ra disk.
    - **Cú pháp trong Compose:**

      ```yaml
      services:
        myservice:
          image: ...
          tmpfs: /app/tmp # Mount /app/tmp vào RAM
          # tmpfs:
          #  - /run
          #  - /tmp:size=100m,mode=755 # Có thể set size và mode
      ```

**Khi nào dùng cái nào?**

- **Named Volumes:** **Ưu tiên hàng đầu** cho dữ liệu ứng dụng cần tính bền bỉ và độc lập với host (database data, user uploads, logs quan trọng, state của ứng dụng).
- **Bind Mounts:**
  - **Source code trong môi trường development:** Để live-reloading, thay đổi code trên host và thấy ngay kết quả trong container.
  - **File cấu hình (config files):** Mount file config từ host vào container để dễ dàng thay đổi mà không cần build lại image.
  - **Chia sẻ file giữa host và container:** Ví dụ, build artifacts từ container ra host.
- **Anonymous Volumes:** Tránh sử dụng chủ động. Nếu bạn cần dữ liệu bền bỉ, hãy dùng named volume. Một trường hợp sử dụng phổ biến là `- /app/node_modules` để ngăn bind mount của source code ghi đè lên `node_modules` đã được `RUN npm install` trong image.
- **tmpfs Mounts:** Cho dữ liệu tạm thời, không cần lưu trữ, hoặc dữ liệu nhạy cảm.

### Khai báo và sử dụng Volumes trong Compose

Đã được minh họa một phần ở trên.

1. **Khai báo Named Volumes ở top-level `volumes:` section:**
    Đây là nơi bạn định nghĩa các named volumes mà các services của bạn sẽ sử dụng.

    ```yaml
    version: "3.8"
    # ... services ...

    volumes:
      postgres_data: # Tên volume bạn sẽ tham chiếu trong service
        driver: local # (Mặc định) Driver cho volume, thường là 'local'
        # external: true # Đặt là true nếu volume này đã được tạo bên ngoài compose (bằng docker volume create)
        # name: my_actual_external_volume_name # Tên thực tế của external volume
        # driver_opts:
        #   type: "nfs"
        #   o: "addr=192.168.1.1,rw"
        #   device: ":/path/to/nfs/share"
      mysql_data:
      app_uploads:
    ```

2. **Sử dụng Volumes trong `services.<service_name>.volumes`:**
    Trong mỗi service, bạn khai báo các volumes mà nó sẽ sử dụng.

    ```yaml
    services:
      db_postgres:
        image: postgres:14
        volumes:
          # Sử dụng named volume 'postgres_data' đã khai báo ở top-level
          # Mount vào /var/lib/postgresql/data bên trong container
          - postgres_data:/var/lib/postgresql/data
          # Bind mount file cấu hình từ host
          - ./config/postgres/custom.conf:/etc/postgresql/postgresql.conf:ro
          # Bind mount script khởi tạo DB (chạy một lần)
          - ./init-db.sh:/docker-entrypoint-initdb.d/init-db.sh

      db_mysql:
        image: mysql:8
        volumes:
          - mysql_data:/var/lib/mysql # Named volume

      web_app:
        build: ./my_web_app_src
        volumes:
          # Bind mount source code cho development
          - ./my_web_app_src:/usr/src/app
          # Named volume cho user uploads
          - app_uploads:/usr/src/app/public/uploads
          # Anonymous volume để bảo vệ node_modules trong image
          - /usr/src/app/node_modules
    ```

## 6. 🛠️ Thực Hành: Xây Dựng Ứng Dụng Web + Database + Cache với Docker Compose

**Mục tiêu:** Tạo một ứng dụng web Node.js/Express đơn giản có các tính năng:

1. Hiển thị một bộ đếm số lượt truy cập trang.
2. Lưu trữ và truy xuất bộ đếm này từ Redis (cache).
3. Nếu Redis không có, hoặc khi khởi động lại, sẽ lấy giá trị từ PostgreSQL (database) và cập nhật vào Redis.
4. Khi trang được truy cập, tăng bộ đếm, lưu vào Redis và (bất đồng bộ) vào PostgreSQL.

**Cấu trúc thư mục dự kiến:**

```text
compose_advanced_practice/
├── docker-compose.yml
├── .env                 # Chứa credentials cho DB
└── web_app/
    ├── Dockerfile
    ├── package.json
    ├── server.js
    └── init_db.sql      # (Tùy chọn) Script SQL để khởi tạo bảng
```

**1. `web_app/package.json`:**
(Chạy `cd web_app && npm init -y && npm install express redis pg`)

```json
{
  "name": "web-app-db-redis",
  "version": "1.0.0",
  "description": "Node.js app with Postgres and Redis",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "dependencies": {
    "express": "^4.18.1",
    "redis": "^4.6.7", // Redis client v4 sử dụng Promises
    "pg": "^8.11.0" // PostgreSQL client
  },
  "devDependencies": {
    "nodemon": "^2.0.15" // (Tùy chọn) Cho live reload khi dev
  }
}
```

**2. `web_app/server.js`:**

```javascript
// web_app/server.js
const express = require("express");
const redis = require("redis");
const { Pool } = require("pg");

const app = express();
const PORT = process.env.PORT || 3000;

// --- Cấu hình Redis Client (v4) ---
const redisClient = redis.createClient({
  socket: {
    host: process.env.REDIS_HOST || "localhost", // Sẽ là 'cache_service' từ docker-compose
    port: process.env.REDIS_PORT || 6379,
  },
});

redisClient.on("error", (err) => console.error("Redis Client Error", err));
(async () => {
  await redisClient.connect();
  console.log("Connected to Redis!");
})();

// --- Cấu hình PostgreSQL Client ---
const pgPool = new Pool({
  user: process.env.POSTGRES_USER,
  host: process.env.POSTGRES_HOST, // Sẽ là 'db_service' từ docker-compose
  database: process.env.POSTGRES_DB,
  password: process.env.POSTGRES_PASSWORD,
  port: process.env.POSTGRES_PORT || 5432,
});

pgPool.on("connect", () => console.log("Connected to PostgreSQL!"));
pgPool.on("error", (err) => console.error("PostgreSQL Client Error", err));

// --- Hàm khởi tạo bảng nếu chưa có ---
async function initializeDatabase() {
  try {
    await pgPool.query(`
      CREATE TABLE IF NOT EXISTS visit_counts (
        id VARCHAR(255) PRIMARY KEY DEFAULT 'page_visits',
        count INTEGER NOT NULL DEFAULT 0
      );
    `);
    // Chèn dòng mặc định nếu chưa có
    await pgPool.query(`
      INSERT INTO visit_counts (id, count)
      VALUES ('page_visits', 0)
      ON CONFLICT (id) DO NOTHING;
    `);
    console.log("Database table 'visit_counts' initialized or already exists.");
  } catch (err) {
    console.error("Error initializing database table:", err);
  }
}

// --- Logic chính ---
const COUNTER_KEY = "page_visits_counter";

app.get("/", async (req, res) => {
  let visits = 0;
  try {
    // 1. Thử lấy từ Redis
    const redisVisits = await redisClient.get(COUNTER_KEY);

    if (redisVisits !== null) {
      visits = parseInt(redisVisits, 10);
    } else {
      // 2. Nếu không có trong Redis, lấy từ DB
      const dbResult = await pgPool.query(
        "SELECT count FROM visit_counts WHERE id = 'page_visits'"
      );
      if (dbResult.rows.length > 0) {
        visits = dbResult.rows[0].count;
      } else {
        // Fallback nếu DB cũng chưa có (dù init_db nên xử lý việc này)
        visits = 0;
        await pgPool.query(
          "INSERT INTO visit_counts (id, count) VALUES ('page_visits', 0) ON CONFLICT (id) DO UPDATE SET count = 0"
        );
      }
      // Cập nhật vào Redis
      await redisClient.set(COUNTER_KEY, visits);
      console.log("Loaded visits from DB to Redis:", visits);
    }

    // 3. Tăng bộ đếm
    visits++;

    // 4. Lưu lại vào Redis
    await redisClient.set(COUNTER_KEY, visits);

    // 5. (Bất đồng bộ) Lưu vào DB
    pgPool
      .query("UPDATE visit_counts SET count = $1 WHERE id = 'page_visits'", [
        visits,
      ])
      .catch((err) => console.error("Error updating DB:", err));

    res.send(
      `<h1>Hello Docker Universe!</h1><p>This page has been visited ${visits} times.</p><p>Counter updated in Redis and (eventually) PostgreSQL.</p>`
    );
  } catch (error) {
    console.error("Error processing request:", error);
    res.status(500).send("Oops, something went wrong! Check server logs.");
  }
});

// --- Khởi động server ---
app.listen(PORT, async () => {
  await initializeDatabase(); // Đảm bảo bảng tồn tại khi server khởi động
  console.log(`Web app listening on port ${PORT}`);
});
```

**3. `web_app/Dockerfile`:**

```dockerfile
FROM node:18-alpine

WORKDIR /usr/src/app

# Copy package.json và package-lock.json (nếu có)
COPY package*.json ./

# Cài đặt dependencies (bao gồm devDependencies nếu không có --production)
# Trong môi trường dev, có thể muốn cả devDependencies (như nodemon)
RUN npm install

# Copy toàn bộ source code
COPY . .

# Expose port mà ứng dụng chạy
EXPOSE 3000

# Lệnh để chạy ứng dụng (sử dụng nodemon nếu có trong devDependencies và là môi trường dev)
# Bạn có thể truyền biến môi trường NODE_ENV từ docker-compose.yml
# CMD if [ "$NODE_ENV" = "development" ]; then npm run dev; else npm start; fi
# Hoặc đơn giản hơn:
CMD [ "npm", "start" ]
```

**4. `web_app/init_db.sql` (Tùy chọn, nếu bạn muốn Postgres tự chạy script này):**

```sql
-- web_app/init_db.sql
-- Script này không cần thiết nếu server.js tự tạo bảng, nhưng là một cách khác.
CREATE TABLE IF NOT EXISTS visit_counts (
  id VARCHAR(255) PRIMARY KEY DEFAULT 'page_visits',
  count INTEGER NOT NULL DEFAULT 0
);

INSERT INTO visit_counts (id, count)
VALUES ('page_visits', 0)
ON CONFLICT (id) DO NOTHING;

-- Bạn có thể thêm các bảng khác ở đây
-- CREATE TABLE IF NOT EXISTS users (...);
```

**5. `.env` file (trong thư mục `compose_advanced_practice`):**

```env
# .env
# Credentials cho PostgreSQL
POSTGRES_USER=dockeruser
POSTGRES_PASSWORD=dockerpass
POSTGRES_DB=appdb
POSTGRES_PORT=5432 # Port bên trong container DB

# Config cho App
NODE_ENV=development
PORT=3000 # Port app lắng nghe bên trong container

# Config cho Redis (không cần credentials cho ví dụ này)
REDIS_HOST=cache_service # Tên service của Redis trong docker-compose
REDIS_PORT=6379
```

**6. `docker-compose.yml` (trong thư mục `compose_advanced_practice`):**

```yaml
version: "3.8"

services:
  # Web Application Service
  app:
    build: ./web_app
    container_name: node_app_service
    ports:
      - "${PORT}:${PORT}" # Sử dụng biến PORT từ .env cho host, map tới PORT trong container
    volumes:
      - ./web_app:/usr/src/app # Mount source code cho live reload
      - /usr/src/app/node_modules # Anonymous volume để giữ node_modules của image
    environment: # Truyền các biến môi trường cần thiết cho app
      NODE_ENV: ${NODE_ENV}
      PORT: ${PORT}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_HOST: db_service # Tên service của PostgreSQL
      POSTGRES_PORT: ${POSTGRES_PORT} # Port PostgreSQL lắng nghe BÊN TRONG network
      REDIS_HOST: ${REDIS_HOST} # Tên service của Redis
      REDIS_PORT: ${REDIS_PORT}
    depends_on: # App phụ thuộc vào db và cache
      db_service:
        condition: service_healthy # Chờ db_service báo healthy
      cache_service:
        condition: service_healthy # Chờ cache_service báo healthy
    restart: unless-stopped

  # PostgreSQL Database Service
  db_service:
    image: postgres:14-alpine
    container_name: postgres_db_service
    environment: # Các biến này được image postgres sử dụng để khởi tạo DB
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
    volumes:
      - postgres_app_data:/var/lib/postgresql/data # Named volume cho dữ liệu Postgres
      # - ./web_app/init_db.sql:/docker-entrypoint-initdb.d/init.sql # (Tùy chọn) Mount script SQL khởi tạo
    ports: # Chỉ map ra host nếu bạn cần truy cập DB từ bên ngoài (VD: bằng pgAdmin)
      - "5433:5432" # Host port 5433 -> Container port 5432 (tránh xung đột nếu host đã có Postgres chạy ở 5432)
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB -q || exit 1",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 20s # Cho Postgres thời gian khởi tạo
    restart: always

  # Redis Cache Service
  cache_service:
    image: redis:7-alpine
    container_name: redis_cache_service
    volumes:
      - redis_app_data:/data # Named volume cho dữ liệu Redis (nếu Redis được cấu hình để persist)
    # ports: # Chỉ map ra host nếu bạn cần truy cập Redis từ bên ngoài (VD: bằng redis-cli từ host)
    #   - "6380:6379" # Host port 6380 -> Container port 6379
    healthcheck:
      test: ["CMD", "redis-cli", "-h", "localhost", "-p", "6379", "ping"]
      interval: 10s
      timeout: 3s
      retries: 5
    restart: always

# Top-level named volumes
volumes:
  postgres_app_data:
  redis_app_data:
```

**Chạy ứng dụng:**

1. **Chuẩn bị:**
    - Đảm bảo bạn đã tạo các file và thư mục như cấu trúc trên.
    - Trong thư mục `web_app`, chạy `npm init -y` và `npm install express redis pg nodemon` (nếu bạn muốn `nodemon`).
2. **Khởi động:**
    Mở terminal trong thư mục `compose_advanced_practice` (chứa `docker-compose.yml`).
    Chạy: `docker-compose up --build` (hoặc `docker compose up --build` cho V2).
    `-d` để chạy ở background: `docker-compose up -d --build`.
3. **Kiểm tra:**
    - Mở trình duyệt và truy cập `http://localhost:3000` (hoặc port bạn đặt trong `.env`).
    - Mỗi lần refresh, bộ đếm sẽ tăng.
    - Kiểm tra logs: `docker-compose logs app`, `docker-compose logs db_service`, `docker-compose logs cache_service`.
    - (Nếu map port DB/Redis ra host) Bạn có thể kết nối tới PostgreSQL (qua port 5433) hoặc Redis (qua port 6380) từ máy host để kiểm tra dữ liệu.
4. **Thử nghiệm tính bền bỉ và cache:**
    - Refresh trang vài lần.
    - Dừng và khởi động lại toàn bộ stack: `docker-compose down` (KHÔNG dùng `-v` nếu muốn giữ data DB) rồi `docker-compose up`. Bộ đếm nên được lấy từ DB và tiếp tục.
    - Nếu bạn dừng Redis (`docker-compose stop cache_service`), ứng dụng vẫn nên hoạt động (lấy từ DB). Khởi động lại Redis (`docker-compose start cache_service`), nó sẽ được cập nhật lại.
5. **Dọn dẹp:**
    `docker-compose down`
    Để xóa cả volumes (mất dữ liệu DB và Redis): `docker-compose down -v`

## 7. ✨ Best Practices & Mẹo

### Dockerfile Best Practices (Nhắc lại và bổ sung)

- **Sử dụng base image chính thức và nhỏ gọn (official & slim images):** Ưu tiên các image `alpine` (VD: `node:18-alpine`, `python:3.10-alpine`) vì chúng nhỏ, giảm attack surface.
- **Sử dụng tag cụ thể cho base image:** Tránh `latest` (VD: `node:18.17.0-alpine` thay vì `node:alpine` hoặc `node:latest`) để đảm bảo build nhất quán và tránh lỗi bất ngờ khi `latest` thay đổi.
- **Tối ưu hóa thứ tự lệnh để tận dụng caching:** Đặt các lệnh ít thay đổi lên trên (VD: `FROM`, `ENV`, `RUN apt-get install ...`). `COPY package.json` và `RUN npm install` nên đặt trước `COPY . .` (vì dependencies ít thay đổi hơn source code).
- **Giảm số lượng layers:** Mỗi `RUN`, `COPY`, `ADD` tạo một layer. Kết hợp các lệnh `RUN` liên quan bằng `&&` và `\` (nối dòng) để giảm số layer, giúp image nhỏ hơn và build nhanh hơn.

  ```dockerfile
  RUN apt-get update && apt-get install -y \
      package1 \
      package2 \
      package3 \
   && rm -rf /var/lib/apt/lists/* # Xóa cache của package manager
  ```

- **Sử dụng `.dockerignore` hiệu quả:** Loại bỏ các file/folder không cần thiết (VD: `.git`, `node_modules` của host, `*.log`, `*.tmp`, `Dockerfile` itself) khỏi build context.
- **Chạy ứng dụng với user không phải root (non-root user):** Tăng cường bảo mật. Tạo user/group bằng `RUN` và chuyển sang user đó bằng `USER`.

  ```dockerfile
  RUN addgroup -S appgroup && adduser -S appuser -G appgroup
  USER appuser
  ```

- **Sử dụng multi-stage builds:** Để tạo image production nhỏ gọn, chỉ chứa runtime và artifact đã biên dịch, không chứa build tools, source code gốc, hay dev dependencies.

  ```dockerfile
  # Stage 1: Build stage (Node.js ví dụ)
  FROM node:18-alpine AS builder
  WORKDIR /app
  COPY package*.json ./
  RUN npm ci --only=production
  COPY . .
  RUN npm run build # Giả sử có script build (VD: transpile TS, bundle frontend)

  # Stage 2: Production stage
  FROM node:18-alpine
  WORKDIR /app
  # (Tùy chọn) Tạo non-root user
  RUN addgroup -S appgroup && adduser -S appuser -G appgroup

  # Copy chỉ những thứ cần thiết từ builder stage
  COPY --from=builder /app/node_modules ./node_modules
  COPY --from=builder /app/dist ./dist  # Hoặc ./build tùy vào output của bạn
  COPY --from=builder /app/package.json ./package.json # Có thể cần cho runtime

  # (Tùy chọn) Chuyển user
  # USER appuser

  EXPOSE 3000
  CMD [ "node", "dist/server.js" ] # Chạy từ artifact đã build
  ```

- **`COPY` thay vì `ADD` cho file/folder cục bộ:** `COPY` rõ ràng hơn. Chỉ dùng `ADD` khi bạn cần tính năng tự động giải nén tarball hoặc tải file từ URL (dù tải URL trong Dockerfile cũng không phải là best practice lắm, có thể làm ở entrypoint script).
- **Hiểu rõ `CMD` và `ENTRYPOINT`:**
  - `ENTRYPOINT` định nghĩa executable chính.
  - `CMD` cung cấp tham số mặc định cho `ENTRYPOINT` hoặc là lệnh mặc định nếu không có `ENTRYPOINT`.
  - Ưu tiên exec form (`["executable", "param1"]`).
- **Không lưu trữ secrets trong image:** Dùng biến môi trường truyền vào lúc runtime, hoặc Docker secrets/configs, hoặc các giải pháp quản lý secret chuyên dụng (HashiCorp Vault).
- **Dọn dẹp sau khi cài đặt:** Xóa cache của package manager (`rm -rf /var/lib/apt/lists/*`, `apk add --no-cache ...`), file tạm, source code đã biên dịch không cần thiết trong cùng một `RUN` layer.

### Docker Compose Best Practices

- **Sử dụng `version: "3.x"`** (phiên bản mới nhất mà Docker Engine của bạn hỗ trợ, thường là 3.8 hoặc 3.9).
- **Đặt tên services rõ ràng, dễ hiểu.** Tên service cũng là hostname cho service discovery.
- **Sử dụng biến môi trường và file `.env`:**
  - Để cấu hình các thông số thay đổi giữa các môi trường (dev, test, prod) như database credentials, API keys, ports.
  - **Không hardcode credentials** trực tiếp trong `docker-compose.yml`.
  - File `.env` ở thư mục gốc của project được Docker Compose tự động load.
- **Sử dụng `depends_on` và `healthcheck`:**
  - `depends_on` để kiểm soát thứ tự khởi động.
  - Kết hợp `depends_on` với `condition: service_healthy` và `healthcheck` trong service phụ thuộc để đảm bảo service đó thực sự sẵn sàng trước khi service khác bắt đầu.
- **Chỉ `ports` (map ra host) những service thực sự cần truy cập từ bên ngoài.** Các service giao tiếp nội bộ qua network của Compose không cần map port ra host.
- **Sử dụng `volumes` cho persistent data (named volumes) và source code khi dev (bind mounts).**
  - Đặt tên rõ ràng cho named volumes.
  - Cẩn thận với `docker-compose down -v` (sẽ xóa named volumes).
- **Tách biệt cấu hình cho các môi trường (dev, staging, prod):**
  - Sử dụng nhiều file Compose: `docker-compose.yml` (chung), `docker-compose.override.yml` (cho dev, được load tự động), `docker-compose.prod.yml`, `docker-compose.test.yml`.
  - Sử dụng option `-f` để chỉ định các file compose cần load:
    `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d`
  - `docker-compose.override.yml` là file mặc định được load sau `docker-compose.yml` nếu nó tồn tại, rất tiện để ghi đè cấu hình cho môi trường dev (VD: thêm bind mount cho source code, map port debug).
- **Sử dụng `restart` policies phù hợp:** `always` hoặc `unless-stopped` cho các service quan trọng (DB, web server), `on-failure` cho workers.
- **Đặt `container_name` (tùy chọn):** Giúp container có tên cố định, dễ tham chiếu bằng `docker` CLI, nhưng có thể gây xung đột nếu bạn chạy nhiều project Compose giống hệt nhau. Mặc định Compose sẽ tạo tên dạng `<project>_<service>_<instance_number>`.
- **Sử dụng `profiles` (Compose v2.1+):** Cho phép định nghĩa các nhóm services tùy chọn, chỉ được khởi động khi profile đó được kích hoạt. Hữu ích để bật/tắt các service không cốt lõi (VD: tool debug, service thử nghiệm).

  ```yaml
  services:
    web:# Luôn chạy
      # ...
    db:# Luôn chạy
      # ...
    mailhog: # Service để test email, chỉ chạy khi profile 'dev-tools' được active
      image: mailhog/mailhog
      profiles: ["dev-tools"]
      ports:
        - "1025:1025" # SMTP
        - "8025:8025" # Web UI
  # Chạy: docker-compose --profile dev-tools up
  ```

### Sử dụng `.dockerignore`

Nhắc lại từ phần Dockerfile: file `.dockerignore` (đặt cùng cấp với `Dockerfile`) chỉ định các file/folder sẽ **KHÔNG** được gửi tới Docker daemon khi build image (trong `build context`).
Ví dụ `.dockerignore` cho một project Node.js:

```text
# Logs and temporary files
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pids
*.pid
*.seed
*.pid.lock

# Build artifacts
dist
build
coverage
.nyc_output

# Dependency directories
node_modules/
jspm_packages/

# Git
.git
.gitignore
.gitattributes

# Editor / OS specific
.vscode/
.idea/
*.swp
*~
.DS_Store
Thumbs.db

# Docker specific
Dockerfile # Không cần copy chính Dockerfile vào image
.dockerignore

# Environment files (nên được quản lý bên ngoài image)
.env
*.env.local
*.env.development.local
*.env.test.local
*.env.production.local

# Optional: Local config files not for image
config/local.json
```

Điều này giúp:

- **Giảm kích thước build context** -> build nhanh hơn.
- **Tránh vô tình copy file nhạy cảm** (như `.env` chứa credentials) vào image.
- **Tránh ghi đè file/folder** đã được tạo bởi các `RUN` command trong Dockerfile (VD: `node_modules` trong image không bị ghi đè bởi `node_modules` trên host nếu `COPY . .` được dùng).
- **Tối ưu hóa Docker build cache:** Nếu file không cần thiết thay đổi, nó sẽ không làm mất cache của lệnh `COPY`.

### Quản lý môi trường (Dev, Staging, Prod)

Sử dụng kết hợp các file `docker-compose.yml`, `docker-compose.override.yml`, và các file dành riêng cho môi trường (ví dụ: `docker-compose.prod.yml`), cùng với biến môi trường.

- **`docker-compose.yml` (Base):** Chứa cấu hình chung, ổn định cho tất cả các môi trường. Thường là cấu hình gần giống production nhất nhưng không chứa secrets.
- **`docker-compose.override.yml` (Dev default):**
  - Tự động được load bởi `docker-compose up` nếu tồn tại.
  - Ghi đè/bổ sung cấu hình cho môi trường development.
  - Ví dụ:
    - Mount source code bằng bind volumes để live reload.
    - Map thêm ports (VD: port debug cho Node.js).
    - Sử dụng image có tool dev (VD: `node:18-alpine` thay vì `node:18-slim`).
    - Thay đổi `command` để chạy với `nodemon` hoặc tool tương tự.
    - Thêm các service chỉ dùng cho dev (VD: `mailhog`, `adminer`).
- **`docker-compose.prod.yml` (Production):**
  - Chứa cấu hình riêng cho production.
  - Ví dụ:
    - Không mount source code.
    - Sử dụng image đã được tối ưu cho production (VD: từ multi-stage build).
    - Cấu hình `restart: always`.
    - Cấu hình logging phù hợp cho production.
    - Sử dụng biến môi trường hoặc secrets cho credentials.
  - Chạy: `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d`
- **Biến môi trường:**
  - Sử dụng file `.env` cho các giá trị mặc định hoặc không nhạy cảm.
  - Trên server production, các biến môi trường nhạy cảm nên được inject bởi hệ thống CI/CD hoặc orchestration platform, không nên commit vào Git.

## 8. 🏋️ Bài Tập

**Yêu cầu:** Mở rộng bài tập của phần Docker cơ bản (ứng dụng web tĩnh với Nginx) bằng cách thêm một service backend API đơn giản và quản lý toàn bộ bằng Docker Compose. Frontend sẽ gọi API này để lấy dữ liệu.

**Mô tả chi tiết:**

- **Service 1: `frontend`**
  - Sử dụng image `nginx:alpine` (hoặc `httpd:alpine`).
  - Phục vụ một file `index.html` và (tùy chọn) `style.css`.
  - `index.html` sẽ có một nút. Khi nhấn nút, JavaScript sẽ gọi đến một endpoint API của service `backend` (ví dụ: `/api/data`) và hiển thị kết quả trả về lên trang.
  - Nginx cần được cấu hình để **proxy các request có tiền tố `/api/`** tới service `backend`.
- **Service 2: `backend`** (Service mới)
  - Tạo một ứng dụng API cực kỳ đơn giản bằng **Node.js/Express** (hoặc Python/Flask, Go,... tùy bạn chọn, nhưng ví dụ sẽ ưu tiên Node.js).
  - API này có một endpoint, ví dụ `/data` (khi Nginx proxy, nó sẽ là `/api/data` từ phía client). Endpoint này trả về một đối tượng JSON, ví dụ:
    `{"message": "Hello from Backend API managed by Docker Compose!", "timestamp": "2023-10-27T10:30:00Z"}`.
  - Viết `Dockerfile` cho service `backend` này.

**Nhiệm vụ:**

1. **Cấu trúc thư mục dự kiến:**

    ```text
    my_fullstack_app/
    ├── docker-compose.yml
    ├── .env                   # (Tùy chọn) Cho port của frontend
    ├── frontend/              # Service frontend
    │   ├── Dockerfile         # Dockerfile cho Nginx (chủ yếu là COPY file)
    │   ├── nginx.conf       # Cấu hình Nginx để proxy_pass
    │   └── public/            # Thư mục chứa static files
    │       ├── index.html
    │       └── style.css (optional)
    └── backend/               # Service backend
        ├── Dockerfile         # Dockerfile cho Node.js API
        ├── package.json
        ├── server.js          # Code API
        └── ...
    ```

2. **Tạo service `backend` (Node.js/Express):**

    - `cd backend`
    - `npm init -y`
    - `npm install express`
    - `server.js`:

      ```javascript
      const express = require("express");
      const app = express();
      const PORT = process.env.BACKEND_PORT || 3001; // Port backend lắng nghe BÊN TRONG container

      app.get("/data", (req, res) => {
        console.log("Backend /data endpoint hit!");
        res.json({
          message: "Hello from Backend API managed by Docker Compose!",
          timestamp: new Date().toISOString(),
          servedByHost: req.hostname, // Sẽ là container ID hoặc tên nếu không có alias
        });
      });

      app.listen(PORT, "0.0.0.0", () => {
        // Lắng nghe trên tất cả network interfaces trong container
        console.log(`Backend API listening on port ${PORT}`);
      });
      ```

    - `Dockerfile` (trong `backend/`):

      ```dockerfile
      FROM node:18-alpine
      WORKDIR /usr/src/app
      COPY package*.json ./
      RUN npm install --production # Chỉ cài production dependencies
      COPY . .
      # Biến môi trường BACKEND_PORT có thể được set trong docker-compose.yml
      # EXPOSE 3001 # Port mà backend lắng nghe (đã được set trong server.js)
      CMD [ "node", "server.js" ]
      ```

3. **Cấu hình Nginx Proxy cho `frontend`:**

    - `frontend/public/index.html`:

      ```html
      <!DOCTYPE html>
      <html>
        <head>
          <title>Frontend App</title>
          <style>
            body {
              font-family: sans-serif;
            }
            button {
              padding: 10px;
            }
            #result {
              margin-top: 20px;
              padding: 10px;
              border: 1px solid #ccc;
              background-color: #f9f9f9;
            }
          </style>
        </head>
        <body>
          <h1>Welcome to the Frontend!</h1>
          <button id="fetchDataBtn">Fetch Data from Backend</button>
          <div id="result">Click the button to see data.</div>

          <script>
            document
              .getElementById("fetchDataBtn")
              .addEventListener("click", async () => {
                const resultDiv = document.getElementById("result");
                resultDiv.textContent = "Loading...";
                try {
                  // Nginx sẽ proxy request /api/data này đến service backend
                  const response = await fetch("/api/data");
                  if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                  }
                  const data = await response.json();
                  resultDiv.innerHTML = `
                          <p><strong>Message:</strong> ${data.message}</p>
                          <p><strong>Timestamp:</strong> ${data.timestamp}</p>
                          <p><strong>Served by:</strong> ${data.servedByHost}</p>
                      `;
                } catch (error) {
                  resultDiv.textContent =
                    "Error fetching data: " + error.message;
                  console.error("Error:", error);
                }
              });
          </script>
        </body>
      </html>
      ```

    - `frontend/nginx.conf`:

      ```nginx
      # frontend/nginx.conf
      server {
          listen 80; # Nginx lắng nghe trên port 80 BÊN TRONG container frontend
          server_name localhost;

          # Phục vụ static files từ /usr/share/nginx/html (nơi ta sẽ COPY public/ vào)
          location / {
              root   /usr/share/nginx/html;
              index  index.html index.htm;
              try_files $uri $uri/ /index.html; # Quan trọng cho SPA nếu có
          }

          # Proxy các request /api/ tới service backend
          location /api/ {
              # 'backend_service' phải khớp với tên service của backend trong docker-compose.yml
              # '3001' là port mà backend API lắng nghe BÊN TRONG container của nó
              proxy_pass http://backend_service:3001/; # Dấu / cuối cùng quan trọng

              # Các headers này giúp backend biết thông tin gốc của request
              proxy_set_header Host $host; # Giữ nguyên Host header gốc
              proxy_set_header X-Real-IP $remote_addr; # IP của client
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; # Danh sách IP nếu qua nhiều proxy
              proxy_set_header X-Forwarded-Proto $scheme; # http hoặc https

              # (Tùy chọn) Cấu hình timeout
              # proxy_connect_timeout       60s;
              # proxy_send_timeout          60s;
              # proxy_read_timeout          60s;
          }

          # (Tùy chọn) Tắt access log hoặc error log cho đỡ nhiễu khi dev
          # access_log off;
          # error_log /dev/null;
      }
      ```

    - `frontend/Dockerfile`:

      ```dockerfile
      FROM nginx:1.25-alpine

      # Xóa config Nginx mặc định
      RUN rm /etc/nginx/conf.d/default.conf

      # Copy file nginx.conf tùy chỉnh vào vị trí config của Nginx
      COPY nginx.conf /etc/nginx/conf.d/default.conf

      # Copy toàn bộ nội dung thư mục public/ (chứa index.html, style.css)
      # vào thư mục phục vụ web mặc định của Nginx
      COPY ./public/ /usr/share/nginx/html/

      # EXPOSE 80 # Image nginx đã làm việc này
      # CMD ["nginx", "-g", "daemon off;"] # Image nginx đã làm việc này
      ```

4. **Viết `docker-compose.yml` (trong `my_fullstack_app/`):**

    ```yaml
    version: "3.8"

    services:
      frontend_service: # Tên service cho frontend
        build: ./frontend # Đường dẫn đến thư mục chứa Dockerfile của frontend
        container_name: my_frontend_nginx
        ports:
          - "${FRONTEND_PORT:-8080}:80" # Map port từ .env (mặc định 8080) ra port 80 của container frontend
        volumes:
          # Mount thư mục public và nginx.conf để live reload khi dev (tùy chọn)
          - ./frontend/public:/usr/share/nginx/html:ro # :ro cho read-only an toàn hơn
          - ./frontend/nginx.conf:/etc/nginx/conf.d/default.conf:ro
        depends_on:
          - backend_service # Frontend phụ thuộc vào backend
        restart: unless-stopped

      backend_service: # Tên service cho backend (khớp với proxy_pass trong nginx.conf)
        build: ./backend
        container_name: my_backend_api
        environment:
          # BACKEND_PORT: 3001 # Port này đã được set trong server.js, có thể set ở đây để ghi đè
          NODE_ENV: development
        # ports: # Không cần map port backend ra host nếu chỉ frontend gọi nội bộ
        #   - "3001:3001"
        volumes:
          - ./backend:/usr/src/app # Mount source code backend cho live reload
          - /usr/src/app/node_modules # Để không bị ghi đè node_modules từ host
        restart: unless-stopped
        # (Tùy chọn) Thêm healthcheck cho backend
        # healthcheck:
        #   test: ["CMD", "curl", "-f", "http://localhost:3001/data"] # Hoặc một endpoint /health đơn giản
        #   interval: 30s
        #   timeout: 10s
        #   retries: 3
    # (Tùy chọn) Định nghĩa network nếu muốn custom
    # networks:
    #   app_network:
    #     driver: bridge
    ```

    - Tạo file `.env` (trong `my_fullstack_app/`) (tùy chọn):

      ```env
      FRONTEND_PORT=8080
      ```

5. **Chạy và Kiểm tra:**
    - Từ thư mục `my_fullstack_app`, chạy `docker-compose up --build`.
    - Mở trình duyệt, truy cập `http://localhost:8080` (hoặc port bạn set trong `.env`).
    - Nhấn nút "Fetch Data from Backend". Dữ liệu từ backend API (qua Nginx proxy) sẽ được hiển thị.
    - Kiểm tra logs của các service: `docker-compose logs frontend_service`, `docker-compose logs backend_service`.
    - Thử thay đổi code trong `backend/server.js` hoặc `frontend/public/index.html`. Nếu bạn đã mount volumes và dùng `nodemon` cho backend (hoặc trình duyệt tự refresh cho frontend), bạn sẽ thấy thay đổi mà không cần build lại (có thể cần restart service backend nếu không có nodemon).
6. **Dọn dẹp:** `docker-compose down`

Chúc bạn thành công với bài tập này! Nó sẽ giúp bạn hiểu rõ hơn về cách các service tương tác với nhau trong Docker Compose.

## 9. 📚 Tài Liệu Tham Khảo & Next Steps

- **Docker Official Documentation:** [https://docs.docker.com/](https://docs.docker.com/) (Nguồn tài liệu toàn diện nhất)
- **Docker Compose CLI Reference:** [https://docs.docker.com/compose/reference/](https://docs.docker.com/compose/reference/)
- **Compose File Reference:** [https://docs.docker.com/compose/compose-file/](https://docs.docker.com/compose/compose-file/compose-file-v3/)
- **Best practices for writing Dockerfiles:** [https://docs.docker.com/develop/develop-images/dockerfile_best-practices/](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- **Docker Samples (GitHub):** [https://github.com/dockersamples](https://github.com/dockersamples) (Nhiều ví dụ thực tế)
- **Awesome Docker (Curated list on GitHub):** [https://github.com/veggiemonk/awesome-docker](https://github.com/veggiemonk/awesome-docker)
- **Play with Docker (Online Docker playground):** [https://labs.play-with-docker.com/](https://labs.play-with-docker.com/) (Thực hành Docker mà không cần cài đặt)
- **Bret Fisher's Docker and Kubernetes Resources:** [https://www.bretfisher.com/](https://www.bretfisher.com/) (Nhiều khóa học và tips hay)

**Next Steps (Sau khi nắm vững những kiến thức này):**

- **Multi-stage builds trong Dockerfile:** Tìm hiểu sâu hơn để tối ưu image cho production.
- **Quản lý secrets và configurations nâng cao:** Nghiên cứu Docker secrets, Docker configs, hoặc các tool như HashiCorp Vault.
- **Docker Swarm:** Tìm hiểu về công cụ orchestration container tích hợp sẵn của Docker, đơn giản hơn Kubernetes cho các ứng dụng vừa và nhỏ.
- **Kubernetes (K8s):** "Ông vua" của orchestration container, mạnh mẽ nhưng phức tạp hơn. Cần thiết cho các hệ thống lớn, đòi hỏi tính sẵn sàng cao và khả năng scale mạnh.
- **Tích hợp Docker vào CI/CD pipelines:** Tự động hóa quá trình build, test, và deploy ứng dụng Dockerized (VD: với Jenkins, GitLab CI, GitHub Actions).
- **Khám phá các private registries chuyên sâu:** AWS ECR, Google Artifact Registry (GCR cũ), Azure CR, Harbor (tự host).
- **Docker Security:** Tìm hiểu về các best practice để bảo mật Docker images và containers (quét lỗ hổng, image signing, runtime security).
- **Service Mesh (Istio, Linkerd):** Cho các ứng dụng microservices phức tạp, quản lý traffic, observability, security giữa các services.
- **Infrastructure as Code (Terraform, Pulumi):** Kết hợp Docker với các công cụ IaC để quản lý toàn bộ hạ tầng.

---

[⬅️ Trở lại: DEVOPS/Docker1.md](./Docker1.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: (Bài học tiếp theo, ví dụ về Kubernetes hoặc CI/CD)](../DEVOPS/Kubernetes1.md)
