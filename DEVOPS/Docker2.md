---
prev:
  text: '🐳 Docker: Fundamentals'
  link: '/DEVOPS/Docker1'
next:
  text: '⚙️ Kubernetes'
  link: '/DEVOPS/Kubernetes'
---

# 🐳 DOCKER: ORCHESTRATION & BEST PRACTICES

## 🎯 Objectives

- Understand the role and benefits of **Docker Compose** in managing multi-container applications.
- Master the syntax and important directives of the `docker-compose.yml` file.
- Know how to effectively define and manage **services**, **networks**, and **volumes** with Docker Compose.
- Practice building a more complex **multi-container** application, including web, database, and caching.
- Learn and apply **best practices** when working with Docker and Docker Compose to optimize development and deployment workflows.
- Understand how Docker Compose simplifies development environment setup and ensures consistency.

## 1. ⏪ Recap

### Key Concepts: Image, Container, Dockerfile, Registry

- **Image**: A read-only template containing everything needed to run an application (code, runtime, libraries, environment variables, config files). Built from a Dockerfile.
- **Container**: A running instance of an image. It is an isolated environment with its own filesystem, process, and network, but shares the Host OS kernel.
- **Dockerfile**: A text file containing instructions for the Docker Engine to automatically build an image.
- **Registry**: A repository for storing and distributing Docker images (e.g., Docker Hub, AWS ECR, Google GCR).

### Basic Docker CLI Commands

- `docker build -t <name:tag> .`: Build an image from a Dockerfile.
- `docker run [OPTIONS] <image>`: Run a container from an image.
  - Important options: `-d` (detached), `-p HOST_PORT:CONTAINER_PORT`, `--name`, `-it` (interactive), `--rm` (auto-remove), `-v HOST_PATH:CONTAINER_PATH` (volume), `-e VAR=value`.
- `docker ps [-a]`: List containers (running / all).
- `docker images`: List images.
- `docker stop/start/restart <container>`: Manage container lifecycle.
- `docker rm <container>`: Remove a container (must be stopped first, or use `-f`).
- `docker rmi <image>`: Remove an image (must not be used by any container, or use `-f`).
- `docker logs [-f] <container>`: View logs.
- `docker exec -it <container> <command>`: Execute a command inside a running container.
- `docker pull <image>` / `docker push <repo/image>`: Interact with a registry.

## 2. 🚀 Introduction to Docker Compose

### Why Docker Compose? The problem with multiple `docker run` commands

Imagine a modern web application often consisting of multiple components (services) working together:

- A `web server` (Nginx, Apache) to serve static files or act as a reverse proxy.
- An `application server` (Node.js, Python/Django/Flask, Java/Spring Boot, Ruby/Rails, PHP/Laravel) containing business logic.
- A `database` (PostgreSQL, MySQL, MongoDB, etc.) to store data.
- Maybe a `caching service` (Redis, Memcached) to speed things up.
- Maybe a `message queue` (RabbitMQ, Kafka) for asynchronous processing.

If you use `docker run` for each service, you will face:

```bash
# Run database (e.g., Postgres)
docker run -d --name my_db \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=appdb \
  -v db_data:/var/lib/postgresql/data \
  --network app_net \
  postgres:14-alpine

# Run backend app, link to DB, expose port
# Need to wait for DB to be ready, know DB IP (or use Docker network and service name)
docker run -d --name my_app \
  --network app_net \
  -p 3000:3000 \
  -e DATABASE_URL="postgresql://user:secret@my_db:5432/appdb" \
  -e NODE_ENV=development \
  -v ./app_src:/usr/src/app \
  my_backend_image:latest

# Run frontend (e.g., Nginx serving static files and proxying API)
docker run -d --name my_frontend \
  --network app_net \
  -p 80:80 \
  -v ./frontend_static:/usr/share/nginx/html \
  -v ./nginx.conf:/etc/nginx/nginx.conf:ro \
  nginx:alpine

# And potentially many other services...
```

**The difficulties:**

- **Too many long and complex `docker run` commands:** Hard to remember, easy to mistype.
- **Managing dependencies:** Service A needs Service B to be running and ready first (e.g., app needs DB). `docker run` lacks a clear `depends_on` mechanism.
- **Managing networks:** Must manually create a Docker network (`docker network create app_net`) and connect containers to it so they can see each other.
- **Managing volumes:** Declaring volumes for each service.
- **Configuration:** Passing environment variables, mounting config files for each service.
- **Hard to share and reproduce:** Giving a colleague a list of `docker run` commands to setup an environment is inefficient and error-prone.
- **Hard to scale (at a basic level):** Running multiple instances of a service becomes complicated.
- **Stopping and cleaning up:** Must `docker stop` and `docker rm` each container individually.

Docker Compose was created to solve all these problems.

### What is Docker Compose?

- It is a command-line tool (CLI tool) to **define** and **run** **multi-container** Docker applications easily.
- Uses a single configuration file written in **YAML** (usually `docker-compose.yml`) to describe your entire application "stack", including:
  - The `services` (corresponding to containers).
  - Configuration for each service: which image to build/pull, ports, volumes, environment variables, dependencies, networks, etc.
  - `Networks` that services will connect to.
  - `Volumes` to store persistent data.
- With a single command (e.g., `docker-compose up`), you can initialize, configure, and run the entire application with all related services.

**Key Benefits of Docker Compose:**

- **Simplified management:** All configuration is in one file, easy to read, understand, and manage.
- **Consistent environment reproduction:** Ensures development, testing, and staging environments are the same for every team member and on different machines.
- **Faster development:** Quick environment setup, focus on code instead of configuration hassles.
- **Good integration with Docker Engine:** Uses familiar Docker concepts.
- **Easy application lifecycle management:** `up`, `down`, `start`, `stop`, `restart` the entire stack or individual services.
- **Environment isolation:** Each Compose project can run independently without affecting others.

```text
                            +----------------------------+
                            |     docker-compose.yml     |
                            | (Define App Stack)         |
                            +-------------+--------------+
                                          | (Input for)
                                          v
+---------------------------------------+----------------------------------------+
|                               DOCKER COMPOSE CLI                               |
| (`docker-compose up`, `down`, `ps`, `logs`, `exec`, etc.)                      |
+---------------------------------------+----------------------------------------+
                                          | (Commands Docker Daemon)
                                          v
+--------------------------------------------------------------------------------+
|                                  DOCKER HOST                                   |
| +----------------------------------------------------------------------------+ |
| |                              Docker Daemon                                 | |
| |  (Creates and manages containers, networks, volumes based on docker-compose.yml) | |
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

### Installing Docker Compose

- **Docker Desktop (Windows, macOS):** Docker Compose is usually pre-installed with Docker Desktop. You don't need to install it separately.
- **Linux:**

  - Usually requires separate installation. A common way is to download the binary from Docker Compose GitHub releases.
  - Refer to the official installation guide: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)
  - Example command (version may vary, always check the homepage):

    ```bash
    # Download latest stable version
    LATEST_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
    sudo curl -L "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Check installation
    docker-compose --version
    ```

  - Some Linux distributions may provide Docker Compose via package managers (`apt`, `yum`), but versions might be older.

Note: `docker-compose` (with hyphen) is version V1. `docker compose` (without hyphen) is version V2, integrated directly into the Docker CLI. Currently, V2 is recommended. If your Docker Desktop is new, `docker compose` will work. On Linux, the above installation could be V1 or V2 depending on version. Basically, the YAML file syntax and main commands are similar.

## 3. 🎼 `docker-compose.yml` Syntax

The `docker-compose.yml` file is a YAML format text file, the heart of Docker Compose. YAML (YAML Ain't Markup Language) is a human-readable data serialization format using indentation to represent structure. **IMPORTANT: YAML is very sensitive to indentation. Always use spaces, not tabs, and consistent indentation (usually 2 spaces).**

This file is usually located at the root of the project.

### `version`

Specifies the version of the Compose file syntax you are using. This is important because different versions may support different features and syntax.

```yaml
version:
  "3.8" # Or "3.9", "3.x". Should use the latest version supported by your Docker Engine.
  # Version "2.x" is older, "3.x" is popular now.
  # Docker Compose V2 (docker compose) doesn't strictly require version string, but it's good practice.
