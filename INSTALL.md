---
prev:
  text: '🌐 Tổng Quan Lập Trình'
  link: '/INTRODUCTION'
next:
  text: '🔄 Git & GitHub'
  link: '/GIT'
---

# 🛠️ Cài đặt môi trường học tập

Tài liệu này hướng dẫn chi tiết cài đặt môi trường phát triển hoàn chỉnh cho toàn bộ lộ trình học tập từ Module 1 đến Module 8.

## 📚 Công cụ theo từng Module

### Module 1: Kỹ Năng Tự Học

- 🌐 **Web Browser** (Chrome/Firefox/Edge)
- 📝 **Note-taking tools** (Notion, Obsidian, hoặc Markdown editor)
- 🔍 **Search engines** (Google, Stack Overflow, GitHub)

### Module 2-3: Java & OOP

- ☕ **Java Development Kit (JDK 17+)**
- 🏗️ **IDE**: IntelliJ IDEA Community / Eclipse / VSCode
- 📦 **Build tools**: Maven / Gradle (optional)
- 🧪 **JUnit** (testing framework)

### Module 4: SQL & Database

- 💾 **MySQL Server** (hoặc MariaDB)
- 🔧 **MySQL Workbench** / phpMyAdmin
- 📊 **Database clients**: DBeaver / TablePlus (optional)

### Module 5: DSA (Data Structures & Algorithms)

- Sử dụng môi trường Java đã cài (Module 2)
- 📈 **Visualization tools** (optional): Algorithm Visualizer

### Module 6: Web Frontend

- 📝 **HTML/CSS/JavaScript** (built-in browser support)
- 🌐 **Modern browsers** với DevTools
- 🔧 **VSCode** với extensions cho Web
- 🎨 **Live Server extension**

### Module 7: Backend (PHP)

- 🐘 **PHP 8.0+**
- 🌐 **Web server**: Apache / Nginx
- 🗄️ **MySQL** (đã cài ở Module 4)
- 📦 **Composer** (PHP package manager)
- 🔧 **Postman** / **Thunder Client** (API testing)

### Module 8: DevOps

- 🐳 **Docker Desktop**
- ☸️ **Kubernetes** (k3s/minikube cho local)
- 🔄 **Docker Compose**
- 📊 **Portainer** (optional - Docker GUI)

## 🖥️ Hệ điều hành được hỗ trợ

- 🪟 **Windows 10/11** (khuyến nghị sử dụng WSL2)
- 🐧 **Linux** (Ubuntu 20.04+, Debian, Arch Linux)
- 🍎 **MacOS** (Big Sur và mới hơn)

## ⚠️ Lưu ý quan trọng

- ✅ Công nghệ thay đổi nhanh, luôn kiểm tra phiên bản mới nhất
- ✅ Tham khảo tài liệu chính thức khi gặp vấn đề
- ✅ Một số công cụ có thể cài đặt sau khi bắt đầu module tương ứng
- ✅ Ưu tiên cài đặt các công cụ cơ bản trước: Git, VSCode, JDK, MySQL

## 🚀 Hướng dẫn cài đặt nhanh

**Khuyến nghị thứ tự cài đặt:**

1. 🔧 **Công cụ cơ bản**: Git, VSCode
2. ☕ **Java JDK** (Module 2-3-5)
3. 💾 **MySQL** (Module 4)
4. 🐘 **PHP + Composer** (Module 7)
5. 🐳 **Docker** (Module 8)

## 🪟 Windows (WSL2 - Khuyến nghị)

### Windows - Bước 1: Cài đặt WSL2

**Yêu cầu**: Windows 10 (version 2004+) hoặc Windows 11

1. Mở **PowerShell** với quyền Administrator
2. Cài đặt WSL2 và Ubuntu:

   ```powershell
   wsl --install
   ```

3. Khởi động lại máy tính
4. Mở Ubuntu từ Start Menu, tạo username và password

**Kiểm tra phiên bản:**

```powershell
wsl --list --verbose
```

### Windows - Bước 2: Cài đặt công cụ cơ bản

Mở terminal Ubuntu trong WSL:

```bash
# Cập nhật hệ thống
sudo apt update && sudo apt upgrade -y

# Cài đặt Git
sudo apt install -y git

# Cấu hình Git
git config --global user.name "Tên của bạn"
git config --global user.email "email@example.com"

# Cài đặt build essentials
sudo apt install -y build-essential curl wget
```

