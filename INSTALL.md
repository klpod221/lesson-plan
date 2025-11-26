---
prev:
  text: '🌐 Programming Overview'
  link: '/INTRODUCTION'
next:
  text: '🔄 Git & GitHub'
  link: '/GIT'
---

# 🛠️ Learning Environment Setup

This document provides detailed instructions for setting up a complete development environment for the entire learning journey from Module 1 to Module 8.

## 📚 Tools by Module

### Module 1: Self-Learning Skills

- 🌐 **Web Browser** (Chrome/Firefox/Edge)
- 📝 **Note-taking tools** (Notion, Obsidian, or Markdown editor)
- 🔍 **Search engines** (Google, Stack Overflow, GitHub)

### Module 2-3: Java & OOP

- ☕ **Java Development Kit (JDK 17+)**
- 🏗️ **IDE**: IntelliJ IDEA Community / Eclipse / VSCode
- 📦 **Build tools**: Maven / Gradle (optional)
- 🧪 **JUnit** (testing framework)

### Module 4: SQL & Database

- 💾 **MySQL Server** (or MariaDB)
- 🔧 **MySQL Workbench** / phpMyAdmin
- 📊 **Database clients**: DBeaver / TablePlus (optional)

### Module 5: DSA (Data Structures & Algorithms)

- Use Java environment already installed (Module 2)
- 📈 **Visualization tools** (optional): Algorithm Visualizer

### Module 6: Web Frontend

- 📝 **HTML/CSS/JavaScript** (built-in browser support)
- 🌐 **Modern browsers** with DevTools
- 🔧 **VSCode** with extensions for Web
- 🎨 **Live Server extension**

### Module 7: Backend (PHP)

- 🐘 **PHP 8.0+**
- 🌐 **Web server**: Apache / Nginx
- 🗄️ **MySQL** (already installed in Module 4)
- 📦 **Composer** (PHP package manager)
- 🔧 **Postman** / **Thunder Client** (API testing)

### Module 8: DevOps

- 🐳 **Docker Desktop**
- ☸️ **Kubernetes** (k3s/minikube for local)
- 🔄 **Docker Compose**
- 📊 **Portainer** (optional - Docker GUI)

## 🖥️ Supported Operating Systems

- 🪟 **Windows 10/11** (recommended using WSL2)
- 🐧 **Linux** (Ubuntu 20.04+, Debian, Arch Linux)
- 🍎 **MacOS** (Big Sur and newer)

## ⚠️ Important Notes

- ✅ Technology changes rapidly, always check for latest versions
- ✅ Refer to official documentation when encountering problems
- ✅ Some tools can be installed after starting the corresponding module
- ✅ Prioritize installing basic tools first: Git, VSCode, JDK, MySQL

## 🚀 Quick Installation Guide

**Recommended installation order:**

1. 🔧 **Basic tools**: Git, VSCode
2. ☕ **Java JDK** (Module 2-3-5)
3. 💾 **MySQL** (Module 4)
4. 🐘 **PHP + Composer** (Module 7)
5. 🐳 **Docker** (Module 8)

## 🪟 Windows (WSL2 - Recommended)

### Windows - Step 1: Install WSL2

**Requirements**: Windows 10 (version 2004+) or Windows 11

1. Open **PowerShell** with Administrator privileges
2. Install WSL2 and Ubuntu:

   ```powershell
   wsl --install
   ```

3. Restart computer
4. Open Ubuntu from Start Menu, create username and password

**Check version:**

```powershell
wsl --list --verbose
```

### Windows - Step 2: Install Basic Tools

Open Ubuntu terminal in WSL:

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Git
sudo apt install -y git

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "email@example.com"

# Install build essentials
sudo apt install -y build-essential curl wget
```

### Windows - Step 3: Install Java (Module 2)

```bash
# Install JDK 17
sudo apt install -y openjdk-17-jdk

# Check installation
java --version
javac --version
```

**Install Maven (optional for large projects):**

```bash
sudo apt install -y maven
mvn --version
```

### Windows - Step 4: Install MySQL (Module 4)

```bash
# Install MySQL Server
sudo apt install -y mysql-server

# Start MySQL
sudo service mysql start

# Setup security
sudo mysql_secure_installation
```

**Create user for access:**

```bash
sudo mysql

# In MySQL shell:
CREATE USER 'your_username'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON *.* TO 'your_username'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

**Install MySQL Workbench on Windows:**