```

### `services`

This is where you define the components (containers) of your application. Each key under `services` is the **name of a service**. This name is important because it will be used by Docker Compose for referencing between services (e.g., service `web` can connect to service `db` using hostname `db`).

```yaml
services:
  web:# Name of service 1 (e.g.,
    frontend or web server)
    # ... configuration for service 'web' ...
  api:# Name of service 2 (e.g.,
    backend application)
    # ... configuration for service 'api' ...
  db:# Name of service 3 (e.g.,
    database)
    # ... configuration for service 'db' ...
```

Under each service name, you will declare its configuration details:

### `build` vs `image`

Specifies the Docker image to be used for the service. You can use one or the other (or sometimes both).

- **`image: <image_name>:<tag>`**:
  Uses an existing image from Docker Hub or a private registry. Docker Compose will `pull` this image if it's not available locally.

  ```yaml
  services:
    database:
      image: postgres:14-alpine # Get postgres version 14-alpine image
    redis:
      image: redis:7-alpine
  ```

- **`build: <path_to_context>`** or **`build: { context: <path>, dockerfile: <name>, args: ... }`**:
  Docker Compose will build an image from a Dockerfile.
  - Simple string format:

    ```yaml
    services:
      backend:
        build:
          ./app_folder # Path to directory containing Dockerfile (build context)
          # Docker Compose will look for a file named 'Dockerfile' in there.
    ```

  - Object format to provide more details:

    ```yaml
    services:
      backend:
        build:
          context: ./app_folder # Build context directory.
          dockerfile: Dockerfile.dev # Dockerfile name (if different from 'Dockerfile').
          args: # --build-arg variables passed to Dockerfile.
            NODE_VERSION: 18
            APP_ENV: development
          # target: builder          # (Optional) Only build a specific stage in multi-stage Dockerfile.
          # cache_from:              # (Optional) Use cache from other images.
          #   - myapp_cache:latest
    ```

  - You can use both `image` and `build`. Docker Compose will build (if `build` is defined) and tag that image with the name provided in `image`. If that image already exists and you don't request a rebuild, it will use that image.

  ```yaml
  services:
    custom_app:
      build: ./my_app_src
      image: myusername/my_custom_app:latest # After build, image will be tagged like this
  ```

### `ports`

Maps ports between host machine and container. Format: `"HOST_PORT:CONTAINER_PORT"`.
If only `"CONTAINER_PORT"` is written, Docker will automatically choose a random port on the host.

```yaml
services:
  frontend:
    image: nginx:latest
    ports:
      - "8080:80" # Map host port 8080 to container frontend port 80.
      - "127.0.0.1:8081:81" # Map host port 8081 (localhost only) to container port 81.
      # - "443:443"     # Map host port 443 to container port 443 (for HTTPS).
      # - "9000"        # Expose container port 9000 to a random host port.
```

### `volumes`

Mount directories from host to container (bind mount) or manage data volumes (named volumes) for persistent data storage.
Format:

- Bind mount: `"HOST_PATH:CONTAINER_PATH"` or `"HOST_PATH:CONTAINER_PATH:ro"` (read-only).
- Named volume: `"VOLUME_NAME:CONTAINER_PATH"`.
- Anonymous volume: `"CONTAINER_PATH"` (rarely used directly in compose, managed by Docker).

```yaml
services:
  backend:
    build: ./backend_app
    volumes:
      # Bind mount: changing code on host -> changes in container (very useful for dev)
      - ./backend_app/src:/app/src
      # Named volume: persist logs, separated from container lifecycle
      - app_logs:/app/logs
      # Anonymous volume (in this case, to prevent node_modules in container from being overwritten by host)
      - /app/node_modules
  database:
    image: postgres:14
    volumes:
      # Named volume: store DB data, ensure data persists when container is removed/recreated
      - db_data:/var/lib/postgresql/data
      # Bind mount: mount custom config file
      - ./custom-postgres.conf:/etc/postgresql/postgresql.conf:ro

# Declare top-level named volumes (if not declared, Docker auto-creates with project_prefix)
volumes:
  db_data:# Docker will create and manage a volume named 'myproject_db_data' (if project is named myproject)
    # driver: local # Default
    # external: true # If volume was created outside Docker Compose
    # name: my_existing_db_data # If using external volume with different name
  app_logs:
```

(Will discuss more in Docker Volumes section)

### `environment`

Sets environment variables for the container. Multiple declaration ways:

- List format (array of strings `KEY=VALUE`):

  ```yaml
  services:
    api:
      image: my-api-image
      environment:
        - NODE_ENV=development
        - API_KEY=your_api_key_here
        - DATABASE_URL=postgresql://user:pass@db_service_name:5432/mydb
  ```

- Map format (dictionary `KEY: VALUE`):

  ```yaml
  services:
    api:
      image: my-api-image
      environment:
        NODE_ENV: development
        API_KEY: your_api_key_here # Value can be number, boolean, or string (should be quoted if special chars)
        DEBUG_MODE: "true"
  ```

- Reference from `.env` file (file named `.env` located alongside `docker-compose.yml`):
  Docker Compose automatically reads `.env` file and variables can be used in `docker-compose.yml` using syntax `${VARIABLE_NAME}`.

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
        POSTGRES_USER: ${POSTGRES_USER} # Reference from .env
        POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
        # POSTGRES_DB: ${POSTGRES_DB:-default_db_name} # Syntax with default value
    web:
      image: my_web_app
      ports:
        - "${WEB_PORT}:3000"
  ```

### `env_file`

Specifies one or more files containing environment variables to load into the container. Each line in the file must be in `KEY=VALUE` format.

```yaml
services:
  api:
    image: my-api
    env_file:
      - ./common.env # Path to common env file
      - ./api.prod.env # Specific env file for production (overrides common.env if keys clash)
      # - .env             # Can also load default .env file
```

**Environment variable priority:**

1. Values set in `docker-compose.yml` (`environment` section).
2. Values passed via CLI (`docker-compose run -e KEY=VAL ...`).
3. Values from `env_file`.
4. Values from `.env` file (if using `${VAR}` substitution).
5. Default values in image (from `ENV` in Dockerfile).

### `depends_on`

Specifies startup order and dependencies between services. Service A `depends_on` Service B means Docker Compose will ensure Service B is **started** _before_ Service A.
**Important Note:** `depends_on` only ensures the dependent service container has _started_, **not** that the application inside that container is _ready_ to accept connections (e.g., database needs time to initialize, web server needs time to load).

```yaml
services:
  api:
    build: ./api_app
    depends_on:
      - db # api will start after 'db' container has started
      - redis # and after 'redis' container has started
  db:
    image: postgres
  redis:
    image: redis
```

To handle "wait for service ready", you usually need:

- Use `healthcheck` (see below). `depends_on` can be configured to wait for dependent service to be `healthy`.

  ```yaml
  services:
    api:
      build: ./api
      depends_on:
        db:
          condition: service_healthy # Wait for db to report healthy
    db:
      image: postgres
      healthcheck: # Configure healthcheck for db
        test: ["CMD-SHELL", "pg_isready -U postgres"]
        interval: 10s
        timeout: 5s
        retries: 5
  ```