### Windows - Bước 3: Cài đặt Java (Module 2)

```bash
# Cài đặt JDK 17
sudo apt install -y openjdk-17-jdk

# Kiểm tra cài đặt
java --version
javac --version
```

**Cài đặt Maven (optional cho project lớn):**

```bash
sudo apt install -y maven
mvn --version
```

### Windows - Bước 4: Cài đặt MySQL (Module 4)

```bash
# Cài đặt MySQL Server
sudo apt install -y mysql-server

# Khởi động MySQL
sudo service mysql start

# Thiết lập bảo mật
sudo mysql_secure_installation
```

**Tạo user để truy cập:**

```bash
sudo mysql

# Trong MySQL shell:
CREATE USER 'your_username'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON *.* TO 'your_username'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

**Cài đặt MySQL Workbench trên Windows:**

- Tải từ [MySQL Downloads](https://dev.mysql.com/downloads/workbench/)
- Kết nối tới `localhost:3306`

### Windows - Bước 5: Cài đặt PHP (Module 7)

```bash
# Cài đặt PHP 8.x và các extensions cần thiết
sudo apt install -y php php-cli php-fpm php-mysql php-mbstring php-xml php-curl php-zip php-gd

# Kiểm tra phiên bản
php --version

# Cài đặt Composer (PHP package manager)
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Kiểm tra Composer
composer --version
```

**Cài đặt Apache (optional cho web development):**

```bash
sudo apt install -y apache2 libapache2-mod-php
sudo service apache2 start
```

### Windows - Bước 6: Cài đặt Docker (Module 8)

**Khuyến nghị**: Cài Docker Desktop trên Windows thay vì trong WSL.

1. Tải [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/)
2. Cài đặt và enable WSL2 integration
3. Khởi động Docker Desktop

**Kiểm tra trong WSL:**

```bash
docker --version
docker compose version
```

**Test Docker:**

```bash
docker run hello-world
```

### Windows - Bước 7: Cài đặt VSCode

1. Tải VSCode từ [code.visualstudio.com](https://code.visualstudio.com/)
2. Cài đặt extension **Remote - WSL**
3. Mở VSCode và kết nối WSL: `Ctrl + Shift + P` → `WSL: Connect to WSL`

## 🐧 Linux (Ubuntu/Debian)

### Ubuntu - Bước 1: Cài đặt công cụ cơ bản

```bash
# Cập nhật hệ thống
sudo apt update && sudo apt upgrade -y

# Cài đặt Git và build tools
sudo apt install -y git build-essential curl wget

# Cấu hình Git
git config --global user.name "Tên của bạn"
git config --global user.email "email@example.com"
```

### Ubuntu - Bước 2: Cài đặt Java (Module 2)

```bash
# Cài đặt JDK 17
sudo apt install -y openjdk-17-jdk

# Kiểm tra
java --version
```

### Ubuntu - Bước 3: Cài đặt MySQL (Module 4)

```bash
# Cài đặt MySQL
sudo apt install -y mysql-server

# Khởi động và enable
sudo systemctl start mysql
sudo systemctl enable mysql

# Bảo mật
sudo mysql_secure_installation
```

### Ubuntu - Bước 4: Cài đặt PHP (Module 7)

```bash
# Cài đặt PHP và extensions
sudo apt install -y php php-cli php-fpm php-mysql php-mbstring php-xml php-curl

# Cài đặt Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

### Ubuntu - Bước 5: Cài đặt Docker (Module 8)

```bash
# Cài đặt Docker
curl -fsSL https://get.docker.com | sh

# Thêm user vào docker group
sudo usermod -aG docker $USER

# Khởi động Docker
sudo systemctl start docker
sudo systemctl enable docker

# Cài đặt Docker Compose
sudo apt install -y docker-compose-plugin
```

### Ubuntu - Bước 6: Cài đặt VSCode

```bash
# Thêm Microsoft repository
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

# Cài đặt
sudo apt update
sudo apt install -y code
```

## 🐧 Linux (Arch Linux)

### Arch - Bước 1: Cài đặt công cụ cơ bản

```bash
# Cập nhật hệ thống
sudo pacman -Syu

# Cài đặt Git và base-devel
sudo pacman -S git base-devel

# Cấu hình Git
git config --global user.name "Tên của bạn"
git config --global user.email "email@example.com"
```