- Download from [MySQL Downloads](https://dev.mysql.com/downloads/workbench/)
- Connect to `localhost:3306`

### Windows - Step 5: Install PHP (Module 7)

```bash
# Install PHP 8.x and necessary extensions
sudo apt install -y php php-cli php-fpm php-mysql php-mbstring php-xml php-curl php-zip php-gd

# Check version
php --version

# Install Composer (PHP package manager)
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Check Composer
composer --version
```

**Install Apache (optional for web development):**

```bash
sudo apt install -y apache2 libapache2-mod-php
sudo service apache2 start
```

### Windows - Step 6: Install Docker (Module 8)

**Recommended**: Install Docker Desktop on Windows instead of in WSL.

1. Download [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/)
2. Install and enable WSL2 integration
3. Start Docker Desktop

**Check in WSL:**

```bash
docker --version
docker compose version
```

**Test Docker:**

```bash
docker run hello-world
```

### Windows - Step 7: Install VSCode

1. Download VSCode from [code.visualstudio.com](https://code.visualstudio.com/)
2. Install extension **Remote - WSL**
3. Open VSCode and connect WSL: `Ctrl + Shift + P` → `WSL: Connect to WSL`

## 🐧 Linux (Ubuntu/Debian)

### Ubuntu - Step 1: Install Basic Tools

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Git and build tools
sudo apt install -y git build-essential curl wget

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

### Ubuntu - Step 2: Install Java (Module 2)

```bash
# Install JDK 17
sudo apt install -y openjdk-17-jdk

# Check
java --version
```

### Ubuntu - Step 3: Install MySQL (Module 4)

```bash
# Install MySQL
sudo apt install -y mysql-server

# Start and enable
sudo systemctl start mysql
sudo systemctl enable mysql

# Security
sudo mysql_secure_installation
```

### Ubuntu - Step 4: Install PHP (Module 7)

```bash
# Install PHP and extensions
sudo apt install -y php php-cli php-fpm php-mysql php-mbstring php-xml php-curl

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

### Ubuntu - Step 5: Install Docker (Module 8)

```bash
# Install Docker
curl -fsSL https://get.docker.com | sh

# Add user to docker group
sudo usermod -aG docker $USER

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose
sudo apt install -y docker-compose-plugin
```

### Ubuntu - Step 6: Install VSCode

```bash
# Add Microsoft repository
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

# Install
sudo apt update
sudo apt install -y code
```

## 🐧 Linux (Arch Linux)

### Arch - Step 1: Install Basic Tools

```bash
# Update system
sudo pacman -Syu

# Install Git and base-devel
sudo pacman -S git base-devel

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

### Arch - Step 2: Install Java (Module 2)

```bash
# Install JDK
sudo pacman -S jdk-openjdk

# Check
java --version
```

### Arch - Step 3: Install MySQL (Module 4)

```bash
# Install MariaDB (MySQL replacement)
sudo pacman -S mariadb

# Initialize database
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Start
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Security
sudo mysql_secure_installation
```

### Arch - Step 4: Install PHP (Module 7)

```bash
# Install PHP
sudo pacman -S php php-apache

# Install Composer
sudo pacman -S composer
```

### Arch - Step 5: Install Docker (Module 8)

```bash
# Install Docker
sudo pacman -S docker docker-compose

# Start
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER
```

### Arch - Step 6: Install VSCode

```bash
# Install from AUR or official repo
sudo pacman -S code

# Or from AUR (visual-studio-code-bin)
yay -S visual-studio-code-bin
```

## 🍎 MacOS

### MacOS - Step 1: Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### MacOS - Step 2: Install Basic Tools

```bash
# Install Git
brew install git

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

### MacOS - Step 3: Install Java (Module 2)

```bash
# Install JDK
brew install openjdk@17

# Add to PATH
echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Check
java --version
```

### MacOS - Step 4: Install MySQL (Module 4)

```bash
# Install MySQL
brew install mysql

# Start
brew services start mysql

# Security
mysql_secure_installation
```

### MacOS - Step 5: Install PHP (Module 7)

```bash
# Install PHP
brew install php

# Install Composer
brew install composer

# Check
php --version
composer --version
```

### MacOS - Step 6: Install Docker (Module 8)

```bash
# Install Docker Desktop
brew install --cask docker

# Open Docker Desktop
open /Applications/Docker.app
```

### MacOS - Step 7: Install VSCode

```bash
# Install VSCode
brew install --cask visual-studio-code
```

## 💻 VSCode Configuration

### Extensions by Module

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

**General utilities:**

- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense)
- [Error Lens](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens)
- [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)
- [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)

### Settings Configuration

Open Settings (`Ctrl/Cmd + ,`) or edit `settings.json`:

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

## 🔧 Additional Tools (Optional)

> ⚠️ **Important Note:**
>
> - The tools below are **optional**, not required
> - **Only choose one tool** in each category suitable for your needs
> - **Study thoroughly** about the tool before installing (read documentation, watch reviews)
> - Install **one tool at a time** and test before installing another
> - Don't install everything at once to avoid conflicts and resource waste

### Database GUI Tools

**Choose one of the following tools:**

- **MySQL Workbench**: [Download](https://dev.mysql.com/downloads/workbench/) - Official from MySQL, suitable for MySQL
- **DBeaver**: [Download](https://dbeaver.io/download/) - Supports many database types, open source
- **TablePlus**: [Download](https://tableplus.com/) - Beautiful interface, lightweight (paid for full version)

### API Testing

**Choose one of the following tools:**

- **Postman**: [Download](https://www.postman.com/downloads/) - Most popular, many features
- **Insomnia**: [Download](https://insomnia.rest/download) - Lighter, simple interface
- **Thunder Client** (VSCode Extension) - Integrated in VSCode, convenient

### Container Management

- **Portainer**: `docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer-ce`
  - Web interface for managing Docker, suitable for beginners

### Java IDEs (Alternatives)

**Choose one IDE (if not using VSCode):**

- **IntelliJ IDEA Community**: [Download](https://www.jetbrains.com/idea/download/) - Most powerful for Java
- **Eclipse**: [Download](https://www.eclipse.org/downloads/) - Open source, lighter

### Terminal Emulators

**Choose by operating system:**

- **Windows Terminal** (Windows) - Already available on Windows 11
- **iTerm2** (MacOS) - Best for MacOS
- **Terminator / Alacritty** (Linux) - Light, fast

## ✅ Check Installation

Run the following script to check all tools:

```bash
#!/bin/bash

echo "🔍 Checking environment..."
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
echo "✅ Check complete!"
```

**Save script** to file `check-env.sh`, grant permissions and run:

```bash
chmod +x check-env.sh
./check-env.sh
```

**🎉 Wishing you effective studying!**

If you encounter problems:

1. 🔍 Search for errors on Google/Stack Overflow
2. 📚 Read official tool documentation
3. 💬 Ask in communities (GitHub Issues, Discord, Reddit)
4. 📧 Contact instructor