- Or use scripts like `wait-for-it.sh` or `dockerize` inside dependent service's entrypoint/command.

### `networks`

Allows services to connect to each other.

- **Default:** Docker Compose automatically creates a **default bridge network** for all services in the file. Network name is usually `<project_name>_default` (project_name is the directory name containing `docker-compose.yml`). Services in this same network can communicate with each other using service names.
- **Custom networks:** You can define custom networks for better control.

```yaml
services:
  frontend:
    image: nginx
    networks: # Connect 'frontend' service to 'front-tier' network
      - front-tier
  api:
    image: my-api
    networks: # Connect 'api' service to both 'front-tier' and 'back-tier'
      - front-tier
      - back-tier
  db:
    image: postgres
    networks: # Connect 'db' service only to 'back-tier' (increased security)
      - back-tier

# Declare top-level networks
networks:
  front-tier:
    driver: bridge # Default
  back-tier:
    driver: bridge
    # internal: true # (Optional) If true, this network has no external access
```

(Will discuss more in Docker Networking section)

### `command`

Overrides default `CMD` defined in the image's Dockerfile.

```yaml
services:
  worker:
    image: my-worker-image
    command: ["python", "process_queue.py", "--verbose"] # Override CMD of image
    # command: /app/start-worker.sh # Shell form
```

### `entrypoint`

Overrides default `ENTRYPOINT` defined in the image's Dockerfile.

```yaml
services:
  app:
    image: my-app-image
    entrypoint: /usr/local/bin/custom-entrypoint.sh
    # entrypoint: ["python", "manage.py"]
    # command: ["runserver", "0.0.0.0:8000"] # command becomes argument for new entrypoint
```

**Note:** If you override `entrypoint`, `command` will become arguments to that new `entrypoint`. If you only override `command`, it will be arguments to the original `entrypoint` of the image (or the main command if image has no `entrypoint`).

### `restart`

Restart policy for container if it stops or fails.

- `no`: (Default) Do not automatically restart.
- `always`: Always restart container if it stops, unless explicitly stopped (by `docker stop` or `docker-compose stop`).
- `on-failure`: Only restart if container exits with non-zero exit code (error).
  - `on-failure:5`: Restart max 5 times.
- `unless-stopped`: Always restart, unless container is explicitly stopped by user or Docker daemon is stopped/restarted.

```yaml
services:
  backend:
    image: my-backend
    restart: always # Always try to run this service
  worker:
    image: my-worker
    restart: on-failure # Restart if worker crashes
```

### `healthcheck`

Configure "health" check for service, similar to `HEALTHCHECK` in Dockerfile. Docker Compose will use this info to know if service is operating normally. Useful when combined with `depends_on` and in orchestration environments.

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
      interval: 15s # Check every 15 seconds
      timeout: 5s # Wait max 5 seconds for test command to complete
      retries: 3 # Retry 3 times if fails
      start_period: 30s # Initial wait time before starting healthcheck (for slow init DBs)
    environment:
      POSTGRES_USER: user
      POSTGRES_DB: appdb
```

Healthcheck status can be viewed using `docker ps` or `docker inspect`.

### `expose`

Expose container ports **only to other services in the same network**, not publishing to host.
Useful when you have an internal service (e.g., database) that doesn't need access from outside host, but other services in Compose stack need to connect to it.

```yaml
services:
  db:
    image: mysql:8.0
    expose:
      - "3306" # Other services in same network can connect to 'db:3306'
    # ports: # Don't use 'ports' if you don't want to map to host
    #  - "3306:3306" # This would map to host
```

Actually, with Docker Compose default network, services can already communicate with each other via service name and port the app inside container listens on, even without `expose`. `expose` is mostly for documentation or when used with other network drivers.

### `extends`

Allows sharing common configuration between services or between different Compose files.

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
      file: common-services.yml # File containing common config
      service: base_app # Name of service in that file to inherit
    build: ./web_app
    ports:
      - "80:8000"
    environment: # Override or add environment variables
      APP_SPECIFIC_VAR: "web_value"
  worker:
    extends:
      file: common-services.yml
      service: base_app
    build: ./worker_app
    environment:
      APP_SPECIFIC_VAR: "worker_value"
```

### `secrets` and `configs`

(Advanced, usually used with Docker Swarm, but Compose also supports to some extent for local dev)

- `secrets`: Manage sensitive data (passwords, API keys). Secrets are mounted into container as files in `/run/secrets/` (read-only).
- `configs`: Manage non-sensitive config files. Similar to secrets, mounted into container.

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
    file: ./db_password.txt # File on host containing password
    # external: true # If secret was created in Docker
configs:
  app_config:
    file: ./app_config.json
    # external: true
```

In container, `db_password` will be at `/run/secrets/db_password` and `app_config` at `/run/configs/app_config` (or original filename if using `target`).

### Simple `docker-compose.yml` Example

App consists of a web app (Node.js) and a Redis instance.

```yaml
version: "3.8" # Always declare version

services:
  # Service 1: Web application (e.g., Node.js app)
  web:
    build: ./app # Directory containing app Dockerfile (e.g., ./app/Dockerfile)
    image: myusername/my-web-app:1.0 # (Optional) Image name after build
    container_name: my_web_container # (Optional) Specific name for container
    ports:
      - "3000:3000" # Map host port 3000 to container port 3000
    volumes:
      # Mount source code from 'app' dir on host to '/usr/src/app' in container
      # Enables live reload when code changes (for dev env)
      - ./app:/usr/src/app
      # Mount anonymous volume for node_modules so it's not overwritten by node_modules on host (if any)
      # This ensures node_modules installed by 'RUN npm install' in Dockerfile are used.
      - /usr/src/app/node_modules
    environment:
      - NODE_ENV=development
      - REDIS_HOST=cache # Service name of Redis
      - REDIS_PORT=6379
    depends_on: # web app depends on Redis
      - cache # Ensures 'cache' service starts before 'web'
    restart: unless-stopped

  # Service 2: Redis (caching)
  cache: # Service name is 'cache', web app will connect to Redis via hostname 'cache'
    image: "redis:7-alpine" # Use official Redis image from Docker Hub
    container_name: my_redis_cache
    # ports: # Not necessary to expose Redis port to host if only internal app uses it
    #   - "6379:6379" # Example if wanting to connect from host to this Redis for debugging
    volumes:
      - redis_data:/data # Use named volume 'redis_data' to store Redis data persistently
    restart: always
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 3

# Declare named volumes at top-level
volumes:
  redis_data:# Docker Compose will auto-create this volume (if not exists) with name project_redis_data
  # driver: local # (Default)
```

**Example directory structure for above example:**

```text
my_project/
├── docker-compose.yml
├── .env               # (Optional) Contains common env vars
└── app/
    ├── Dockerfile
    ├── package.json
    └── server.js
    └── ... (other app files)
