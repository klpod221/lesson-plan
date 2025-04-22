# Cài đặt môi trường học tập JAVA, MySQL, WEB

## **Lưu ý:** Hãy đọc kỹ phần này trước khi bắt đầu cài đặt môi trường học tập

- Công nghệ thay đổi rất nhanh, và có thể hướng dẫn cài đặt này đã lỗi thời. Nếu bạn gặp khó khăn trong việc cài đặt, hãy tìm kiếm trên Google, StackOverflow, AI hoặc các diễn đàn khác để tìm kiếm giải pháp.
- Tôi sẽ không sử dụng bất kỳ IDE mà sẽ sử dụng Code editor - [Visual Studio Code](https://code.visualstudio.com/) để viết và biên dịch mã nguồn. Vì vậy tôi sẽ chỉ hướng dẫn cài đặt môi trường học tập với Visual Studio Code. Nếu bạn muốn sử dụng IDE khác, hãy tìm kiếm trên Google để biết cách cài đặt.
- Tôi không chịu trách nhiệm về bất kỳ vấn đề nào xảy ra trong quá trình cài đặt môi trường học tập. Hãy chắc chắn rằng bạn đã sao lưu dữ liệu quan trọng trước khi thực hiện bất kỳ thay đổi nào trên máy tính của bạn.
- Nếu bạn không thể tự cài đặt môi trường, hãy tìm kiếm một người bạn có thể giúp đỡ hoặc tham gia vào một nhóm học tập để cùng nhau giải quyết vấn đề. Bạn có thể liên lạc với tôi qua [trang cá nhân](https://klpod221.dev) để được hỗ trợ.
- Tôi đang sủ dụng một distro Linux có tên là [Arch Linux](https://archlinux.org/), với các hệ điều hành khác như Windows, macOS hoặc các distro Linux khác, tôi không thể đảm bảo rằng hướng dẫn này sẽ hoạt động. Tuy nhiên, bạn có thể tham khảo để tìm hiểu cách cài đặt môi trường học tập cho riêng mình.
- Nếu bạn không có máy tính cá nhân, hãy tìm kiếm một máy tính khác để cài đặt môi trường học tập. Bạn có thể sử dụng máy tính của bạn bè, gia đình hoặc thậm chí là máy tính công cộng tại thư viện hoặc quán cà phê.

## Nội dung

- [Cài đặt môi trường học tập JAVA, MySQL, WEB](#cài-đặt-môi-trường-học-tập-java-mysql-web)
  - [**Lưu ý:** Hãy đọc kỹ phần này trước khi bắt đầu cài đặt môi trường học tập](#lưu-ý-hãy-đọc-kỹ-phần-này-trước-khi-bắt-đầu-cài-đặt-môi-trường-học-tập)
  - [Nội dung](#nội-dung)
  - [Cài đặt VSCode](#cài-đặt-vscode)
  - [Dành cho Windows (Windows 10/11)](#dành-cho-windows-windows-1011)
    - [Cài đặt WSL (Windows Subsystem for Linux): Official Documentation](#cài-đặt-wsl-windows-subsystem-for-linux-official-documentation)
  - [Dành cho Ubuntu](#dành-cho-ubuntu)
    - [Cập nhật hệ thống và cài đặt các công cụ phát triển](#cập-nhật-hệ-thống-và-cài-đặt-các-công-cụ-phát-triển)
    - [Cài đặt JAVA cho Ubuntu](#cài-đặt-java-cho-ubuntu)
    - [Cài đặt MySQL cho Ubuntu](#cài-đặt-mysql-cho-ubuntu)
    - [Cài đặt PHP và Composer cho Ubuntu](#cài-đặt-php-và-composer-cho-ubuntu)
  - [Dành cho MacOS](#dành-cho-macos)
    - [Cài đặt Homebrew](#cài-đặt-homebrew)
    - [Cài đặt JAVA cho MacOS](#cài-đặt-java-cho-macos)
    - [Cài đặt MySQL cho MacOS](#cài-đặt-mysql-cho-macos)
    - [Cài đặt PHP và Composer cho MacOS](#cài-đặt-php-và-composer-cho-macos)
  - [Cài đặt Node.js với nvm (Áp dụng cho WSL và tất cả các hệ điều hành khác)](#cài-đặt-nodejs-với-nvm-áp-dụng-cho-wsl-và-tất-cả-các-hệ-điều-hành-khác)
  - [Sử dụng VSCode extension SQLTools để kết nối và quản lý MySQL](#sử-dụng-vscode-extension-sqltools-để-kết-nối-và-quản-lý-mysql)

## Cài đặt VSCode

- Tải xuống và cài đặt Visual Studio Code từ trang chính thức: [Visual Studio Code](https://code.visualstudio.com/) hoặc sử dụng trình quản lý gói của hệ điều hành của bạn để cài đặt:

  - **Ubuntu**:

    ```bash
      sudo snap install --classic code
    ```

  - **Arch Linux**:

    ```bash
      sudo pacman -S code
    ```

    hoặc sử dụng AUR (Khuyên dùng)

    ```bash
      git clone https://aur.archlinux.org/yay.git
      cd yay
      makepkg -si
      yay -S visual-studio-code-bin
    ```

  - **MacOS**: Nếu bạn chưa cài đặt Homebrew, hãy đến phần [Cài đặt Homebrew](#cài-đặt-homebrew) để cài đặt Homebrew trước. Sau đó, bạn có thể cài đặt Visual Studio Code bằng cách chạy lệnh sau trong terminal:

    ```bash
      brew install --cask visual-studio-code
    ```

- Sau khi cài đặt xong, mở Visual Studio Code và cài đặt các extension cần thiết:

  - [JAVA Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack): Gói mở rộng JAVA bao gồm các công cụ cần thiết để phát triển ứng dụng JAVA.
  - [SQLTools](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools): Công cụ SQL giúp bạn kết nối và quản lý cơ sở dữ liệu MySQL.
  - [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer): Mở một máy chủ tạm thời để xem trước các trang web HTML/CSS/JavaScript của bạn trong trình duyệt.
  - [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode): Công cụ định dạng mã nguồn giúp bạn giữ mã nguồn sạch sẽ và dễ đọc.
  - [HTML CSS Support](https://marketplace.visualstudio.com/items?itemName=ecmel.vscode-html-css): Hỗ trợ HTML và CSS trong Visual Studio Code.
  - [JavaScript (ES6) code snippets](https://marketplace.visualstudio.com/items?itemName=xabikos.JavaScriptSnippets): Cung cấp các đoạn mã mẫu cho JavaScript ES6.
  - [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens): Công cụ giúp bạn quản lý Git trong Visual Studio Code.
  - [Error Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.errorlens): Công cụ giúp bạn phát hiện lỗi trong mã nguồn nhanh chóng.
  - Ngoài ra bạn có thể cài đặt các extension khác tùy theo nhu cầu của bạn như các theme, icon, font chữ, v.v.

## Dành cho Windows (Windows 10/11)

Nếu bạn đang sử dụng Windows 10 phiên bản 1903 trở lên hoặc Windows 11, bạn có thể cài đặt môi trường học tập bằng cách sử dụng Windows Subsystem for Linux (WSL). WSL cho phép bạn chạy một distro Linux trên Windows mà không cần phải cài đặt máy ảo hoặc khởi động lại máy tính của bạn.

### Cài đặt WSL (Windows Subsystem for Linux): [Official Documentation](https://docs.microsoft.com/en-us/windows/wsl/install)

- Mở PowerShell với quyền quản trị (Run as Administrator) và chạy lệnh sau để cài đặt WSL:

```powershell
wsl --install
```

- Khởi động lại máy tính của bạn khi được yêu cầu.
- Mở PowerShell hoặc Command Prompt và chạy lệnh sau để kiểm tra phiên bản WSL:

```powershell
wsl --version
```

- Nếu bạn muốn cài đặt một distro Linux cụ thể, bạn có thể tìm kiếm và cài đặt từ Microsoft Store. Ví dụ, để cài đặt Ubuntu, bạn có thể tìm kiếm "Ubuntu" trong Microsoft Store và cài đặt nó.

- Sau khi cài đặt xong, mở Ubuntu từ menu Start hoặc tìm kiếm "Ubuntu" trong Windows Search.
- Bạn sẽ được yêu cầu tạo một tài khoản người dùng và mật khẩu cho distro Linux của bạn. Hãy nhớ ghi lại thông tin này vì bạn sẽ cần nó để đăng nhập vào distro Linux của bạn.
- Sau khi hoàn tất, bạn sẽ có một terminal Linux hoạt động trên Windows của bạn.
- Bạn có thể sử dụng terminal này để cài đặt các công cụ phát triển như JAVA, MySQL, Node.js, v.v. theo [hướng dẫn bên dưới](#dành-cho-ubuntu).
- Sau khi cài đặt xong, bạn có thể bắt đầu với lộ trình học tập của mình bằng cách tạo một thư mục dự án và mở nó trong Visual Studio Code. Bạn có thể sử dụng lệnh sau để mở thư mục trong VSCode từ terminal:

```bash
code .
```

## Dành cho Ubuntu

### Cập nhật hệ thống và cài đặt các công cụ phát triển

- Bạn có thể cập nhật hệ thống, cài đặt một số công cụ phát triển cơ bản bằng cách chạy lệnh sau:

```bash
sudo apt update && sudo apt upgrade -y && sudo apt install build-essential git curl wget -y
```

### Cài đặt JAVA cho Ubuntu

- Sau khi mở terminal, bạn có thể cài đặt JAVA bằng cách chạy lệnh sau (bạn có thể thay đổi phiên bản JAVA nếu cần):

```bash
sudo apt install openjdk-17-jdk -y
```

- Kiểm tra phiên bản JAVA đã cài đặt:

```bash
java -version
```

### Cài đặt MySQL cho Ubuntu

- Bạn có thể cài đặt MySQL bằng cách chạy lệnh sau:

```bash
sudo apt install mysql-server -y
```

- Sau khi cài đặt xong, bạn có thể khởi động MySQL bằng lệnh sau:

```bash
sudo systemctl start mysql
```

- Để kiểm tra trạng thái của MySQL, bạn có thể chạy lệnh sau:

```bash
sudo systemctl status mysql
```

- Để bảo mật cài đặt MySQL, bạn có thể chạy lệnh sau:

```bash
sudo mysql_secure_installation
```

- Để đăng nhập vào MySQL, bạn có thể chạy lệnh sau, nếu đăng nhập không thành công, hãy thử với tài khoản root:

```bash
sudo mysql -u root -p
```

### Cài đặt PHP và Composer cho Ubuntu

- Nếu bạn cần sử dụng PHP, bạn có thể cài đặt PHP và Composer bằng cách chạy lệnh sau:

```bash
sudo apt install php php-mysql php-cli php-curl php-zip php-gd php-mbstring -y
```

- Kiểm tra phiên bản PHP đã cài đặt:

```bash
php -v
```

- Cài đặt Composer (trình quản lý gói PHP) bằng cách chạy lệnh sau:

```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

- Kiểm tra phiên bản Composer đã cài đặt:

```bash
composer -V
```

## Dành cho MacOS

### Cài đặt Homebrew

- Homebrew là một trình quản lý gói cho macOS, giúp bạn cài đặt và quản lý các ứng dụng và công cụ phát triển dễ dàng hơn. Bạn có thể cài đặt Homebrew bằng cách chạy lệnh sau trong terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Cài đặt JAVA cho MacOS

- Sau khi cài đặt Homebrew, bạn có thể cài đặt JAVA bằng cách chạy lệnh sau (bạn có thể thay đổi phiên bản JAVA nếu cần):

```bash
brew install openjdk@17
```

- Kiểm tra phiên bản JAVA đã cài đặt:

```bash
java -version
```

### Cài đặt MySQL cho MacOS

- Bạn có thể cài đặt MySQL bằng cách chạy lệnh sau:

```bash
brew install mysql
```

- Sau khi cài đặt xong, bạn có thể khởi động MySQL bằng lệnh sau:

```bash
brew services start mysql
```

- Để kiểm tra trạng thái của MySQL, bạn có thể chạy lệnh sau:

```bash
brew services list
```

- Để bảo mật cài đặt MySQL, bạn có thể chạy lệnh sau:

```bash
mysql_secure_installation
```

- Để đăng nhập vào MySQL, bạn có thể chạy lệnh sau:

```bash
mysql -u root -p
```

### Cài đặt PHP và Composer cho MacOS

- Nếu bạn cần sử dụng PHP, bạn có thể cài đặt PHP và Composer bằng cách chạy lệnh sau:

```bash
brew install php
```

- Kiểm tra phiên bản PHP đã cài đặt:

```bash
php -v
```

- Cài đặt Composer (trình quản lý gói PHP) bằng cách chạy lệnh sau:

```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

- Kiểm tra phiên bản Composer đã cài đặt:

```bash
composer -V
```

## Cài đặt Node.js với nvm (Áp dụng cho WSL và tất cả các hệ điều hành khác)

- Bạn có thể cài đặt Node.js bằng cách sử dụng nvm (Node Version Manager). Đầu tiên, bạn cần cài đặt nvm bằng cách chạy lệnh sau:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
```

- Sau khi cài đặt xong, bạn cần khởi động lại terminal hoặc chạy lệnh sau để tải nvm vào terminal:

```bash
source ~/.bashrc
```

- Kiểm tra xem nvm đã được cài đặt thành công chưa bằng cách chạy lệnh sau:

```bash
nvm --version
```

- Sau khi cài đặt xong nvm, bạn có thể cài đặt Node.js bằng cách chạy lệnh sau:

```bash
nvm install --lts
```

- Kiểm tra phiên bản Node.js và npm đã cài đặt:

```bash
node -v
npm -v
```

## Sử dụng VSCode extension SQLTools để kết nối và quản lý MySQL

- Cài đặt extension SQLTools.
- Sau khi cài đặt xong, bạn có thể mở SQLTools bằng cách nhấn tổ hợp phím `Ctrl + Shift + P` và tìm kiếm "SQLTools: Add new connection".
- Nhập thông tin kết nối MySQL của bạn, bao gồm hostname, port, username và password.
- Nhấn "Test Connection" để kiểm tra kết nối. Nếu kết nối thành công, bạn có thể lưu lại và bắt đầu sử dụng SQLTools để quản lý cơ sở dữ liệu MySQL của bạn.
- Bạn có thể tạo, sửa đổi và xóa cơ sở dữ liệu, bảng, và thực hiện các truy vấn SQL trực tiếp từ Visual Studio Code.
- Ngoài ra, bạn cũng có thể sử dụng SQLTools để chạy các truy vấn SQL và xem kết quả trực tiếp trong Visual Studio Code.
- Nếu bạn gặp khó khăn trong việc sử dụng SQLTools, hãy tham khảo tài liệu hướng dẫn sử dụng trên trang chính thức của SQLTools hoặc tìm kiếm trên Google để tìm hiểu thêm.
- Bạn cũng có thể sử dụng các phần mềm quản lý cơ sở dữ liệu khác như MySQL Workbench, DBeaver hoặc HeidiSQL để quản lý cơ sở dữ liệu MySQL của bạn.