### Arch - Bước 2: Cài đặt Java (Module 2)

```bash
# Cài đặt JDK
sudo pacman -S jdk-openjdk

# Kiểm tra
java --version
```

### Arch - Bước 3: Cài đặt MySQL (Module 4)

```bash
# Cài đặt MariaDB (thay thế MySQL)
sudo pacman -S mariadb

# Khởi tạo database
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Khởi động
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Bảo mật
sudo mysql_secure_installation
```

### Arch - Bước 4: Cài đặt PHP (Module 7)

```bash
# Cài đặt PHP
sudo pacman -S php php-apache

# Cài đặt Composer
sudo pacman -S composer
```

### Arch - Bước 5: Cài đặt Docker (Module 8)

```bash
# Cài đặt Docker
sudo pacman -S docker docker-compose

# Khởi động
sudo systemctl start docker
sudo systemctl enable docker

# Thêm user vào docker group
sudo usermod -aG docker $USER
```

### Arch - Bước 6: Cài đặt VSCode

```bash
# Cài đặt từ AUR hoặc official repo
sudo pacman -S code

# Hoặc từ AUR (visual-studio-code-bin)
yay -S visual-studio-code-bin
```

## 🍎 MacOS

### MacOS - Bước 1: Cài đặt Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### MacOS - Bước 2: Cài đặt công cụ cơ bản

```bash
# Cài đặt Git
brew install git

# Cấu hình Git
git config --global user.name "Tên của bạn"
git config --global user.email "email@example.com"
```

### MacOS - Bước 3: Cài đặt Java (Module 2)

```bash
# Cài đặt JDK
brew install openjdk@17

# Thêm vào PATH
echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Kiểm tra
java --version
```

### MacOS - Bước 4: Cài đặt MySQL (Module 4)

```bash
# Cài đặt MySQL
brew install mysql

# Khởi động
brew services start mysql

# Bảo mật
mysql_secure_installation
```

### MacOS - Bước 5: Cài đặt PHP (Module 7)

```bash
# Cài đặt PHP
brew install php

# Cài đặt Composer
brew install composer

# Kiểm tra
php --version
composer --version
```

### MacOS - Bước 6: Cài đặt Docker (Module 8)

```bash
# Cài đặt Docker Desktop
brew install --cask docker

# Mở Docker Desktop
open /Applications/Docker.app
```

### MacOS - Bước 7: Cài đặt VSCode

```bash
# Cài đặt VSCode
brew install --cask visual-studio-code
```

## 💻 Cấu hình VSCode

### Extensions theo Module

**Module 1 (Self Learning):**