```

### Basic Docker Compose Commands

Run these commands from the directory containing `docker-compose.yml`.

- `docker-compose up`: Build (if `build` defined and image missing or needs rebuild), create and start all services. Logs of all services will stream to terminal. Press `Ctrl+C` to stop.
  - `docker-compose up -d`: Run in background (detached mode).
  - `docker-compose up --build`: Always rebuild images before starting (even if image exists).
  - `docker-compose up <service_name> [<service_name2>...]`: Start only specified services (and their dependencies).
- `docker-compose down`: Stop and remove containers, networks, (optional) volumes.
  - `docker-compose down -v`: Remove also named volumes defined in `volumes` section (and anonymous volumes). **CAUTION: Data loss in volumes!**
  - `docker-compose down --rmi all`: Remove also images built by Compose.
  - `docker-compose down --remove-orphans`: Remove containers not defined in compose file anymore.
- `docker-compose ps`: List status of containers managed by Compose for current project.
- `docker-compose logs <service_name>`: View logs of a specific service.
  - `docker-compose logs -f <service_name>`: Follow logs (live stream).
  - `docker-compose logs --tail=50 <service_name>`: View last 50 lines of log.
  - `docker-compose logs`: View logs of all services.
- `docker-compose exec <service_name> <command>`: Run a command inside a **running** service.
  - Example: `docker-compose exec web bash` (open bash shell in `web` service).
  - Example: `docker-compose exec db psql -U myuser -d mydb`
- `docker-compose build <service_name>`: Build (or rebuild) image for one or more services. If no `service_name`, build all.
  - `docker-compose build --no-cache <service_name>`: Build without using cache.
- `docker-compose pull <service_name>`: Pull latest image for one or more services (if service uses `image:`).
- `docker-compose start <service_name>`: Start services that were created but stopped.
- `docker-compose stop <service_name>`: Stop running services without removing them.
- `docker-compose restart <service_name>`: Restart services.
- `docker-compose rm <service_name>`: Remove stopped containers of service.
  - `docker-compose rm -f <service_name>`: Remove even if running.
- `docker-compose run --rm <service_name> <command>`: Run a "one-off" container for a service (usually to run task, test). `--rm` auto-removes after finish. This command will not map ports defined in `ports` (unless using `--service-ports`).
  - Example: `docker-compose run --rm web npm test`
- `docker-compose config`: Check syntax of `docker-compose.yml` file and display resolved configuration (after processing `extends`, `env_file`, environment variables, etc.). Very useful for debugging compose file.
  - `docker-compose -f docker-compose.yml -f docker-compose.override.yml config`: View combined configuration from multiple files.
- `docker-compose top <service_name>`: Display running processes in service.

(Note: If you use Docker Compose V2, commands will be `docker compose ...` instead of `docker-compose ...`)

## 4. 🔗 Docker Networking (with Compose)

Docker Compose makes network management for multi-container applications very simple.

### Default Network (Default Bridge Network)

- When you run `docker-compose up` for the first time for a project (a directory containing `docker-compose.yml`), Compose automatically creates a **user-defined bridge network** default for that application.
- The name of this network is usually named as: `<project_name>_default`.
  - `<project_name>` is the name of the directory containing `docker-compose.yml` (e.g., if directory is `my_app`, network will be `my_app_default`). You can overwrite project name with option `-p <custom_project_name>` or environment variable `COMPOSE_PROJECT_NAME`.
- All `services` defined in `docker-compose.yml` will automatically be connected to this default network.

### Connection between services (Service Discovery)

- This is one of the most powerful features of Docker Compose networking.
- Inside this network, containers (services) can **reference and connect to each other by service name** defined in `docker-compose.yml`.
- Docker Engine provides an **internal DNS server** for this network. When service `web` wants to connect to service `db`, it just needs to use hostname as `db`. Docker DNS will automatically resolve `db` name to internal IP address of the container running service `db`.
  - Example: In code of service `web` (Node.js), database connection string could be:
    `const dbUrl = "postgres://user:password@db:5432/mydb";`
    (With `db` being the service name of PostgreSQL in `docker-compose.yml`).
- **You don't need to `expose` (or `ports`) port of internal service (like database, redis) to host machine if only other services in same Compose network need access.** This improves security. Only `ports` services that need external access (usually web server/frontend).

**Illustration Diagram:**

```text
  Host Machine (Example: IP 192.168.1.100)
  ---------------------------------------------------------------------------------
  |                                                                               |
  |   Docker Network: myproject_default (Ex: 172.18.0.0/16)                       |
  |   -------------------------------------------------------------------------   |
  |   | Service: web (Container A)                                            |   |
  |   | - Internal IP: 172.18.0.2                                             |   |
  |   | - Connect code: connect_to('api:5000'), connect_to('db:5432')         |   |
  |   | - Mapped port: Host:8080 -> Container:80 (Access from outside here)   |   |
  |   -------------------------------------------------------------------------   |
  |   | Service: api (Container B)                                            |   |
  |   | - Internal IP: 172.18.0.3                                             |   |
  |   | - Listening on port 5000 (internal)                                   |   |
  |   | - Connect code: connect_to('db:5432')                                 |   |
  |   -------------------------------------------------------------------------   |
  |   | Service: db (Container C)                                             |   |
  |   | - Internal IP: 172.18.0.4                                             |   |
  |   | - Listening on port 5432 (internal, not mapped to host)               |   |
  |   -------------------------------------------------------------------------   |
  |                                                                               |
  ---------------------------------------------------------------------------------
  User accesses http://localhost:8080 or http://192.168.1.100:8080
      -> Host OS forwards to Container A (web) port 80
          -> Container A (web) can call Container B (api) via 'api:5000'
          -> Container B (api) can call Container C (db) via 'db:5432'
```

### Custom Networks

You can also define custom networks in `docker-compose.yml` to:

- Create multiple networks and connect services to different networks for isolation (e.g., `frontend_net`, `backend_net`).
- Connect to existing networks outside Docker Compose.
- Tweak drivers or options of network.

```yaml
version: "3.8"
services:
  proxy:
    image: nginx
    networks:
      - frontnet # Only connect to frontnet
    ports:
      - "80:80"
  app:
    build: ./app
    networks:
      - frontnet
      - backnet # Connect to both frontnet and backnet
  db:
    image: postgres
    networks:
      - backnet # Only connect to backnet

networks:
  frontnet:
    driver: bridge
    # driver_opts:
    #   com.docker.network.enable_ipv6: "true"
  backnet:
    driver: bridge
    internal: true # This network has no Internet connection, increased security for DB.
  # existing_net: # Connect to existing network
  #   external: true
  #   name: my_preexisting_bridge_network
