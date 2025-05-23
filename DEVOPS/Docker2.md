# 🐳 DOCKER: ORCHESTRATION & BEST PRACTICES

- [🐳 DOCKER: ORCHESTRATION \& BEST PRACTICES](#-docker-orchestration--best-practices)
  - [🎯 Mục Tiêu](#-mục-tiêu)
  - [1. ⏪ Ôn Lại phần trước](#1--ôn-lại-phần-trước)
    - [Key Concepts: Image, Container, Dockerfile](#key-concepts-image-container-dockerfile)
    - [Basic Docker CLI](#basic-docker-cli)
  - [2. 🚀 Giới Thiệu Docker Compose](#2--giới-thiệu-docker-compose)
    - [Tại sao cần Docker Compose? Vấn đề với nhiều `docker run`](#tại-sao-cần-docker-compose-vấn-đề-với-nhiều-docker-run)
    - [Docker Compose là gì?](#docker-compose-là-gì)
  - [3. 🎼 Cú Pháp `docker-compose.yml`](#3--cú-pháp-docker-composeyml)
    - [`version`](#version)
    - [`services`](#services)
    - [`build` vs `image`](#build-vs-image)
    - [`ports`](#ports)
    - [`volumes`](#volumes)
    - [`environment`](#environment)
    - [`depends_on`](#depends_on)
    - [`networks`](#networks)
    - [Ví dụ `docker-compose.yml` đơn giản](#ví-dụ-docker-composeyml-đơn-giản)
  - [4. 🔗 Docker Networking (với Compose)](#4--docker-networking-với-compose)
    - [Mạng mặc định (Default Network)](#mạng-mặc-định-default-network)
    - [Kết nối giữa các services](#kết-nối-giữa-các-services)
  - [5. 💾 Docker Volumes (với Compose)](#5--docker-volumes-với-compose)
    - [Tại sao cần Volumes? (Data Persistence)](#tại-sao-cần-volumes-data-persistence)
    - [Named Volumes vs. Bind Mounts](#named-volumes-vs-bind-mounts)
    - [Khai báo và sử dụng Volumes trong Compose](#khai-báo-và-sử-dụng-volumes-trong-compose)
  - [6. 🛠️ Thực Hành: Xây Dựng Ứng Dụng Web + Database với Docker Compose](#6-️-thực-hành-xây-dựng-ứng-dụng-web--database-với-docker-compose)
  - [7. ✨ Best Practices \& Mẹo](#7--best-practices--mẹo)
    - [Dockerfile Best Practices](#dockerfile-best-practices)
    - [Docker Compose Best Practices](#docker-compose-best-practices)
    - [`.dockerignore`](#dockerignore)
  - [8. 🏋️ Bài Tập](#8-️-bài-tập)
  - [9. 📚 Tài Liệu Tham Khảo \& Next Steps](#9--tài-liệu-tham-khảo--next-steps)

---

## 🎯 Mục Tiêu

- Hiểu vai trò và lợi ích của **Docker Compose**.
- Nắm vững cú pháp cơ bản của file `docker-compose.yml`.
- Biết cách định nghĩa và quản lý **services**, **networks**, và **volumes** với Docker Compose.
- Thực hành xây dựng một ứng dụng **multi-container** đơn giản.
- Tìm hiểu một số **best practices** khi làm việc với Docker và Docker Compose.

---

## 1. ⏪ Ôn Lại phần trước

### Key Concepts: Image, Container, Dockerfile

- **Image**: Template read-only, chứa mọi thứ cần để chạy ứng dụng.
- **Container**: Instance chạy của một image, môi trường isolated.
- **Dockerfile**: File text chứa instructions để build image.

### Basic Docker CLI

- `docker build ...`
- `docker run ...`
- `docker ps`
- `docker images`
- `docker stop/rm ...`
- `docker logs ...`
- `docker exec ...`

## 2. 🚀 Giới Thiệu Docker Compose

### Tại sao cần Docker Compose? Vấn đề với nhiều `docker run`

Hãy tưởng tượng một ứng dụng web điển hình:

- Một `web server` (Nginx, Apache)
- Một `application server` (Node.js, Python/Flask, Java/Spring)
- Một `database` (PostgreSQL, MySQL, MongoDB)
- (Có thể) Một `caching service` (Redis)

Nếu dùng `docker run` cho từng service:

```bash
# Chạy database
docker run -d --name my_db -e POSTGRES_PASSWORD=secret postgres:13

# Chạy backend app, link tới DB, expose port
# Cần đợi DB sẵn sàng, lấy IP của DB (hoặc dùng Docker network)
docker run -d --name my_app --link my_db:db -p 3000:3000 my_backend_image

# Chạy frontend, link tới backend
docker run -d --name my_frontend -p 80:80 --link my_app:api my_frontend_image
```

- **Rất nhiều lệnh** cần nhớ và gõ.
- **Khó quản lý** dependencies (service A cần service B chạy trước).
- **Khó scale** (tăng số lượng instance của một service).
- **Khó chia sẻ** cấu hình với team.

### Docker Compose là gì?

- Là một công cụ để **định nghĩa (define)** và **chạy (run)** các ứng dụng Docker **đa-container (multi-container)**.
- Sử dụng một file YAML (thường là `docker-compose.yml`) để cấu hình tất cả các `services`, `networks`, và `volumes` của ứng dụng.
- Với một lệnh duy nhất (`docker-compose up`), bạn có thể khởi tạo và chạy toàn bộ ứng dụng.

**Lợi ích:**

- **Đơn giản hóa** việc quản lý ứng dụng multi-container.
- **Dễ dàng tái tạo** môi trường phát triển, testing, staging.
- **Tích hợp tốt** với Docker Engine.
- **Quản lý tập trung** cấu hình ứng dụng.

[Hình ảnh: Sơ đồ một ứng dụng web (frontend, backend, db) được quản lý bởi Docker Compose]

## 3. 🎼 Cú Pháp `docker-compose.yml`

File `docker-compose.yml` là trái tim của Docker Compose.

### `version`

Chỉ định phiên bản của cú pháp file Compose. Nên dùng phiên bản mới nhất được hỗ trợ.

```yaml
version: "3.8" # Hoặc "3.9", "3.x"
```

### `services`

Nơi định nghĩa các container (services) của ứng dụng. Mỗi key dưới `services` là tên của một service.

```yaml
services:
  web:
    # Cấu hình cho service 'web'
  api:
    # Cấu hình cho service 'api'
  db:
    # Cấu hình cho service 'db'
```

### `build` vs `image`

- `image: <image_name>:<tag>`: Chỉ định image có sẵn từ Docker Hub hoặc private registry.

  ```yaml
  services:
    database:
      image: postgres:14-alpine
  ```

- `build: <path_to_dockerfile_directory>`: Chỉ định Docker Compose build image từ Dockerfile.

  - Có thể là một string (đường dẫn): `build: ./backend`
  - Hoặc một object để cung cấp thêm chi tiết:

  ```yaml
  services:
    backend:
      build:
        context: ./app_folder # Thư mục chứa Dockerfile
        dockerfile: Dockerfile.dev # Tên Dockerfile (nếu khác Dockerfile)
        args: # Biến truyền vào lúc build
          NODE_VERSION: 18
  ```

  Bạn có thể dùng cả hai: `build` image nếu không tìm thấy `image` đã có tên đó.

### `ports`

Map ports giữa host và container. `HOST:CONTAINER`

```yaml
services:
  frontend:
    image: nginx:latest
    ports:
      - "8080:80" # Map port 8080 của host tới port 80 của container frontend
```

### `volumes`

Mount thư mục từ host vào container (bind mount) hoặc quản lý data volumes (named volumes).

```yaml
services:
  backend:
    image: myapp-backend
    volumes:
      - ./src:/app/src # Bind mount: thay đổi code ở host -> thay đổi trong container (dev)
      - logs_data:/app/logs # Named volume: lưu trữ logs bền bỉ
  database:
    image: postgres:14
    volumes:
      - db_data:/var/lib/postgresql/data # Named volume: lưu trữ data của DB

volumes: # Khai báo top-level named volumes
  db_data:
  logs_data:
```

Sẽ nói chi tiết hơn ở phần Docker Volumes.

### `environment`

Thiết lập biến môi trường cho container.

- Dạng list:

  ```yaml
  services:
    api:
      image: my-api
      environment:
        - NODE_ENV=development
        - DATABASE_URL=postgresql://user:pass@db:5432/mydb
  ```

- Dạng map:

  ```yaml
  services:
    api:
      image: my-api
      environment:
        NODE_ENV: development
        DATABASE_URL: postgresql://user:pass@db:5432/mydb
  ```

- Từ file `.env` (file `.env` nằm cùng cấp với `docker-compose.yml`):

  ```yaml
  # .env file
  POSTGRES_USER=myuser
  POSTGRES_PASSWORD=mypassword
  ```

  ```yaml
  # docker-compose.yml
  services:
    db:
      image: postgres
      environment:
        POSTGRES_USER: ${POSTGRES_USER} # Tham chiếu từ .env
        POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
  ```

  Hoặc dùng `env_file`:

  ```yaml
  services:
    api:
      image: my-api
      env_file:
        - ./api.env # Đường dẫn tới file env cụ thể
  ```

### `depends_on`

Chỉ định thứ tự khởi động giữa các services. Service A `depends_on` Service B nghĩa là Service B sẽ được khởi động _trước_ Service A.
**Lưu ý:** `depends_on` chỉ đảm bảo container của service phụ thuộc đã _khởi động_, không đảm bảo ứng dụng bên trong container đó đã _sẵn sàng_ (ví dụ: database cần thời gian để initialize).

```yaml
services:
  api:
    image: my-api
    depends_on:
      - db # api sẽ khởi động sau khi db khởi động
  db:
    image: postgres
```

### `networks`

Cho phép services kết nối với nhau. Docker Compose tự động tạo một default network cho tất cả services trong file.

```yaml
services:
  frontend:
    image: nginx
    networks:
      - front-tier
  api:
    image: my-api
    networks:
      - front-tier
      - back-tier
  db:
    image: postgres
    networks:
      - back-tier

networks: # Khai báo top-level networks
  front-tier:
  back-tier:
```

Sẽ nói chi tiết hơn ở phần Docker Networking.

### Ví dụ `docker-compose.yml` đơn giản

```yaml
version: "3.8"

services:
  # Service web server (ví dụ: Node.js app)
  web:
    build: ./app # Thư mục chứa Dockerfile của app
    ports:
      - "3000:3000" # Map port 3000 của host tới port 3000 của container
    volumes:
      - ./app:/usr/src/app # Mount source code vào container để live reload
      - /usr/src/app/node_modules # Ngăn node_modules của host ghi đè node_modules trong image
    environment:
      - NODE_ENV=development
    depends_on:
      - redis # Web app phụ thuộc vào Redis

  # Service Redis (caching)
  redis:
    image: "redis:alpine"
    ports: # Không nhất thiết phải expose port Redis ra host nếu chỉ app nội bộ dùng
      - "6379:6379" # Ví dụ nếu muốn kết nối từ host vào Redis này
```

**Cấu trúc thư mục ví dụ:**

```text
my_project/
├── docker-compose.yml
├── .env (tùy chọn)
└── app/
    ├── Dockerfile
    ├── package.json
    └── server.js
    └── ... (các file khác của app)
```

**Các lệnh Docker Compose cơ bản:**

- `docker-compose up`: Build (nếu cần), tạo và khởi động các services.
  - `docker-compose up -d`: Chạy ở background (detached mode).
  - `docker-compose up --build`: Luôn build lại images trước khi khởi động.
- `docker-compose down`: Dừng và xóa containers, networks.
  - `docker-compose down -v`: Xóa cả named volumes.
- `docker-compose ps`: Liệt kê các containers do Compose quản lý.
- `docker-compose logs <service_name>`: Xem logs của một service.
  - `docker-compose logs -f <service_name>`: Theo dõi logs.
- `docker-compose exec <service_name> <command>`: Chạy lệnh trong một service đang chạy.
  - `docker-compose exec web bash`
- `docker-compose build <service_name>`: Build (hoặc rebuild) image cho service.
- `docker-compose pull <service_name>`: Pull image cho service (nếu dùng `image:`).
- `docker-compose start/stop/restart <service_name>`: Quản lý lifecycle của service.

## 4. 🔗 Docker Networking (với Compose)

### Mạng mặc định (Default Network)

- Khi bạn chạy `docker-compose up`, Compose sẽ tự động tạo một **user-defined bridge network** mặc định cho ứng dụng của bạn.
- Tên network thường là `<project_name>_default` (project_name là tên thư mục chứa `docker-compose.yml`).
- Tất cả các `services` trong file `docker-compose.yml` sẽ được kết nối vào network này.

### Kết nối giữa các services

- Bên trong network này, các containers có thể **tham chiếu (resolve) lẫn nhau bằng tên service** đã định nghĩa trong `docker-compose.yml`.
- Ví dụ, service `web` có thể kết nối tới service `db` qua hostname `db` (ví dụ: `postgres://user:pass@db:5432/mydb`). Docker sẽ tự động resolve `db` thành IP nội bộ của container `db`.
- Bạn không cần dùng `links` (đã cũ) hay expose port của DB ra host nếu chỉ có các service khác trong cùng Compose network cần truy cập.

**Sơ đồ:**

```text
  Host Machine
  -------------------------------------------------
  |                                               |
  |   Docker Network: myproject_default           |
  |   -----------------------------------------   |
  |   | Service: web (IP: 172.x.x.2)          |   |  <-- có thể kết nối tới 'db:5432'
  |   |  - Nginx/Node.js                      |   |
  |   -----------------------------------------   |
  |   | Service: api (IP: 172.x.x.3)          |   |  <-- có thể kết nối tới 'db:5432'
  |   |  - Python/Java                        |   |
  |   -----------------------------------------   |
  |   | Service: db (IP: 172.x.x.4)           |   |  <-- Lắng nghe trên port 5432 nội bộ
  |   |  - PostgreSQL/MySQL                   |   |
  |   -----------------------------------------   |
  |                                               |
  -------------------------------------------------
```

- Service `web` có thể truy cập service `db` tại địa chỉ `db:5432` (nếu `db` là PostgreSQL).
- Không cần `EXPOSE` port của `db` ra ngoài host machine nếu chỉ các services khác trong cùng network này cần truy cập.

## 5. 💾 Docker Volumes (với Compose)

### Tại sao cần Volumes? (Data Persistence)

- Containers là **ephemeral** (tạm thời). Khi container bị xóa, mọi dữ liệu được ghi vào filesystem của nó (trừ khi dùng volume) sẽ bị **mất**.
- Đối với database, user uploads, logs quan trọng, chúng ta cần **lưu trữ dữ liệu bền bỉ (persistently)**.

### Named Volumes vs. Bind Mounts

1. **Named Volumes:**

   - Được Docker quản lý hoàn toàn. Dữ liệu được lưu trữ trong một phần đặc biệt của host filesystem do Docker quản lý (`/var/lib/docker/volumes/` trên Linux).
   - **Ưu điểm:** Độc lập với cấu trúc thư mục của host, dễ dàng backup/migrate, performance tốt hơn trên một số OS (macOS, Windows).
   - Khai báo ở top-level `volumes:` và tham chiếu trong service.

   ```yaml
   services:
     database:
       image: postgres
       volumes:
         - db_data:/var/lib/postgresql/data
   volumes:
     db_data: # Docker sẽ tạo và quản lý volume tên là 'myproject_db_data'
   ```

2. **Bind Mounts:**

   - Mount một file hoặc thư mục từ **host machine** vào container.
   - **Ưu điểm:** Rất tiện cho development, khi bạn thay đổi code trên host, thay đổi đó được phản ánh ngay lập tức vào container.
   - **Nhược điểm:** Phụ thuộc vào cấu trúc thư mục của host. Có thể gây vấn đề về performance hoặc permission trên một số OS.

   ```yaml
   services:
     web:
       build: ./app
       volumes:
         - ./app/src:/usr/src/app/src # Mount code từ host vào container
   ```

**Khi nào dùng cái nào?**

- **Named Volumes:** Cho dữ liệu ứng dụng cần tính bền bỉ (database data, user uploads).
- **Bind Mounts:** Cho source code trong môi trường development (để live-reloading), hoặc cho file cấu hình.

### Khai báo và sử dụng Volumes trong Compose

Đã được minh họa ở trên.

- Khai báo ở `volumes:` top-level cho named volumes.
- Sử dụng trong `services.<service_name>.volumes`.

## 6. 🛠️ Thực Hành: Xây Dựng Ứng Dụng Web + Database với Docker Compose

**Mục tiêu:** Tạo một ứng dụng đơn giản gồm 2 services:

1. `web`: Một ứng dụng Node.js/Express đơn giản có thể ghi và đọc một message từ Redis.
2. `redis`: Một Redis instance.

**Cấu trúc thư mục:**

```text
compose_practice/
├── docker-compose.yml
└── web_app/
    ├── Dockerfile
    ├── package.json
    └── server.js
```

**1. `web_app/package.json`:**

```json
{
  "name": "web-app-redis",
  "version": "1.0.0",
  "description": "Simple Node.js app with Redis",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.17.1",
    "redis": "^3.1.2" // Lưu ý: version 3.x.x của redis client
  }
}
```

_(Lưu ý: `redis` v4+ dùng Promises, v3 dùng callbacks. Ví dụ này dùng v3 cho đơn giản.)_

**2. `web_app/server.js`:**

```javascript
// web_app/server.js
const express = require("express");
const redis = require("redis");
const app = express();
const port = 3000;

// Kết nối tới Redis - 'redis-server' là tên service trong docker-compose.yml
const redisClient = redis.createClient({ host: "redis-server", port: 6379 });

redisClient.on("connect", () => {
  console.log("Connected to Redis!");
});
redisClient.on("error", (err) => {
  console.error("Redis error: ", err);
});

app.use(express.json()); // Middleware để parse JSON body

app.get("/", (req, res) => {
  redisClient.get("message", (err, message) => {
    if (err) return res.status(500).send(err.toString());
    res.send(`Current message: ${message || "No message set yet!"}`);
  });
});

app.post("/message", (req, res) => {
  const { message } = req.body;
  if (!message) {
    return res.status(400).send("Message is required");
  }
  redisClient.set("message", message, (err, reply) => {
    if (err) return res.status(500).send(err.toString());
    res.send(`Message set to: ${message}`);
  });
});

app.listen(port, () => {
  console.log(`Web app listening at http://localhost:${port}`);
});
```

**3. `web_app/Dockerfile`:**

```dockerfile
FROM node:16-alpine

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]
```

**4. `docker-compose.yml` (trong thư mục `compose_practice`):**

```yaml
version: "3.8"

services:
  webapp:
    build: ./web_app # Đường dẫn tới thư mục chứa Dockerfile của web_app
    ports:
      - "3000:3000"
    volumes:
      - ./web_app:/usr/src/app # Mount source code để live reload
      - /usr/src/app/node_modules # Quan trọng: để không bị ghi đè bởi node_modules của host (nếu có)
    environment:
      - NODE_ENV=development
    depends_on:
      - redis-server # Đảm bảo redis-server khởi động trước webapp

  redis-server:
    image: "redis:alpine"
    # Không cần expose port 6379 ra host nếu chỉ webapp dùng
    # ports:
    #   - "6379:6379"
    volumes:
      - redis_data:/data # Named volume để lưu dữ liệu Redis

volumes:
  redis_data: # Khai báo named volume
```

**Chạy ứng dụng:**

1. Mở terminal trong thư mục `compose_practice`.
2. Chạy `npm install` bên trong `web_app` để tạo `package-lock.json` (nếu bạn muốn có file này được copy vào image, hoặc bỏ qua bước này và để `RUN npm install` trong Dockerfile tự xử lý).
3. Chạy: `docker-compose up --build` (hoặc `docker-compose up -d --build` để chạy background).
4. Kiểm tra:

   - Mở trình duyệt: `http://localhost:3000` -> Sẽ thấy "Current message: No message set yet!"
   - Dùng Postman hoặc `curl` để POST message:

     ```bash
     curl -X POST -H "Content-Type: application/json" -d '{"message":"Hello Docker Compose!"}' http://localhost:3000/message
     ```

   - Refresh trình duyệt: `http://localhost:3000` -> Sẽ thấy "Current message: Hello Docker Compose!"

5. Dọn dẹp: `docker-compose down -v` (để xóa cả volume `redis_data`).

## 7. ✨ Best Practices & Mẹo

### Dockerfile Best Practices

- **Use official images** làm base image nếu có thể (an toàn, được maintain).
- **Use specific tags** (VD: `node:18-alpine` thay vì `node:latest`).
- **Minimize layers**: Kết hợp các lệnh `RUN` nếu có thể (VD: `RUN apt-get update && apt-get install -y ... && rm -rf /var/lib/apt/lists/*`). Mỗi `RUN` tạo một layer.
- **Order matters for caching**: Đặt các instruction ít thay đổi lên trên (VD: `COPY package.json` và `RUN npm install` trước `COPY . .`).
- **Use `.dockerignore`**: Loại bỏ các file/folder không cần thiết (VD: `.git`, `node_modules` của host, logs) khỏi build context để build nhanh hơn và image nhỏ hơn.
- **Run as non-root user**: Tăng cường bảo mật (`USER` instruction).
- **Use multi-stage builds**: Để tạo image production nhỏ gọn, chỉ chứa runtime, không chứa build tools.
- **`COPY` thay vì `ADD`** cho file/folder cục bộ (ít "magic" hơn `ADD`). `ADD` có thể giải nén tarball hoặc fetch URL.

### Docker Compose Best Practices

- **Sử dụng `version: "3.x"`** (phiên bản mới nhất bạn cần).
- **Đặt tên services rõ ràng**.
- **Sử dụng biến môi trường (`.env` file)** cho các cấu hình nhạy cảm hoặc thay đổi giữa các môi trường. Không hardcode credentials.
- **Sử dụng `depends_on`** một cách hợp lý, nhưng hiểu rằng nó chỉ đảm bảo container khởi động, không phải ứng dụng sẵn sàng. Cân nhắc dùng `healthcheck` hoặc các script `wait-for-it.sh`.
- **Chỉ `expose` ports ra host khi thực sự cần**. Các service giao tiếp nội bộ qua network của Compose.
- **Sử dụng `volumes`** cho persistent data và source code khi dev.
- **Tách biệt config cho dev, staging, prod** bằng cách sử dụng nhiều file compose (VD: `docker-compose.yml`, `docker-compose.override.yml`, `docker-compose.prod.yml`) và `-f` option.
  - `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d`

### `.dockerignore`

Tương tự `.gitignore`, file `.dockerignore` (đặt cùng cấp với `Dockerfile`) chỉ định các file/folder sẽ **KHÔNG** được gửi tới Docker daemon khi build image.
Ví dụ `.dockerignore`:

```text
.git
.vscode
node_modules
npm-debug.log
Dockerfile
.dockerignore
README.md
*.env
```

Điều này giúp:

- **Giảm kích thước build context** -> build nhanh hơn.
- **Tránh vô tình copy file nhạy cảm** vào image.
- **Tránh ghi đè file/folder** đã được tạo bởi các `RUN` command (VD: `node_modules` trong image).

## 8. 🏋️ Bài Tập

**Yêu cầu:** Mở rộng bài tập của phần trước bằng cách thêm một service backend đơn giản và quản lý toàn bộ bằng Docker Compose.

**Mô tả:**

- **Service 1: `frontend`** (Từ bài tập 1)
  - Sử dụng image `nginx:alpine` (hoặc `httpd:alpine`) để phục vụ các file HTML tĩnh của bạn.
  - Nginx cần được cấu hình để **proxy các request API** (ví dụ: `/api/*`) tới service `backend`.
- **Service 2: `backend`** (Service mới)
  - Tạo một ứng dụng API rất đơn giản bằng Node.js/Express (hoặc Python/Flask, Go,... tùy bạn chọn).
  - API này có một endpoint, ví dụ `/api/message`, trả về một chuỗi JSON như `{"text": "Hello from Backend API via Compose!"}`.
  - Viết `Dockerfile` cho service `backend` này.

**Nhiệm vụ:**

1. **Cấu trúc thư mục dự kiến:**

   ```text
   my_compose_app/
   ├── docker-compose.yml
   ├── frontend/
   │   ├── index.html
   │   ├── style.css (optional)
   │   └── nginx.conf (Cấu hình Nginx để proxy)
   └── backend/
       ├── Dockerfile
       ├── package.json (nếu là Node.js)
       ├── server.js (hoặc app.py, main.go,...)
       └── ...
   ```

2. **Tạo service `backend`:**

   - Viết code cho API đơn giản (ví dụ: `server.js` cho Node).
   - Viết `Dockerfile` cho service `backend`.

3. **Cấu hình Nginx Proxy cho `frontend`:**

   - Tạo file `nginx.conf` (hoặc file config tương ứng cho web server bạn chọn).
   - Trong `nginx.conf`, cấu hình để các request đến `/api` được chuyển tiếp (proxy_pass) đến service `backend` (ví dụ: `http://backend_service_name:port_backend_chay_tren_do/`).

     ```nginx
     // Ví dụ nginx.conf (đơn giản)
     server {
         listen 80;
         server_name localhost;

         location / {
             root   /usr/share/nginx/html;
             index  index.html index.htm;
             try_files $uri $uri/ /index.html; # Quan trọng cho SPA nếu có
         }

         location /api/ {
             # Tên 'backend' phải khớp với tên service trong docker-compose.yml
             # Port 3000 là port backend API lắng nghe BÊN TRONG container của nó
             proxy_pass http://backend:3000/;
             proxy_set_header Host $host;
             proxy_set_header X-Real-IP $remote_addr;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_set_header X-Forwarded-Proto $scheme;
         }
     }
     ```

   - `Dockerfile` của `frontend` sẽ cần `COPY` file `index.html` (và các assets khác) vào `/usr/share/nginx/html/` VÀ `COPY` file `nginx.conf` này vào `/etc/nginx/conf.d/default.conf` (ghi đè config mặc định của Nginx).

4. **Viết `docker-compose.yml`:**

   - Định nghĩa 2 services: `frontend` và `backend`.
   - Service `frontend`:
     - Build từ thư mục `frontend/`.
     - Map port host (ví dụ 8080) tới port 80 của container `frontend`.
   - Service `backend`:
     - Build từ thư mục `backend/`.
     - Expose port mà API lắng nghe (ví dụ 3000), nhưng không cần map ra host nếu chỉ `frontend` gọi.
   - Đảm bảo `frontend` `depends_on` `backend` (tùy chọn, nhưng tốt).
   - Các services sẽ tự động nằm trong cùng một network mặc định, `frontend` có thể gọi `backend` bằng tên service.

5. **Chạy và Kiểm tra:**
   - Chạy `docker-compose up --build`.
   - Truy cập `http://localhost:8080` để xem trang HTML tĩnh.
   - Sửa `index.html` của bạn để có một nút hoặc đoạn script JavaScript gọi tới `/api/message` (ví dụ dùng `fetch API`) và hiển thị kết quả lên trang.
   - Kiểm tra xem message từ backend có hiển thị đúng trên frontend không.

**Gợi ý code JavaScript cho `index.html` để gọi API:**

```html
<!-- Thêm vào trong <body> của index.html -->
<button onclick="fetchMessage()">Get Message from Backend</button>
<p id="message_from_api"></p>

<script>
  async function fetchMessage() {
    try {
      const response = await fetch("/api/message"); // Nginx sẽ proxy cái này
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const data = await response.json();
      document.getElementById("message_from_api").textContent = data.text;
    } catch (error) {
      document.getElementById("message_from_api").textContent =
        "Error: " + error.message;
      console.error("Error fetching message:", error);
    }
  }
</script>
```

## 9. 📚 Tài Liệu Tham Khảo & Next Steps

- **Docker Docs:** [https://docs.docker.com/](https://docs.docker.com/)
- **Docker Compose Docs:** [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
- **Best practices for writing Dockerfiles:** [https://docs.docker.com/develop/develop-images/dockerfile_best-practices/](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- **Awesome Docker (GitHub List):** [https://github.com/veggiemonk/awesome-docker](https://github.com/veggiemonk/awesome-docker)
- **Play with Docker (Online Docker playground):** [https://labs.play-with-docker.com/](https://labs.play-with-docker.com/)

**Next Steps:**

- Tìm hiểu về **Multi-stage builds**.
- Nghiên cứu **Docker Swarm** hoặc **Kubernetes (K8s)** cho orchestration ở production scale.
- Tích hợp Docker vào **CI/CD pipelines**.
- Khám phá các **private registries** (AWS ECR, GCR, Azure CR, Harbor).
- Tìm hiểu về **Docker security**.