- [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
- [Markdown Preview Enhanced](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced)

**Module 2-3-5 (Java, OOP, DSA):**

- [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)
- [Java Test Runner](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-test)
- [Maven for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-maven)

**Module 4 (SQL):**

- [MySQL](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-mysql-client2)
- [SQLTools](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools)

**Module 6 (Web Frontend):**

- [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
- [HTML CSS Support](https://marketplace.visualstudio.com/items?itemName=ecmel.vscode-html-css)
- [JavaScript (ES6) snippets](https://marketplace.visualstudio.com/items?itemName=xabikos.JavaScriptSnippets)
- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [Auto Rename Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-rename-tag)
- [Auto Close Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-close-tag)

**Module 7 (PHP):**

- [PHP Intelephense](https://marketplace.visualstudio.com/items?itemName=bmewburn.vscode-intelephense-client)
- [PHP Debug](https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug)
- [PHP DocBlocker](https://marketplace.visualstudio.com/items?itemName=neilbrayfield.php-docblocker)

**Module 8 (DevOps):**

- [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
- [Kubernetes](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)
- [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)

**Tiện ích chung:**

- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense)
- [Error Lens](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens)
- [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)
- [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)

### Cấu hình Settings

Mở Settings (`Ctrl/Cmd + ,`) hoặc chỉnh sửa `settings.json`:

```json
{
  // Editor
  "editor.fontSize": 14,
  "editor.fontFamily": "'JetBrains Mono', 'Fira Code', Consolas, monospace",
  "editor.fontLigatures": true,
  "editor.tabSize": 2,
  "editor.wordWrap": "on",
  "editor.formatOnSave": true,
  "editor.minimap.enabled": true,
  "editor.bracketPairColorization.enabled": true,
  
  // Files
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000,
  "files.exclude": {
    "**/.git": true,
    "**/.DS_Store": true,
    "**/node_modules": true,
    "**/.class": true
  },
  
  // Terminal
  "terminal.integrated.fontSize": 13,
  "terminal.integrated.fontFamily": "monospace",
  
  // Java
  "java.configuration.runtimes": [
    {
      "name": "JavaSE-17",
      "path": "/usr/lib/jvm/java-17-openjdk-amd64"
    }
  ],
  
  // PHP
  "php.validate.executablePath": "/usr/bin/php",
  
  // Code Actions
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.organizeImports": true
  },
  
  // Prettier
  "prettier.semi": true,
  "prettier.singleQuote": true,
  "prettier.tabWidth": 2
}
```

## 🔧 Công cụ bổ sung (Optional)

> ⚠️ **Lưu ý quan trọng:**
>
> - Các công cụ dưới đây là **tùy chọn**, không bắt buộc phải cài đặt
> - **Chỉ nên chọn một công cụ** trong mỗi danh mục phù hợp với nhu cầu
> - **Tìm hiểu kỹ** về công cụ trước khi cài đặt (đọc documentation, xem reviews)
> - Cài đặt **từng công cụ một** và test thử trước khi cài công cụ khác
> - Không cài đặt tất cả cùng lúc để tránh xung đột và tốn tài nguyên

### Công cụ Database GUI

**Chọn một trong các công cụ sau:**

- **MySQL Workbench**: [Download](https://dev.mysql.com/downloads/workbench/) - Chính thức từ MySQL, phù hợp cho MySQL
- **DBeaver**: [Download](https://dbeaver.io/download/) - Hỗ trợ nhiều loại database, mã nguồn mở
- **TablePlus**: [Download](https://tableplus.com/) - Giao diện đẹp, nhẹ (có phí cho bản full)

### API Testing

**Chọn một trong các công cụ sau:**

- **Postman**: [Download](https://www.postman.com/downloads/) - Phổ biến nhất, nhiều tính năng
- **Insomnia**: [Download](https://insomnia.rest/download) - Nhẹ hơn, interface đơn giản
- **Thunder Client** (VSCode Extension) - Tích hợp trong VSCode, tiện lợi

### Container Management

- **Portainer**: `docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer-ce`
  - Giao diện web quản lý Docker, phù hợp cho người mới

### Java IDEs (Alternatives)

**Chọn một trong các IDE sau (nếu không dùng VSCode):**

- **IntelliJ IDEA Community**: [Download](https://www.jetbrains.com/idea/download/) - Mạnh nhất cho Java
- **Eclipse**: [Download](https://www.eclipse.org/downloads/) - Mã nguồn mở, nhẹ hơn

### Terminal Emulators

**Chọn theo hệ điều hành:**

- **Windows Terminal** (Windows) - Đã có sẵn trên Windows 11
- **iTerm2** (MacOS) - Tốt nhất cho MacOS
- **Terminator / Alacritty** (Linux) - Nhẹ, nhanh

## ✅ Kiểm tra cài đặt

Chạy script sau để kiểm tra tất cả công cụ:

```bash
#!/bin/bash

echo "🔍 Kiểm tra môi trường..."
echo ""

# Git
echo -n "✓ Git: "
git --version

# Java
echo -n "✓ Java: "
java --version 2>&1 | head -n 1

# MySQL
echo -n "✓ MySQL: "
mysql --version

# PHP
echo -n "✓ PHP: "
php --version | head -n 1

# Composer
echo -n "✓ Composer: "
composer --version | head -n 1

# Docker
echo -n "✓ Docker: "
docker --version

# Docker Compose
echo -n "✓ Docker Compose: "
docker compose version

echo ""
echo "✅ Hoàn thành kiểm tra!"
```

**Lưu script** vào file `check-env.sh`, phân quyền và chạy:

```bash
chmod +x check-env.sh
./check-env.sh
```

**🎉 Chúc bạn học tập hiệu quả!**

Nếu gặp vấn đề, hãy:

1. 🔍 Tìm kiếm lỗi trên Google/Stack Overflow
2. 📚 Đọc tài liệu chính thức của công cụ
3. 💬 Hỏi trong community (GitHub Issues, Discord, Reddit)
4. 📧 Liên hệ với người hướng dẫn