```

In this example:

- `proxy` and `app` can communicate via `frontnet`.
- `app` and `db` can communicate via `backnet`.
- `proxy` cannot directly communicate with `db`.

## 5. 💾 Docker Volumes (with Compose)

### Why Volumes? (Data Persistence)

- Containers are **ephemeral** (temporary). When a container is removed (`docker rm` or `docker-compose down`), all data written to its filesystem (top writable layer of container) will be **lost permanently**.
- This is not a problem for stateless application servers, but a disaster for:
  - **Databases:** Data is valuable asset.
  - **User uploads:** Images, documents uploaded by users.
  - **Important Logs:** Need storage for analysis, debugging.
  - **Config Files:** Need to persist across container restarts.
- **Volumes** is Docker's mechanism to **store data persistently**, separated from container lifecycle. Data in volume persists even if container using it is removed and recreated.

### Types of Volumes in Docker

Docker supports several types of volumes/mounts:

1. **Bind Mounts**:

    - **Concept:** Mount a file or directory from **host machine filesystem** to a path inside container.
    - **Characteristics:**
      - Very convenient for development: You edit code on host, changes reflected immediately in container, supporting live-reloading.
      - Data managed directly on host.
      - Path on host must exist (or Docker will create empty dir).
      - Can cause performance issues on some OS (macOS, Windows due to file sharing mechanism).
      - Permission issues: UID/GID of file on host might not match user inside container, causing permission denied.
    - **Syntax in Compose:** `- ./path/on/host:/path/in/container` or `- ./path/on/host:/path/in/container:ro` (read-only).

2. **Named Volumes (or just "Volumes")**:

    - **Concept:** Volumes **fully managed by Docker**. Data stored in a special part of host filesystem managed by Docker (usually `/var/lib/docker/volumes/` on Linux). You don't need to care about exact location.
    - **Characteristics:**
      - **Recommended way to store persistent application data** (e.g., database data, logs).
      - Independent of host directory structure.
      - Easy to backup, migrate, share between containers.
      - Better performance than bind mounts on macOS and Windows.
      - Docker auto-creates volume if not exists.
      - Can be managed using `docker volume ...` commands (create, ls, inspect, rm, prune).
    - **Syntax in Compose:** `- volume_name:/path/in/container`. `volume_name` declared at top-level `volumes:` section.

3. **Anonymous Volumes**:

    - **Concept:** Similar to named volumes, but Docker assigns a random name (a long hash string) to that volume.
    - **Characteristics:**
      - Hard to reference back if you don't know its random name.
      - Usually created when you specify container path in `Dockerfile` (`VOLUME /app/data`) or in `docker-compose.yml` (`- /app/data`) without naming the volume.
      - Data still persists, but harder to manage than named volumes.
      - Will be removed by `docker-compose down -v` or `docker volume prune`.
    - **Syntax in Compose (rarely used directly):** `- /path/in/container`

4. **tmpfs Mounts (Linux only)**:
    - **Concept:** Mount a directory into container's RAM, not written to disk.
    - **Characteristics:**
      - Very fast data but **totally non-persistent**. Lost when container stops.
      - Useful for storing temporary, sensitive files you don't want written to disk.
    - **Syntax in Compose:**

      ```yaml
      services:
        myservice:
          image: ...
          tmpfs: /app/tmp # Mount /app/tmp to RAM
          # tmpfs:
          #  - /run
          #  - /tmp:size=100m,mode=755 # Can set size and mode
      ```

**When to use which?**

- **Named Volumes:** **Top priority** for application data needing persistence and independence from host (database data, user uploads, important logs, app state).
- **Bind Mounts:**
  - **Source code in development environment:** For live-reloading, changing code on host and seeing result in container immediately.
  - **Config files:** Mount config file from host to container to easily change without rebuilding image.
  - **Share files between host and container:** Example, build artifacts from container to host.
- **Anonymous Volumes:** Avoid active use. If you need persistent data, use named volume. A common use case is `- /app/node_modules` to prevent bind mount of source code overwriting `node_modules` installed by `RUN npm install` in image.
- **tmpfs Mounts:** For temporary data, no need storage, or sensitive data.

### Declaring and Using Volumes in Compose

Partially illustrated above.

1. **Declare Named Volumes at top-level `volumes:` section:**
    This is where you define named volumes your services will use.

    ```yaml
    version: "3.8"
    # ... services ...

    volumes:
      postgres_data: # Volume name you will reference in service
        driver: local # (Default) Driver for volume, usually 'local'
        # external: true # Set true if this volume was created outside compose (using docker volume create)
        # name: my_actual_external_volume_name # Actual name of external volume
        # driver_opts:
        #   type: "nfs"
        #   o: "addr=192.168.1.1,rw"
        #   device: ":/path/to/nfs/share"
      mysql_data:
      app_uploads:
    ```

2. **Use Volumes in `services.<service_name>.volumes`:**
    In each service, you declare volumes it will use.

    ```yaml
    services:
      db_postgres:
        image: postgres:14
        volumes:
          # Use named volume 'postgres_data' declared at top-level
          # Mount to /var/lib/postgresql/data inside container
          - postgres_data:/var/lib/postgresql/data
          # Bind mount config file from host
          - ./config/postgres/custom.conf:/etc/postgresql/postgresql.conf:ro
          # Bind mount DB init script (runs once)
          - ./init-db.sh:/docker-entrypoint-initdb.d/init-db.sh

      db_mysql:
        image: mysql:8
        volumes:
          - mysql_data:/var/lib/mysql # Named volume

      web_app:
        build: ./my_web_app_src
        volumes:
          # Bind mount source code for development
          - ./my_web_app_src:/usr/src/app
          # Named volume for user uploads
          - app_uploads:/usr/src/app/public/uploads
          # Anonymous volume to protect node_modules in image
          - /usr/src/app/node_modules
    ```

## 6. 🛠️ Practice: Build Web App + Database + Cache with Docker Compose

**Goal:** Create a simple Node.js/Express web application with features:

1. Display a page visit counter.
2. Store and retrieve this counter from Redis (cache).
3. If Redis misses, or on restart, fetch value from PostgreSQL (database) and update Redis.
4. When page visited, increment counter, save to Redis and (asynchronously) to PostgreSQL.

**Expected Directory Structure:**

```text
compose_advanced_practice/
├── docker-compose.yml
├── .env                 # Contains DB credentials
└── web_app/
    ├── Dockerfile
    ├── package.json
    ├── server.js
    └── init_db.sql      # (Optional) SQL script to init table
```

**1. `web_app/package.json`:**
(Run `cd web_app && npm init -y && npm install express redis pg`)

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
    "redis": "^4.6.7", // Redis client v4 uses Promises
    "pg": "^8.11.0" // PostgreSQL client
  },
  "devDependencies": {
    "nodemon": "^2.0.15" // (Optional) For live reload in dev
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

// --- Configure Redis Client (v4) ---
const redisClient = redis.createClient({
  socket: {
    host: process.env.REDIS_HOST || "localhost", // Will be 'cache_service' from docker-compose
    port: process.env.REDIS_PORT || 6379,
  },
});

redisClient.on("error", (err) => console.error("Redis Client Error", err));
(async () => {
  await redisClient.connect();
  console.log("Connected to Redis!");
})();

// --- Configure PostgreSQL Client ---
const pgPool = new Pool({
  user: process.env.POSTGRES_USER,
  host: process.env.POSTGRES_HOST, // Will be 'db_service' from docker-compose
  database: process.env.POSTGRES_DB,
  password: process.env.POSTGRES_PASSWORD,
  port: process.env.POSTGRES_PORT || 5432,
});

pgPool.on("connect", () => console.log("Connected to PostgreSQL!"));
pgPool.on("error", (err) => console.error("PostgreSQL Client Error", err));

// --- Function to init table if not exists ---
async function initializeDatabase() {
  try {
    await pgPool.query(`
      CREATE TABLE IF NOT EXISTS visit_counts (
        id VARCHAR(255) PRIMARY KEY DEFAULT 'page_visits',
        count INTEGER NOT NULL DEFAULT 0
      );
    `);
    // Insert default row if not exists
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

// --- Main Logic ---
const COUNTER_KEY = "page_visits_counter";

app.get("/", async (req, res) => {
  let visits = 0;
  try {
    // 1. Try get from Redis
    const redisVisits = await redisClient.get(COUNTER_KEY);

    if (redisVisits !== null) {
      visits = parseInt(redisVisits, 10);
    } else {
      // 2. If not in Redis, get from DB
      const dbResult = await pgPool.query(
        "SELECT count FROM visit_counts WHERE id = 'page_visits'"
      );
      if (dbResult.rows.length > 0) {
        visits = dbResult.rows[0].count;
      } else {
        // Fallback if DB also empty (though init_db should handle this)
        visits = 0;
        await pgPool.query(
          "INSERT INTO visit_counts (id, count) VALUES ('page_visits', 0) ON CONFLICT (id) DO UPDATE SET count = 0"
        );
      }
      // Update to Redis
      await redisClient.set(COUNTER_KEY, visits);
      console.log("Loaded visits from DB to Redis:", visits);
    }

    // 3. Increment counter
    visits++;

    // 4. Save back to Redis
    await redisClient.set(COUNTER_KEY, visits);

    // 5. (Async) Save to DB
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

// --- Start server ---
app.listen(PORT, async () => {
  await initializeDatabase(); // Ensure table exists when server starts
  console.log(`Web app listening on port ${PORT}`);
});
```

