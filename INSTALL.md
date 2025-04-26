# Cài đặt môi trường học tập

- Tài liệu này hướng dẫn cài đặt môi trường phát triển cho các hệ điều hành phổ biến để sử dụng trong lộ trình học tập của bạn.
- Các công cụ được cài đặt bao gồm:
  - Java
  - MySQL
  - PHP
  - Node.js
  - Git
  - Docker
  - VSCode (Visual Studio Code)
- Các hệ điều hành được hỗ trợ:
  - Windows (sử dụng WSL)
  - Linux (Ubuntu, Debian, Arch Linux)
  - MacOS
- Nếu bạn gặp khó khăn trong quá trình cài đặt, hãy tham khảo tài liệu chính thức, tìm kiếm trên Google để tìm giải pháp hoặc liên hệ với tôi để được hỗ trợ.
- **Lưu ý**:
  - Công nghệ thay đổi rất nhanh, vì vậy hãy kiểm tra tài liệu chính thức của từng công cụ để biết thông tin mới nhất.
  - Tài liệu này chỉ mang tính chất tham khảo và có thể không đầy đủ cho tất cả các trường hợp. Bạn nên tìm hiểu thêm về từng công cụ và cách sử dụng chúng.

## 📋 Mục lục

- [Cài đặt môi trường học tập](#cài-đặt-môi-trường-học-tập)
  - [📋 Mục lục](#-mục-lục)
  - [🪟 Windows (sử dụng WSL)](#-windows-sử-dụng-wsl)
    - [1. Cài đặt WSL (Windows Subsystem for Linux)](#1-cài-đặt-wsl-windows-subsystem-for-linux)
    - [2. Cài đặt công cụ phát triển trong WSL](#2-cài-đặt-công-cụ-phát-triển-trong-wsl)
      - [Cập nhật hệ thống](#cập-nhật-hệ-thống)
      - [Cài đặt Java](#cài-đặt-java)
      - [Cài đặt MySQL](#cài-đặt-mysql)
      - [Cài đặt PHP và phpMyAdmin](#cài-đặt-php-và-phpmyadmin)
      - [Cài đặt Node.js và npm](#cài-đặt-nodejs-và-npm)
      - [Cài đặt Git](#cài-đặt-git)
      - [Cài đặt Docker](#cài-đặt-docker)
    - [3. Cài đặt VSCode trên Windows](#3-cài-đặt-vscode-trên-windows)
      - [Cài đặt VSCode](#cài-đặt-vscode)
  - [🐧 Linux](#-linux)
    - [Ubuntu/Debian](#ubuntudebian)
      - [Cập nhật hệ thống](#cập-nhật-hệ-thống-1)
      - [Cài đặt Java](#cài-đặt-java-1)
      - [Cài đặt MySQL](#cài-đặt-mysql-1)
      - [Cài đặt PHP và phpMyAdmin](#cài-đặt-php-và-phpmyadmin-1)
      - [Cài đặt Node.js và npm](#cài-đặt-nodejs-và-npm-1)
      - [Cài đặt Git](#cài-đặt-git-1)
      - [Cài đặt Docker](#cài-đặt-docker-1)
    - [Arch Linux](#arch-linux)
      - [Cập nhật hệ thống](#cập-nhật-hệ-thống-2)
      - [Cài đặt Java](#cài-đặt-java-2)
      - [Cài đặt MySQL (MariaDB)](#cài-đặt-mysql-mariadb)
      - [Cài đặt PHP và phpMyAdmin](#cài-đặt-php-và-phpmyadmin-2)
      - [Cài đặt Node.js và npm](#cài-đặt-nodejs-và-npm-2)
      - [Cài đặt Git](#cài-đặt-git-2)
      - [Cài đặt Docker](#cài-đặt-docker-2)
  - [🍎 MacOS](#-macos)
    - [1. Cài đặt Homebrew](#1-cài-đặt-homebrew)
    - [2. Cài đặt các công cụ phát triển](#2-cài-đặt-các-công-cụ-phát-triển)
      - [Cài đặt Java](#cài-đặt-java-3)
      - [Cài đặt MySQL](#cài-đặt-mysql-2)
      - [Cài đặt PHP và phpMyAdmin](#cài-đặt-php-và-phpmyadmin-3)
      - [Cài đặt Node.js và npm](#cài-đặt-nodejs-và-npm-3)
      - [Cài đặt Git](#cài-đặt-git-3)
      - [Cài đặt Docker](#cài-đặt-docker-3)
  - [💻 Cài đặt và cấu hình VSCode](#-cài-đặt-và-cấu-hình-vscode)
    - [Cài đặt VSCode](#cài-đặt-vscode-1)
    - [Cài đặt các extension cần thiết](#cài-đặt-các-extension-cần-thiết)
    - [Cấu hình cơ bản VSCode](#cấu-hình-cơ-bản-vscode)

## 🪟 Windows (sử dụng WSL)

### 1. Cài đặt WSL (Windows Subsystem for Linux)

1. Mở PowerShell với quyền Administrator
2. Chạy lệnh sau để cài đặt WSL và Ubuntu:

   ```powershell
   wsl --install
   ```

3. Khởi động lại máy tính
4. Ubuntu sẽ tự động cài đặt, bạn cần tạo username và password

### 2. Cài đặt công cụ phát triển trong WSL

Mở terminal Ubuntu và thực hiện các bước sau:

#### Cập nhật hệ thống

```bash
sudo apt update && sudo apt upgrade -y
```

#### Cài đặt Java

```bash
sudo apt install -y openjdk-17-jdk
```

Kiểm tra cài đặt:

```bash
java --version
```

#### Cài đặt MySQL

```bash
sudo apt install -y mysql-server
sudo systemctl start mysql
sudo systemctl enable mysql
```

Thiết lập bảo mật cho MySQL:

```bash
sudo mysql_secure_installation
```

#### Cài đặt PHP và phpMyAdmin

```bash
sudo apt install -y php php-mysqli php-mbstring
sudo apt install -y phpmyadmin
```

Trong quá trình cài đặt phpMyAdmin, chọn "apache2" và thiết lập mật khẩu.

#### Cài đặt Node.js và npm

```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
```

Kiểm tra cài đặt:

```bash
node -v
npm -v
```

#### Cài đặt Git

```bash
sudo apt install -y git
```

Cấu hình Git:

```bash
git config --global user.name "Tên Của Bạn"
git config --global user.email "email@example.com"
```

Kiểm tra cài đặt:

```bash
git --version
```

#### Cài đặt Docker

```bash
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```

Kiểm tra cài đặt:

```bash
docker --version
```

### 3. Cài đặt VSCode trên Windows

#### Cài đặt VSCode

1. Tải VSCode từ [trang chính thức](https://code.visualstudio.com/)
2. Cài đặt với tùy chọn mặc định
3. Cài đặt extension [Remote - WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) để sử dụng VSCode với WSL
4. Mở VSCode và nhấn `Ctrl + Shift + P`, sau đó gõ `Remote-WSL: New Window`để mở một cửa sổ mới trong WSL

## 🐧 Linux

### Ubuntu/Debian

#### Cập nhật hệ thống

```bash
sudo apt update && sudo apt upgrade -y
```

#### Cài đặt Java

```bash
sudo apt install -y openjdk-17-jdk
```

#### Cài đặt MySQL

```bash
sudo apt install -y mysql-server
sudo systemctl start mysql
sudo systemctl enable mysql
sudo mysql_secure_installation
```

#### Cài đặt PHP và phpMyAdmin

```bash
sudo apt install -y php php-mysqli php-mbstring
sudo apt install -y apache2 phpmyadmin
```

Trong quá trình cài đặt phpMyAdmin, chọn "apache2" và thiết lập mật khẩu.

#### Cài đặt Node.js và npm

```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
```

#### Cài đặt Git

```bash
sudo apt install -y git
```

#### Cài đặt Docker

```bash
# Cài đặt các gói phụ thuộc
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg

# Thêm GPG key Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Thêm Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Cập nhật package index
sudo apt update

# Cài đặt Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Cài đặt Docker Compose
sudo apt install -y docker-compose

# Thêm user vào nhóm docker để không cần sudo
sudo usermod -aG docker $USER

# Khởi động và bật dịch vụ Docker
sudo systemctl start docker
sudo systemctl enable docker
```

Kiểm tra cài đặt:

```bash
docker --version
docker-compose --version
```

Để áp dụng quyền nhóm docker mà không cần đăng xuất, chạy:

```bash
newgrp docker
```

### Arch Linux

#### Cập nhật hệ thống

```bash
sudo pacman -Syu
```

#### Cài đặt Java

```bash
sudo pacman -S jdk-openjdk
```

#### Cài đặt MySQL (MariaDB)

```bash
sudo pacman -S mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation
```

#### Cài đặt PHP và phpMyAdmin

```bash
sudo pacman -S php php-apache phpmyadmin apache
```

Cấu hình Apache để hỗ trợ PHP và phpMyAdmin:

1. Chỉnh sửa `/etc/httpd/conf/httpd.conf`
2. Thêm dòng `Include conf/extra/php_module.conf`
3. Khởi động lại Apache: `sudo systemctl restart httpd`

#### Cài đặt Node.js và npm

```bash
sudo pacman -S nodejs npm
```

#### Cài đặt Git

```bash
sudo pacman -S git
```

Cấu hình Git:

```bash
git config --global user.name "Tên Của Bạn"
git config --global user.email "email@example.com"
```

Kiểm tra cài đặt:

```bash
git --version
```

#### Cài đặt Docker

```bash
# Cài đặt Docker và Docker Compose
sudo pacman -S docker docker-compose

# Khởi động và bật dịch vụ Docker
sudo systemctl start docker
sudo systemctl enable docker

# Thêm user vào nhóm docker để không cần sudo
sudo usermod -aG docker $USER
```

Kiểm tra cài đặt:

```bash
docker --version
docker-compose --version
```

Để áp dụng quyền nhóm docker mà không cần đăng xuất, chạy:

```bash
newgrp docker
```

## 🍎 MacOS

### 1. Cài đặt Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Cài đặt các công cụ phát triển

#### Cài đặt Java

```bash
brew install openjdk@17
```

Thêm Java vào biến môi trường:

```bash
echo 'export PATH="/usr/local/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

#### Cài đặt MySQL

```bash
brew install mysql
brew services start mysql
mysql_secure_installation
```

#### Cài đặt PHP và phpMyAdmin

```bash
brew install php
brew install composer
mkdir -p ~/Sites
cd ~/Sites
composer create-project phpmyadmin/phpmyadmin
```

#### Cài đặt Node.js và npm

```bash
brew install node
```

#### Cài đặt Git

```bash
brew install git
```

Cấu hình Git:

```bash
git config --global user.name "Tên Của Bạn"
git config --global user.email "email@example.com"
```

Kiểm tra cài đặt:

```bash
git --version
```

#### Cài đặt Docker

```bash
# Cài đặt Docker Desktop cho macOS
brew install --cask docker

# Khởi động Docker Desktop
open /Applications/Docker.app
```

Kiểm tra cài đặt:

```bash
docker --version
docker-compose --version
```

## 💻 Cài đặt và cấu hình VSCode

### Cài đặt VSCode

- **Windows**: Tải và cài đặt từ [trang chính thức](https://code.visualstudio.com/)
- **Linux**:

  - Ubuntu/Debian:

    ```bash
    sudo apt install -y software-properties-common apt-transport-https
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install -y code
    ```

  - Arch Linux:

    ```bash
    sudo pacman -S code
    ```

- **MacOS**:

  ```bash
  brew install --cask visual-studio-code
  ```

### Cài đặt các extension cần thiết

Mở VSCode và cài đặt các extension sau thông qua Marketplace hoặc tìm kiếm trong phần Extensions (Ctrl+Shift+X):

1. **Java Development**:

   - [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)

2. **Web Development**:

   - [HTML CSS Support](https://marketplace.visualstudio.com/items?itemName=ecmel.vscode-html-css)
   - [CSS IntelliSense](https://marketplace.visualstudio.com/items?itemName=Zignd.html-css-class-completion)
   - [JavaScript (ES6) code snippets](https://marketplace.visualstudio.com/items?itemName=xabikos.JavaScriptSnippets)
   - [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
   - [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
   - [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)

3. **PHP Development**:

   - [PHP Intelephense](https://marketplace.visualstudio.com/items?itemName=bmewburn.vscode-intelephense-client)
   - [PHP Namespace Resolver](https://marketplace.visualstudio.com/items?itemName=MehediDracula.php-namespace-resolver)
   - [PHP DocBlocker](https://marketplace.visualstudio.com/items?itemName=neilbrayfield.php-docblocker)
   - [PHP Debug](https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug)

4. **Database**:

   - [MySQL](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-mysql-client2)

5. **Docker**:

   - [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)

6. **Tiện ích chung**:

   - [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
   - [Remote - WSL (cho Windows)](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)
   - [Auto Rename Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-rename-tag)
   - [Auto Close Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-close-tag)
   - [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense)
   - [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)
   - [Error Lens](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens)

7. **Theme**: (tùy chọn theo sở thích cá nhân giúp làm đẹp giao diện VSCode)

   - [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme)
   - [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
   - [One Dark Pro](https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme)

### Cấu hình cơ bản VSCode

Mở Settings (Ctrl+,) và thêm các cấu hình sau:

```json
{
  "files.autoSave": "afterDelay",
  "editor.formatOnSave": true,
  "editor.minimap.enabled": true,
  "editor.wordWrap": "on",
  "editor.tabSize": 2,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
```

---

[⬅️ Trở lại: SELF-LEARNING/Part4.md](../SELF-LEARNING/Part4.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: GIT.md](./GIT.md)