**3. `web_app/Dockerfile`:**

```dockerfile
FROM node:18-alpine

WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if exists)
COPY package*.json ./

# Install dependencies (including devDependencies if no --production)
# In dev env, might want devDependencies too (like nodemon)
RUN npm install

# Copy all source code
COPY . .

# Expose port app runs on
EXPOSE 3000

# Command to run app (use nodemon if in devDependencies and is dev env)
# You can pass NODE_ENV env var from docker-compose.yml
# CMD if [ "$NODE_ENV" = "development" ]; then npm run dev; else npm start; fi
# Or simpler:
CMD [ "npm", "start" ]
```

**4. `web_app/init_db.sql` (Optional, if you want Postgres to auto-run this script):**

```sql
-- web_app/init_db.sql
-- This script is not needed if server.js auto-creates table, but is another way.
CREATE TABLE IF NOT EXISTS visit_counts (
  id VARCHAR(255) PRIMARY KEY DEFAULT 'page_visits',
  count INTEGER NOT NULL DEFAULT 0
);

INSERT INTO visit_counts (id, count)
VALUES ('page_visits', 0)
ON CONFLICT (id) DO NOTHING;

-- You can add other tables here
-- CREATE TABLE IF NOT EXISTS users (...);
```

**5. `.env` file (in `compose_advanced_practice` directory):**

```env
# .env
# Credentials for PostgreSQL
POSTGRES_USER=dockeruser
POSTGRES_PASSWORD=dockerpass
POSTGRES_DB=appdb
POSTGRES_PORT=5432 # Port inside DB container

# Config for App
NODE_ENV=development
PORT=3000 # App port listening inside container

# Config for Redis (no credentials needed for this example)
REDIS_HOST=cache_service # Service name of Redis in docker-compose
REDIS_PORT=6379
```

**6. `docker-compose.yml` (in `compose_advanced_practice` directory):**

```yaml
version: "3.8"

services:
  # Web Application Service
  app:
    build: ./web_app
    container_name: node_app_service
    ports:
      - "${PORT}:${PORT}" # Use PORT var from .env for host, map to PORT in container
    volumes:
      - ./web_app:/usr/src/app # Mount source code for live reload
      - /usr/src/app/node_modules # Anonymous volume to keep image's node_modules
    environment: # Pass necessary environment variables to app
      NODE_ENV: ${NODE_ENV}
      PORT: ${PORT}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_HOST: db_service # Name of PostgreSQL service
      POSTGRES_PORT: ${POSTGRES_PORT} # PostgreSQL port listening INSIDE network
      REDIS_HOST: ${REDIS_HOST} # Name of Redis service
      REDIS_PORT: ${REDIS_PORT}
    depends_on: # App depends on db and cache
      db_service:
        condition: service_healthy # Wait for db_service healthy
      cache_service:
        condition: service_healthy # Wait for cache_service healthy
    restart: unless-stopped

  # PostgreSQL Database Service
  db_service:
    image: postgres:14-alpine
    container_name: postgres_db_service
    environment: # These vars are used by postgres image to init DB
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
    volumes:
      - postgres_app_data:/var/lib/postgresql/data # Named volume for Postgres data
      # - ./web_app/init_db.sql:/docker-entrypoint-initdb.d/init.sql # (Optional) Mount init SQL script
    ports: # Only map to host if you need external DB access (e.g., via pgAdmin)
      - "5433:5432" # Host port 5433 -> Container port 5432 (avoid conflict if host has Postgres at 5432)
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB -q || exit 1",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 20s # Give Postgres time to init
    restart: always

  # Redis Cache Service
  cache_service:
    image: redis:7-alpine
    container_name: redis_cache_service
    volumes:
      - redis_app_data:/data # Named volume for Redis data (if Redis configured to persist)
    # ports: # Only map to host if you need external Redis access (e.g., via redis-cli from host)
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

**Run the application:**

1. **Prepare:**
    - Ensure you created files and directories as structure above.
    - In `web_app` folder, run `npm init -y` and `npm install express redis pg nodemon` (if you want `nodemon`).
2. **Start:**
    Open terminal in `compose_advanced_practice` directory (containing `docker-compose.yml`).
    Run: `docker-compose up --build` (or `docker compose up --build` for V2).
    `-d` to run in background: `docker-compose up -d --build`.
3. **Verify:**
    - Open browser and access `http://localhost:3000` (or port you set in `.env`).
    - Each refresh, counter increases.
    - Check logs: `docker-compose logs app`, `docker-compose logs db_service`, `docker-compose logs cache_service`.
    - (If DB/Redis ports mapped to host) You can connect to PostgreSQL (via port 5433) or Redis (via port 6380) from host machine to check data.
4. **Test persistence and cache:**
    - Refresh page a few times.
    - Stop and restart entire stack: `docker-compose down` (DO NOT use `-v` if you want to keep DB data) then `docker-compose up`. Counter should be fetched from DB and continue.
    - If you stop Redis (`docker-compose stop cache_service`), app should still work (fetch from DB). Restart Redis (`docker-compose start cache_service`), it will be updated again.
5. **Cleanup:**
    `docker-compose down`
    To remove volumes too (lose DB and Redis data): `docker-compose down -v`

## 7. ✨ Best Practices & Tips

### Dockerfile Best Practices (Recap and Additions)

- **Use official and small base images (official & slim images):** Prefer `alpine` images (e.g., `node:18-alpine`, `python:3.10-alpine`) as they are small, reducing attack surface.
- **Use specific tags for base image:** Avoid `latest` (e.g., `node:18.17.0-alpine` instead of `node:alpine` or `node:latest`) to ensure consistent builds and avoid unexpected issues when `latest` changes.
- **Optimize command order to leverage caching:** Place least changing commands at top (e.g., `FROM`, `ENV`, `RUN apt-get install ...`). `COPY package.json` and `RUN npm install` should be before `COPY . .` (since dependencies change less than source code).
- **Reduce number of layers:** Each `RUN`, `COPY`, `ADD` creates a layer. Combine related `RUN` commands with `&&` and `\` (line continuation) to reduce layer count, making image smaller and build faster.

  ```dockerfile
  RUN apt-get update && apt-get install -y \
      package1 \
      package2 \
      package3 \
   && rm -rf /var/lib/apt/lists/* # Clear package manager cache
  ```

- **Use `.dockerignore` effectively:** Exclude unnecessary files/folders (e.g., `.git`, host `node_modules`, `*.log`, `*.tmp`, `Dockerfile` itself) from build context.
- **Run application with non-root user:** Enhance security. Create user/group with `RUN` and switch to that user with `USER`.

  ```dockerfile
  RUN addgroup -S appgroup && adduser -S appuser -G appgroup
  USER appuser
  ```

- **Use multi-stage builds:** To create compact production images, containing only runtime and compiled artifact, without build tools, original source code, or dev dependencies.

  ```dockerfile
  # Stage 1: Build stage (Node.js example)
  FROM node:18-alpine AS builder
  WORKDIR /app
  COPY package*.json ./
  RUN npm ci --only=production
  COPY . .
  RUN npm run build # Assuming there's a build script (e.g., transpile TS, bundle frontend)

  # Stage 2: Production stage
  FROM node:18-alpine
  WORKDIR /app
  # (Optional) Create non-root user
  RUN addgroup -S appgroup && adduser -S appuser -G appgroup

  # Copy only necessary things from builder stage
  COPY --from=builder /app/node_modules ./node_modules
  COPY --from=builder /app/dist ./dist  # Or ./build depending on your output
  COPY --from=builder /app/package.json ./package.json # Might be needed for runtime

  # (Optional) Switch user
  # USER appuser

  EXPOSE 3000
  CMD [ "node", "dist/server.js" ] # Run from built artifact
  ```

- **`COPY` instead of `ADD` for local files/folders:** `COPY` is clearer. Only use `ADD` when you really need auto-extraction of tarballs or downloading files from URL (though URL download in Dockerfile isn't really best practice, can do in entrypoint script).
- **Understand `CMD` and `ENTRYPOINT`:**
  - `ENTRYPOINT` defines main executable.
  - `CMD` provides default arguments for `ENTRYPOINT` or default command if no `ENTRYPOINT`.
  - Prefer exec form (`["executable", "param1"]`).
- **Don't store secrets in image:** Use environment variables passed at runtime, or Docker secrets/configs, or dedicated secret management solutions (HashiCorp Vault).
- **Cleanup after installation:** Remove package manager cache (`rm -rf /var/lib/apt/lists/*`, `apk add --no-cache ...`), temporary files, unneeded compiled source code in same `RUN` layer.

### Docker Compose Best Practices

- **Use `version: "3.x"`** (latest version supported by your Docker Engine, typically 3.8 or 3.9).
- **Name services clearly.** Service name is also hostname for service discovery.
- **Use environment variables and `.env` file:**
  - To configure parameters changing between environments (dev, test, prod) like database credentials, API keys, ports.
  - **Do not hardcode credentials** directly in `docker-compose.yml`.
  - `.env` file at project root is auto-loaded by Docker Compose.
- **Use `depends_on` and `healthcheck`:**
  - `depends_on` to control startup order.
  - Combine `depends_on` with `condition: service_healthy` and `healthcheck` in dependent service to ensure that service is truly ready before another service starts.
- **Only `ports` (map to host) services that truly need external access.** Services communicating internally via Compose network don't need port mapping to host.
- **Use `volumes` for persistent data (named volumes) and source code in dev (bind mounts).**
  - Name volumes clearly.
  - Be careful with `docker-compose down -v` (deletes named volumes).
- **Separate configuration for environments (dev, staging, prod):**
  - Use multiple Compose files: `docker-compose.yml` (base), `docker-compose.override.yml` (dev, auto loaded), `docker-compose.prod.yml`, `docker-compose.test.yml`.
  - Use `-f` option to specify compose files to load:
    `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d`
  - `docker-compose.override.yml` is default override file loaded after `docker-compose.yml` if exists, very handy for dev overrides (e.g., add source bind mount, map debug port).
- **Use appropriate `restart` policies:** `always` or `unless-stopped` for critical services (DB, web server), `on-failure` for workers.
- **Set `container_name` (optional):** Helps container have fixed name, easier to reference with `docker` CLI, but can cause conflict if running multiple identical Compose projects. Default Compose creates names like `<project>_<service>_<instance_number>`.
- **Use `profiles` (Compose v2.1+):** Allows defining optional service groups, started only when profile is activated. Useful to enable/disable non-core services (e.g., debug tools, experimental services).

  ```yaml
  services:
    web:# Always run
      # ...
    db:# Always run
      # ...
    mailhog: # Service to test email, runs only when 'dev-tools' profile is active
      image: mailhog/mailhog
      profiles: ["dev-tools"]
      ports:
        - "1025:1025" # SMTP
        - "8025:8025" # Web UI
  # Run: docker-compose --profile dev-tools up
  ```

### Use `.dockerignore`

Recap from Dockerfile section: `.dockerignore` file (placed alongside `Dockerfile`) specifies files/folders **NOT** to be sent to Docker daemon when building image (in `build context`).
Example `.dockerignore` for a Node.js project:

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
Dockerfile # Don't need to copy Dockerfile itself into image
.dockerignore

# Environment files (should be managed outside image)
.env
*.env.local
*.env.development.local
*.env.test.local
*.env.production.local

# Optional: Local config files not for image
config/local.json
```

This helps:

- **Reduce build context size** -> faster send to daemon.
- **Avoid accidental copy of sensitive files** (like `.env` with credentials) into image.
- **Avoid overwriting files/folders** created by `RUN` commands in Dockerfile (e.g., `node_modules` in image not overwritten by `node_modules` on host if `COPY . .` is used).
- **Optimize Docker build cache:** If unnecessary files change, it won't invalidate `COPY` instruction cache.

### Environment Management (Dev, Staging, Prod)

Use combination of `docker-compose.yml`, `docker-compose.override.yml`, and environment-specific files (e.g., `docker-compose.prod.yml`), along with environment variables.

- **`docker-compose.yml` (Base):** Contains common, stable config for all environments. Usually config closest to production but without secrets.
- **`docker-compose.override.yml` (Dev default):**
  - Automatically loaded by `docker-compose up` if exists.
  - Override/add config for development environment.
  - Example:
    - Mount source code with bind volumes for live reload.
    - Map extra ports (e.g., debug port for Node.js).
    - Use image with dev tools (e.g., `node:18-alpine` instead of `node:18-slim`).
    - Change `command` to run with `nodemon` or similar.
    - Add dev-only services (e.g., `mailhog`, `adminer`).
- **`docker-compose.prod.yml` (Production):**
  - Contains production-specific config.
  - Example:
    - No source code mount.
    - Use image optimized for production (e.g., from multi-stage build).
    - Configure `restart: always`.
    - Configure proper logging for production.
    - Use environment variables or secrets for credentials.
  - Run: `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d`
- **Environment variables:**
  - Use `.env` file for default or non-sensitive values.
  - On production server, sensitive environment variables should be injected by CI/CD system or orchestration platform, not committed to Git.

## 8. 🏋️ Exercise

**Requirement:** Extend the basic Docker exercise (static web app with Nginx) by adding a simple backend API service and managing everything with Docker Compose. Frontend will call this API to fetch data.

**Detailed Description:**

- **Service 1: `frontend`**
  - Use `nginx:alpine` image (or `httpd:alpine`).
  - Serve an `index.html` file and (optional) `style.css`.
  - `index.html` will have a button. When clicked, JavaScript calls an API endpoint of `backend` service (e.g., `/api/data`) and displays returned result on page.
  - Nginx needs to be configured to **proxy requests with prefix `/api/`** to `backend` service.
- **Service 2: `backend`** (New Service)
  - Create an extremely simple API app using **Node.js/Express** (or Python/Flask, Go... your choice, but Node.js preferred for example).
  - This API has one endpoint, e.g., `/data` (when Nginx proxies, it will be `/api/data` from client side). This endpoint returns a JSON object, e.g.,
    `{"message": "Hello from Backend API managed by Docker Compose!", "timestamp": "2023-10-27T10:30:00Z"}`.
  - Write `Dockerfile` for this `backend` service.

**Task:**

1. **Expected Directory Structure:**

    ```text
    my_fullstack_app/
    ├── docker-compose.yml
    ├── .env                   # (Optional) For frontend port
    ├── frontend/              # Frontend service
    │   ├── Dockerfile         # Dockerfile for Nginx (mainly COPY files)
    │   ├── nginx.conf       # Nginx config for proxy_pass
    │   └── public/            # Directory containing static files
    │       ├── index.html
    │       └── style.css (optional)
    └── backend/               # Backend service
        ├── Dockerfile         # Dockerfile for Node.js API
        ├── package.json
        ├── server.js          # API Code
        └── ...
    ```

2. **Create `backend` service (Node.js/Express):**

    - `cd backend`
    - `npm init -y`
    - `npm install express`
    - `server.js`:

      ```javascript
      const express = require("express");
      const app = express();
      const PORT = process.env.BACKEND_PORT || 3001; // Backend port listening INSIDE container

      app.get("/data", (req, res) => {
        console.log("Backend /data endpoint hit!");
        res.json({
          message: "Hello from Backend API managed by Docker Compose!",
          timestamp: new Date().toISOString(),
          servedByHost: req.hostname, // Will be container ID or name if no alias
        });
      });

      app.listen(PORT, "0.0.0.0", () => {
        // Listen on all network interfaces inside container
        console.log(`Backend API listening on port ${PORT}`);
      });
      ```

    - `Dockerfile` (in `backend/`):

      ```dockerfile
      FROM node:18-alpine
      WORKDIR /usr/src/app
      COPY package*.json ./
      RUN npm install --production # Only install production dependencies
      COPY . .
      # Environment variable BACKEND_PORT can be set in docker-compose.yml
      # EXPOSE 3001 # Port backend listens on (set in server.js)
      CMD [ "node", "server.js" ]
      ```

3. **Configure Nginx Proxy for `frontend`:**

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
                  // Nginx will proxy this /api/data request to backend service
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
          listen 80; # Nginx listens on port 80 INSIDE frontend container
          server_name localhost;

          # Serve static files from /usr/share/nginx/html (where we COPY public/ into)
          location / {
              root   /usr/share/nginx/html;
              index  index.html index.htm;
              try_files $uri $uri/ /index.html; # Important for SPA if any
          }

          # Proxy requests /api/ to backend service
          location /api/ {
              # 'backend_service' must match backend service name in docker-compose.yml
              # '3001' is port backend API listens on INSIDE its container
              proxy_pass http://backend_service:3001/; # Trailing / is important

              # These headers help backend know original request info
              proxy_set_header Host $host; # Keep original Host header
              proxy_set_header X-Real-IP $remote_addr; # Client IP
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; # List of IPs if multiple proxies
              proxy_set_header X-Forwarded-Proto $scheme; # http or https

              # (Optional) Configure timeout
              # proxy_connect_timeout       60s;
              # proxy_send_timeout          60s;
              # proxy_read_timeout          60s;
          }

          # (Optional) Disable access log or error log to reduce noise in dev
          # access_log off;
          # error_log /dev/null;
      }
      ```

    - `frontend/Dockerfile`:

      ```dockerfile
      FROM nginx:1.25-alpine

      # Remove default Nginx config
      RUN rm /etc/nginx/conf.d/default.conf

      # Copy custom nginx.conf to Nginx config location
      COPY nginx.conf /etc/nginx/conf.d/default.conf

      # Copy entire public/ directory content (index.html, style.css)
      # into default Nginx web serving directory
      COPY ./public/ /usr/share/nginx/html/

      # EXPOSE 80 # Nginx image already does this
      # CMD ["nginx", "-g", "daemon off;"] # Nginx image already does this
      ```

4. **Write `docker-compose.yml` (in `my_fullstack_app/`):**

    ```yaml
    version: "3.8"

    services:
      frontend_service: # Service name for frontend
        build: ./frontend # Path to frontend Dockerfile dir
        container_name: my_frontend_nginx
        ports:
          - "${FRONTEND_PORT:-8080}:80" # Map port from .env (default 8080) to port 80 of frontend container
        volumes:
          # Mount public dir and nginx.conf for live reload in dev (optional)
          - ./frontend/public:/usr/share/nginx/html:ro # :ro for read-only, safer
          - ./frontend/nginx.conf:/etc/nginx/conf.d/default.conf:ro
        depends_on:
          - backend_service # Frontend depends on backend
        restart: unless-stopped

      backend_service: # Service name for backend (matches proxy_pass in nginx.conf)
        build: ./backend
        container_name: my_backend_api
        environment:
          # BACKEND_PORT: 3001 # This port set in server.js, can overwrite here
          NODE_ENV: development
        # ports: # No need to map backend port to host if only frontend calls internally
        #   - "3001:3001"
        volumes:
          - ./backend:/usr/src/app # Mount backend source code for live reload
          - /usr/src/app/node_modules # Prevent overwrite of node_modules from host
        restart: unless-stopped
        # (Optional) Add healthcheck for backend
        # healthcheck:
        #   test: ["CMD", "curl", "-f", "http://localhost:3001/data"] # Or simple /health endpoint
        #   interval: 30s
        #   timeout: 10s
        #   retries: 3
    # (Optional) Define network if want custom
    # networks:
    #   app_network:
    #     driver: bridge
    ```

    - Create `.env` file (in `my_fullstack_app/`) (optional):

      ```env
      FRONTEND_PORT=8080
      ```

5. **Run and Verify:**
    - From `my_fullstack_app` directory, run `docker-compose up --build`.
    - Open browser, access `http://localhost:8080` (or port set in `.env`).
    - Click "Fetch Data from Backend" button. Data from backend API (via Nginx proxy) should display.
    - Check logs of services: `docker-compose logs frontend_service`, `docker-compose logs backend_service`.
    - Try changing code in `backend/server.js` or `frontend/public/index.html`. If you mounted volumes and use `nodemon` for backend (or browser auto-refresh for frontend), you'll see changes without rebuild (backend restart might be needed if nodemon not used).
6. **Cleanup:** `docker-compose down`

Good luck with this exercise! It helps you understand better how services interact with each other in Docker Compose.

## 9. 📚 References & Next Steps

- **Docker Official Documentation:** [https://docs.docker.com/](https://docs.docker.com/) (Most comprehensive resource)
- **Docker Compose CLI Reference:** [https://docs.docker.com/compose/reference/](https://docs.docker.com/compose/reference/)
- **Compose File Reference:** [https://docs.docker.com/compose/compose-file/](https://docs.docker.com/compose/compose-file/compose-file-v3/)
- **Best practices for writing Dockerfiles:** [https://docs.docker.com/develop/develop-images/dockerfile_best-practices/](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- **Docker Samples (GitHub):** [https://github.com/dockersamples](https://github.com/dockersamples) (Many real-world examples)
- **Awesome Docker (Curated list on GitHub):** [https://github.com/veggiemonk/awesome-docker](https://github.com/veggiemonk/awesome-docker)
- **Play with Docker (Online Docker playground):** [https://labs.play-with-docker.com/](https://labs.play-with-docker.com/) (Practice Docker without installation)
- **Bret Fisher's Docker and Kubernetes Resources:** [https://www.bretfisher.com/](https://www.bretfisher.com/) (Many courses and good tips)

**Next Steps (After mastering these concepts):**

- **Multi-stage builds in Dockerfile:** Deep dive to optimize production image.
- **Advanced secrets and configurations management:** Research Docker secrets, Docker configs, or tools like HashiCorp Vault.
- **Docker Swarm:** Learn about Docker's built-in container orchestration tool, simpler than Kubernetes for small/medium apps.
- **Kubernetes (K8s):** "King" of container orchestration, powerful but more complex. Essential for large systems, requiring high availability and strong scaling capabilities.
- **Integrate Docker into CI/CD pipelines:** Automate build, test, and deploy process for Dockerized apps (e.g., with Jenkins, GitLab CI, GitHub Actions).
- **Explore private registries in depth:** AWS ECR, Google Artifact Registry (old GCR), Azure CR, Harbor (self-hosted).
- **Docker Security:** Learn best practices to secure Docker images and containers (vulnerability scanning, image signing, runtime security).
- **Service Mesh (Istio, Linkerd):** For complex microservices apps, managing traffic, observability, security between services.
- **Infrastructure as Code (Terraform, Pulumi):** Combine Docker with IaC tools to manage entire infrastructure.
