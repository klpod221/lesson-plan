---
prev:
  text: '🌐 Triển Khai Chuyên Nghiệp'
  link: '/PHP/Part6'
next:
  text: '🐳 Docker: Orchestration'
  link: '/DEVOPS/Docker2'
---

# 🐳 DOCKER: NẮM VỮNG NỀN TẢNG

## 🎯 Mục Tiêu Tổng Quát

- Hiểu rõ **Docker** và **Docker Compose** là gì, tại sao chúng quan trọng trong phát triển phần mềm hiện đại.
- Nắm vững các **khái niệm cốt lõi** và **lệnh Docker cơ bản**.
- Biết cách **Dockerize** một ứng dụng đơn giản.
- Sử dụng **Docker Compose** để quản lý các ứng dụng đa-container.
- Làm quen với các **lệnh Linux cơ bản** thường dùng khi làm việc với Docker.
- Tự tin áp dụng Docker vào **workflow phát triển hàng ngày** để tăng hiệu suất và tính nhất quán.

## 🎯 Mục Tiêu Chi Tiết (Bài học này)

- Hiểu được vấn đề Docker giải quyết.
- Phân biệt được sự khác nhau giữa **Virtual Machines (VMs)** và **Containers**.
- Nắm vững các khái niệm cốt lõi: `Image`, `Container`, `Dockerfile`, `Registry`, `Docker Engine`.
- Thành thạo các lệnh `Docker CLI` cơ bản để quản lý images và containers.
- Làm quen với các lệnh `Linux` cơ bản cần thiết khi làm việc với Docker, đặc biệt là bên trong containers và khi viết Dockerfiles.
- Thực hành xây dựng `Dockerfile` đầu tiên, build image và chạy `container` từ image đó.

## 1. 🌟 Giới Thiệu

### Vấn đề "It works on my machine!"

Đây là một câu nói "kinh điển" trong giới lập trình, phản ánh một vấn đề phổ biến:

- **Môi trường khác nhau:** Ứng dụng chạy tốt trên máy của lập trình viên (dev) nhưng lại lỗi khi triển khai lên môi trường staging hoặc production. Lý do có thể là phiên bản hệ điều hành khác nhau, thư viện thiếu hoặc khác phiên bản, cấu hình môi trường (biến môi trường, đường dẫn file) không đồng nhất.
- **Xung đột thư viện (Dependency Hell):** Nhiều ứng dụng trên cùng một server có thể yêu cầu các phiên bản khác nhau của cùng một thư viện, dẫn đến xung đột.
- **Khó khăn khi setup môi trường cho người mới:** Mỗi khi có thành viên mới tham gia dự án, việc cài đặt và cấu hình môi trường phát triển giống hệt mọi người tốn nhiều thời gian và dễ xảy ra lỗi.
- **Tính di động kém:** Việc di chuyển ứng dụng từ server này sang server khác, hoặc từ on-premise lên cloud gặp nhiều trở ngại.

![Hình ảnh minh họa: meme "works on my machine"](../images/devops/itworksonmymachine.webp)

### Giải pháp là gì? VMs vs Containers

Để hiểu rõ sự khác biệt giữa Máy ảo (Virtual Machines - VMs) và Containers, trước tiên chúng ta cần nắm được khái niệm **Kernel**.

#### Kernel là gì?

- **Kernel (nhân hệ điều hành)** là **trái tim** của một hệ điều hành. Nó là lớp phần mềm cốt lõi, quản lý tài nguyên phần cứng của máy tính (CPU, RAM, ổ đĩa, thiết bị mạng) và cung cấp các dịch vụ cơ bản cho tất cả các chương trình khác chạy trên đó.
- Khi một ứng dụng muốn thực hiện một tác vụ như đọc file, gửi dữ liệu qua mạng, hoặc cấp phát bộ nhớ, nó không làm trực tiếp mà phải thông qua các **system calls (lời gọi hệ thống)** tới Kernel. Kernel sẽ xử lý yêu cầu đó.
  Tuyệt vời! Dưới đây là thông tin về kernel của các hệ điều hành phổ biến, được trình bày theo format bạn yêu cầu:
- **Kernel của các hệ điều hành phổ biến:**

  - **Linux Kernel:**

    - **Nguồn gốc & Giấy phép:** Được sáng tạo bởi Linus Torvalds vào năm 1991, lấy cảm hứng từ MINIX (mini-Unix). Phát hành dưới giấy phép GPLv2 (mã nguồn mở hoàn toàn và miễn phí).
    - **Kiến trúc:** Chủ yếu là **Monolithic** (nguyên khối), nhưng rất **modular** với các Loadable Kernel Modules (LKMs), cho phép tải/dỡ bỏ động các trình điều khiển và tính năng.
    - **Mô hình Phát triển:** Phát triển mở bởi một cộng đồng toàn cầu, dưới sự giám sát của Linus Torvalds và các maintainer chủ chốt.
    - **Đặc điểm nổi bật:**
      - Hỗ trợ phần cứng cực kỳ rộng rãi trên nhiều kiến trúc CPU.
      - Tính linh hoạt và tùy biến rất cao.
      - Hỗ trợ một lượng lớn hệ thống file (ext4, XFS, Btrfs, NTFS, FAT, v.v.).
      - Sử dụng mô hình tiến trình Unix truyền thống (ví dụ: `fork()`, `exec()`).
    - **Ứng dụng chính:** Máy chủ (web, database, cloud), máy tính để bàn (qua các bản phân phối Linux - Linux distro như Ubuntu, Fedora), thiết bị nhúng, supercomputers, và là nền tảng của Android.

  - **Windows NT Kernel:**

    - **Nguồn gốc & Giấy phép:** (Trước đây là kernel cho hệ điều hành Windows NT, sau này trở thành nền tảng cho tất cả các phiên bản Windows hiện đại như Windows XP, Vista, 7, 8, 10, 11 và các phiên bản Windows Server). Được phát triển bởi Microsoft, có nguồn gốc từ các ý tưởng trong VMS (Digital Equipment Corporation). Mã nguồn đóng, độc quyền của Microsoft.
    - **Kiến trúc:** **Hybrid**, kết hợp một microkernel nhỏ (NT Executive) với nhiều dịch vụ hệ thống quan trọng (quản lý file, network, đồ họa) chạy trong không gian kernel để tối ưu hiệu năng.
    - **Mô hình Phát triển:** Phát triển đóng, nội bộ bởi các kỹ sư của Microsoft.
    - **Đặc điểm nổi bật:**
      - Tương thích phần mềm rộng rãi, đặc biệt là game và các ứng dụng desktop cho PC.
      - Sử dụng hệ thống file chính là NTFS (cũng hỗ trợ FAT/exFAT, ReFS).
      - Mô hình quản lý tiến trình và luồng riêng biệt (ví dụ: `CreateProcess()`).
      - Hỗ trợ mạnh mẽ cho các dịch vụ doanh nghiệp và Active Directory.
    - **Ứng dụng chính:** Máy tính cá nhân (Windows 10, Windows 11), máy chủ (Windows Server), hệ máy chơi game Xbox, một số thiết bị nhúng (Windows IoT).

  - **XNU Kernel:**
    - **Nguồn gốc & Giấy phép:** Tên XNU là viết tắt của "X is Not Unix". Được phát triển bởi Apple. Phần lớn mã nguồn của XNU là mở (ví dụ theo Apple Public Source License - APSL, và các phần theo giấy phép BSD), tuy nhiên, toàn bộ hệ điều hành (macOS, iOS,...) mà nó phục vụ là độc quyền.
    - **Kiến trúc:** **Hybrid**, dựa trên **microkernel Mach** (từ Carnegie Mellon University) cho các tác vụ cơ bản như quản lý tiến trình, bộ nhớ ảo, và giao tiếp liên tiến trình (IPC). Tích hợp các thành phần từ hệ điều hành **BSD** (ví dụ: network stack, Virtual File System, một số system calls tương thích POSIX) chạy trong cùng không gian địa chỉ với Mach. I/O Kit quản lý các trình điều khiển thiết bị (drivers).
    - **Mô hình Phát triển:** Chủ yếu phát triển bởi Apple, mặc dù có sự đóng góp từ cộng đồng cho các phần mã nguồn mở của kernel.
    - **Đặc điểm nổi bật:**
      - Tích hợp chặt chẽ với phần cứng do Apple thiết kế, mang lại hiệu năng tối ưu.
      - Cung cấp API tương thích POSIX thông qua lớp BSD.
      - Sử dụng hệ thống file chính là APFS (Apple File System), trước đó là HFS+.
      - Tập trung vào trải nghiệm người dùng mượt mà và các tính năng bảo mật.
      - Sử dụng Kernel Extensions (KEXTs) cho drivers, đang dần chuyển sang DriverKit (cho phép drivers chạy một phần hoặc toàn bộ trong user space).
    - **Ứng dụng chính:** Máy tính cá nhân (macOS), điện thoại thông minh (iOS), máy tính bảng (iPadOS), đồng hồ thông minh (watchOS), và các thiết bị TV (tvOS) của Apple.

- **Sơ đồ quá trình khởi động máy tính:**
  (Sơ đồ này minh họa Kernel được tải và chạy ở giai đoạn nào)

  ```text
      +-------------------------+
      |   1. BẬT NGUỒN          |
      |   (Nhấn nút nguồn)      |
      +-------------------------+
                |
                V
      +---------------------------------------------------------------------+
      |   2. BIOS/UEFI CHẠY (Firmware trên Bo mạch chủ)                     |
      |       |                                                             |
      |       +-- a. Kích hoạt BIOS/UEFI từ chip ROM                        |
      |       |                                                             |
      |       +-- b. POST (Power-On Self-Test)                              |
      |       |    (Kiểm tra CPU, RAM, VGA, Keyboard...)                    |
      |       |    (-> Báo lỗi nếu có)                                      |
      |       |                                                             |
      |       +-- c. Khởi tạo các thiết bị phần cứng cơ bản                 |
      |       |                                                             |
      |       +-- d. Tìm Thiết bị Khởi động (Bootable Device)               |
      |       |    (Theo thứ tự cấu hình: HDD/SSD, USB, Network...)         |
      |       |                                                             |
      |       +-- e. Đọc MBR/ESP từ Thiết bị Khởi động                      |
      |            |                                                        |
      |            +--> Tải BOOTLOADER vào RAM                              |
      |                 (Ví dụ: GRUB, Windows Boot Manager)                 |
      +---------------------------------------------------------------------+
                            |
                            V (Bootloader tiếp quản)
      +---------------------------------------------------------------------+
      |   3. BOOTLOADER CHẠY (Trong RAM)                                    |
      |       |                                                             |
      |       +-- a. (Tùy chọn) Hiển thị menu chọn Hệ Điều Hành (HĐH)       |
      |       |                                                             |
      |       +-- b. Tải KERNEL của HĐH đã chọn vào RAM                     |
      |       |    (Từ Ổ cứng/SSD)                                          |
      |       |                                                             |
      |       +-- c. (Tùy chọn) Tải Initial RAM Disk (initrd/initramfs)     |
      |            (Chứa driver tạm thời cho Kernel)                        |
      +---------------------------------------------------------------------+
                            |
                            V (Kernel tiếp quản)
      +---------------------------------------------------------------------+
      |   4. KERNEL CHẠY (Trong RAM)                                        |
      |       |                                                             |
      |       +-- a. Kernel được giải nén và bắt đầu thực thi               |
      |       |                                                             |
      |       +-- b. Khởi tạo Cấu trúc Dữ liệu, Device Drivers phức tạp hơn |
      |       |                                                             |
      |       +-- c. Mount Hệ thống File Gốc (Root Filesystem)              |
      |       |                                                             |
      |       +-- d. Khởi chạy Tiến trình INIT (PID 1)                      |
      |            (Ví dụ: /sbin/init, systemd)                             |
      |            (Đây là tiến trình đầu tiên trong User Space)            |
      +---------------------------------------------------------------------+
                            |
                            V (Init process tiếp quản)
      +---------------------------------------------------------------------+
      |   5. HỆ ĐIỀU HÀNH KHỞI ĐỘNG HOÀN TẤT                                |
      |       |                                                             |
      |       +-- a. Init/systemd khởi chạy các Dịch vụ Hệ thống            |
      |       |    (Network, Logging, Display Manager...)                   |
      |       |                                                             |
      |       +-- b. Khởi chạy Giao diện Người dùng (GUI hoặc CLI)          |
      |       |    (Login screen, Desktop Environment, Shell...)            |
      |       |                                                             |
      |       +-- c. Kernel hoạt động đầy đủ, quản lý hệ thống              |
      |            |                                                        |
      |            +--> NGƯỜI DÙNG CÓ THỂ SỬ DỤNG MÁY TÍNH                  |
      +---------------------------------------------------------------------+
  ```

#### Máy ảo (VMs) hoạt động như thế nào?

- Mỗi VM chạy một **hệ điều hành khách (Guest OS) hoàn chỉnh**, bao gồm cả **Kernel riêng** của Guest OS đó.
- Ví dụ: Bạn có một máy chủ vật lý chạy Linux (Host OS). Bạn cài một Hypervisor (như VMware, VirtualBox, KVM). Trên Hypervisor đó, bạn có thể tạo:
  - Một VM chạy Windows (có Kernel Windows riêng).
  - Một VM khác chạy một phiên bản Ubuntu khác (có Kernel Linux riêng, khác với Kernel của Host OS hoặc cùng phiên bản nhưng độc lập).
- **Minh họa VM:**

  ```text
        App A     |     App B
     (trong VM1)  |  (trong VM2)
    --------------|--------------
     Guest OS 1   |  Guest OS 2
    (Kernel G1)   |  (Kernel G2)
    ============================= Hypervisor
              Host OS
             (Kernel H)
    =============================
              Hardware
  ```

- Điều này có nghĩa là VM1 và VM2 hoàn toàn cô lập về mặt Kernel. Kernel G1 không biết gì về Kernel G2 hay Kernel H.

> Một máy ảo giống như một căn nhà riêng, có nền móng, điện nước riêng.

#### Containers (Docker) hoạt động như thế nào: "Chia sẻ Kernel của Host OS"

- Tất cả các containers chạy trên cùng một máy chủ (Host OS) sẽ **cùng sử dụng chung một Kernel duy nhất, đó là Kernel của Host OS.**
- Containers không có Kernel riêng. Thay vào đó, Docker Engine sử dụng các tính năng của Kernel Host OS (chủ yếu trên Linux là **Namespaces** và **Control Groups - cgroups**) để tạo ra sự cô lập cho các container.
- **Minh họa Container:**

  ```text
        App A    |     App B     |     App C
     (Container1)| (Container2)  | (Container3)
     Libs/Bins A | Libs/Bins B   | Libs/Bins C
    ------------------------------------------- Docker Engine
                    Host OS
                   (Kernel H)
    ===========================================
                    Hardware
  ```

> - Tưởng tượng Tòa nhà chung cư (Host OS):
>   - Containers = Các căn hộ: Dùng chung nền móng (Kernel Host), điện nước tổng (dịch vụ Host OS).
>   - Namespaces = Tường riêng, cửa riêng: Căn hộ A không thấy đồ của căn hộ B (cô lập process, network, filesystem view).
>   - Cgroups = Đồng hồ điện/nước của quản lý: Mỗi căn hộ được dùng giới hạn tài nguyên (CPU, RAM).

- **Điều này có nghĩa là:**

  - Khi một ứng dụng bên trong Container 1 (ví dụ, một Nginx server) cần mở một network socket, nó thực hiện một system call. System call này được xử lý trực tiếp bởi **Kernel của Host OS**.
  - Tương tự, khi một ứng dụng trong Container 2 (ví dụ, một Python app) cần đọc một file, system call của nó cũng được xử lý bởi **Kernel của Host OS**.
  - Mặc dù cùng dùng chung Kernel, các container vẫn được cô lập với nhau. Docker Engine, thông qua Kernel Host, đảm bảo rằng:
    - **Namespaces:** Container 1 không "nhìn thấy" các process, network interfaces, hay filesystem của Container 2 (và ngược lại). Mỗi container có một "view" riêng về hệ thống, mặc dù nền tảng là chung.
      - `PID namespace`: Mỗi container có cây process riêng, bắt đầu từ PID 1.
      - `Network namespace`: Mỗi container có network stack riêng (IP, routing table, port).
      - `Mount namespace`: Mỗi container có cấu trúc thư mục (filesystem) riêng.
      - `UTS namespace`: Mỗi container có hostname riêng.
      - `User namespace`: Ánh xạ user ID trong container sang user ID khác trên host.
    - **Control Groups (cgroups):** Giới hạn và theo dõi tài nguyên (CPU, RAM, I/O) mà mỗi container có thể sử dụng. Điều này ngăn một container "tham lam" chiếm hết tài nguyên của hệ thống.

- **Hệ quả của việc chia sẻ Kernel:**

  - **Khởi động nhanh:** Vì không phải boot cả một hệ điều hành mới, container khởi động gần như tức thì (chỉ là khởi động process của ứng dụng).
  - **Nhẹ hơn:** Không tốn tài nguyên (CPU, RAM, disk) cho Guest OS riêng, chỉ tốn cho ứng dụng và thư viện của nó.
  - **Mật độ cao hơn:** Có thể chạy nhiều container hơn trên cùng một host so với VMs.
  - **Yêu cầu Kernel tương thích:** Vì chia sẻ Kernel, bạn không thể chạy một container Linux trực tiếp trên một Kernel Windows (và ngược lại) _một cách tự nhiên_.
    - _Lưu ý:_ Docker Desktop trên Windows hoặc macOS thực chất chạy một máy ảo Linux nhỏ bên dưới để có thể chạy các container Linux. Khi đó, các container Linux đó chia sẻ Kernel của máy ảo Linux này, chứ không phải Kernel của Windows/macOS.

#### So sánh VMs và Containers

| Tính năng        | Virtual Machines (VMs)                                                                                                                                                       | Containers (Docker)                                                                                  |
| :--------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------- |
| **Isolation**    | **OS Level**: Mỗi VM có một Hệ Điều Hành (Guest OS) và Kernel riêng biệt, hoàn toàn cô lập với Host OS và các VM khác.                                                       | **Process Level**: Containers chia sẻ Kernel của Host OS. Cô lập ở mức process, filesystem, network. |
| **Overhead**     | **Cao**: Mỗi VM cần tài nguyên (RAM, CPU, Disk) cho cả Guest OS, gây lãng phí nếu chỉ chạy một ứng dụng nhỏ.                                                                 | **Thấp**: Chỉ tiêu tốn tài nguyên cho ứng dụng và các dependencies của nó, không cần Guest OS riêng. |
| **Startup Time** | **Chậm (phút)**: Phải khởi động cả một Guest OS.                                                                                                                             | **Nhanh (giây)**: Chỉ cần khởi động process của ứng dụng.                                            |
| **Portability**  | **Khá**: Image VM thường rất lớn (GBs), di chuyển và quản lý phức tạp hơn.                                                                                                   | **Rất cao**: Image container nhỏ gọn hơn nhiều (MBs đến vài trăm MBs), dễ dàng di chuyển và chia sẻ. |
| **Density**      | **Thấp**: Số lượng VM có thể chạy trên một host bị giới hạn bởi tài nguyên cần cho Guest OS.                                                                                 | **Cao**: Có thể chạy nhiều container hơn trên cùng một host do overhead thấp.                        |
| **Use Case**     | Cần chạy các OS khác nhau hoàn toàn trên cùng một host (VD: Windows trên Linux). Yêu cầu mức độ bảo mật kernel riêng biệt. Chạy các ứng dụng "legacy" không dễ containerize. | Đóng gói và chạy ứng dụng, microservices, CI/CD pipelines, môi trường phát triển nhất quán.          |

---

**Docker là một nền tảng containerization** giúp đóng gói ứng dụng và tất cả các dependencies của nó (thư viện, runtime, system tools, code) thành một đơn vị chuẩn hóa, di động gọi là **container**. Container này có thể chạy nhất quán trên bất kỳ máy nào có cài Docker, bất kể môi trường bên dưới.

## 2. 🐧 Linux Cơ Bản Cho Docker

### Tại sao cần biết Linux cơ bản?

- **Base Images:** Phần lớn các Docker images phổ biến (ví dụ: `ubuntu`, `alpine`, `centos`, `node`, `python`, `nginx`) được xây dựng dựa trên các bản phân phối Linux.
- **Dockerfile Instructions:** Nhiều lệnh trong `Dockerfile` (như `RUN`) thực chất là các lệnh shell của Linux để cài đặt phần mềm, cấu hình, v.v.
- **Interacting with Containers:** Khi bạn cần gỡ lỗi hoặc kiểm tra một container đang chạy, bạn thường sẽ `exec` vào container đó và sử dụng các lệnh Linux để xem logs, kiểm tra file, tiến trình.

Hiểu một số lệnh Linux cơ bản sẽ giúp bạn làm việc với Docker hiệu quả hơn rất nhiều.

### Di chuyển & Quản lý file/thư mục

- `pwd` (print working directory): Hiển thị thư mục làm việc hiện tại.
  - _Ví dụ:_ `pwd` -> `/app`
- `ls` (list): Liệt kê file và thư mục trong thư mục hiện tại (hoặc thư mục được chỉ định).
  - `ls -l`: Hiển thị chi tiết (quyền, chủ sở hữu, kích thước, ngày sửa đổi).
  - `ls -a` hoặc `ls -A`: Hiển thị cả file/thư mục ẩn (bắt đầu bằng dấu `.`, `-A` không hiện `.` và `..`).
  - `ls -lh`: Hiển thị chi tiết với kích thước dễ đọc (KB, MB, GB).
  - _Ví dụ:_ `ls -lha /var/log`
- `cd <directory>` (change directory): Chuyển đến thư mục được chỉ định.
  - `cd ..`: Lên thư mục cha.
  - `cd ~` hoặc `cd`: Về thư mục home của user hiện tại.
  - `cd -`: Quay lại thư mục trước đó.
  - _Ví dụ:_ `cd /etc/nginx`
- `mkdir <directory_name>` (make directory): Tạo thư mục mới.
  - `mkdir -p /path/to/nested/directory`: Tạo cả các thư mục cha nếu chưa tồn tại.
  - _Ví dụ:_ `mkdir my_project`
- `touch <file_name>`: Tạo file rỗng nếu chưa tồn tại, hoặc cập nhật thời gian truy cập/sửa đổi của file nếu đã tồn tại.
  - _Ví dụ:_ `touch app.log`
- `rm <file_name>` (remove): Xóa file.
  - `rm -r <directory_name>`: Xóa thư mục và toàn bộ nội dung bên trong (recursive). **CẨN THẬN!**
  - `rm -f <file_name>`: Xóa file mà không hỏi xác nhận (force).
  - `rm -rf <directory_name>`: Xóa thư mục và nội dung bên trong, không hỏi xác nhận. **RẤT CẨN THẬN! Lệnh này có thể xóa sạch dữ liệu nếu dùng sai.**
  - _Ví dụ:_ `rm old_log.txt`, `rm -rf temp_files/`
- `cp <source> <destination>` (copy): Sao chép file hoặc thư mục.
  - `cp file1.txt file2.txt`: Sao chép `file1.txt` thành `file2.txt`.
  - `cp -r <source_dir> <destination_dir>`: Sao chép thư mục (recursive).
  - _Ví dụ:_ `cp config.yaml /app/config/`, `cp -r public_html/* /var/www/html/`
- `mv <source> <destination>` (move): Di chuyển hoặc đổi tên file/thư mục.
  - `mv old_name.txt new_name.txt`: Đổi tên file.
  - `mv file.txt /tmp/`: Di chuyển file vào thư mục `/tmp`.
  - _Ví dụ:_ `mv app.log app.log.bkp`, `mv build_output /opt/app`

### Quyền (Permissions) cơ bản

Khi dùng `ls -l`, bạn sẽ thấy thông tin quyền dạng `drwxr-xr--`:

- Ký tự đầu: `d` (directory), `-` (file), `l` (symbolic link).
- 3 nhóm tiếp theo (mỗi nhóm 3 ký tự `rwx`):
  1. **User (Owner):** Quyền của người sở hữu file/thư mục.
  2. **Group:** Quyền của nhóm sở hữu file/thư mục.
  3. **Others:** Quyền của những người dùng khác.
- `r`: read (đọc), `w`: write (ghi), `x`: execute (thực thi).

- `chmod <permissions> <file/directory>`: Thay đổi quyền.
  - Dạng số (octal): `r=4, w=2, x=1`. Ví dụ: `chmod 755 script.sh` (owner: rwx=7, group: r-x=5, others: r-x=5).
  - Dạng ký hiệu: `u` (user), `g` (group), `o` (others), `a` (all); `+` (thêm quyền), `-` (bỏ quyền), `=` (gán quyền).
  - _Ví dụ:_ `chmod +x script.sh` (thêm quyền execute cho owner, group, others).
  - _Ví dụ:_ `chmod u+x script.sh` (thêm quyền execute chỉ cho owner).
  - _Ví dụ:_ `chmod 600 private_key.pem` (owner: rw-, group/others: ---).
- `chown <user>:<group> <file/directory>`: Thay đổi chủ sở hữu và nhóm sở hữu.
  - _Ví dụ:_ `chown www-data:www-data /var/www/html` (thường dùng cho web server).

### Một số lệnh hữu ích khác

- `cat <file_name>`: Xem toàn bộ nội dung file ra màn hình.
  - `cat file1.txt file2.txt > combined.txt`: Nối nội dung file1 và file2 rồi ghi vào combined.txt.
- `less <file_name>` hoặc `more <file_name>`: Xem nội dung file từng trang (dùng phím cách để cuộn, `q` để thoát). `less` linh hoạt hơn.
- `head <file_name>`: Xem 10 dòng đầu tiên của file.
  - `head -n 20 <file_name>`: Xem 20 dòng đầu.
- `tail <file_name>`: Xem 10 dòng cuối cùng của file.
  - `tail -n 20 <file_name>`: Xem 20 dòng cuối.
  - `tail -f <file_name>`: Theo dõi file, hiển thị các dòng mới được thêm vào (rất hữu ích để xem log trực tiếp).
- `echo "text"`: In text ra màn hình.
  - `echo "text" > file.txt`: Ghi text vào file (ghi đè nếu file đã tồn tại, tạo mới nếu chưa).
  - `echo "text" >> file.txt`: Ghi text vào cuối file (append).
  - _Ví dụ:_ `echo "API_KEY=12345" > .env`
- `grep "pattern" <file_name>`: Tìm kiếm một "pattern" (chuỗi ký tự, biểu thức chính quy) trong file.
  - `grep -i "error" app.log`: Tìm "error" không phân biệt hoa thường.
  - `grep -r "config_value" /etc/`: Tìm "config_value" trong tất cả file thuộc thư mục `/etc` và con của nó.
  - `ps aux | grep nginx`: Tìm tiến trình có tên `nginx`.
- `find <directory> -name "<pattern>"`: Tìm kiếm file/thư mục.
  - _Ví dụ:_ `find /app -name "*.js"` (tìm tất cả file có đuôi .js trong /app).
  - _Ví dụ:_ `find . -type f -mtime -7` (tìm file được sửa đổi trong 7 ngày gần nhất ở thư mục hiện tại).
- `df -h` (disk free): Hiển thị dung lượng ổ đĩa còn trống (dạng dễ đọc).
- `du -sh <directory/file>` (disk usage): Hiển thị dung lượng sử dụng bởi file/thư mục (dạng dễ đọc, `-s` là summary).
- `ps aux`: Liệt kê tất cả các tiến trình đang chạy.
- `top` hoặc `htop`: Hiển thị các tiến trình đang chạy và tài nguyên hệ thống (CPU, RAM) theo thời gian thực. `htop` thân thiện hơn.
- `kill <pid>`: Gửi tín hiệu (mặc định là TERM) để dừng một tiến trình (PID là Process ID).
  - `kill -9 <pid>`: Force kill (SIGKILL).
- `which <command_name>`: Hiển thị đường dẫn đầy đủ của một lệnh.
  - _Ví dụ:_ `which python` -> `/usr/bin/python`
- `man <command_name>`: Hiển thị trang manual (hướng dẫn sử dụng) của một lệnh.
- `sudo <command>`: Thực thi lệnh với quyền superuser (root). Cần thiết cho các tác vụ yêu cầu quyền quản trị.

### Trình quản lý gói (Package Managers)

Thường được sử dụng trong `Dockerfile` để cài đặt phần mềm.

- Debian/Ubuntu: `apt-get update`, `apt-get install <package>`, `apt-get remove <package>`.
  - Ví dụ: `RUN apt-get update && apt-get install -y curl vim`
  - `-y`: tự động trả lời yes cho các câu hỏi.
- Alpine Linux: `apk update`, `apk add <package>`, `apk del <package>`. (Alpine thường được ưu tiên cho image nhỏ gọn).
  - Ví dụ: `RUN apk add --no-cache curl`
  - `--no-cache`: không lưu cache của package manager, giúp image nhỏ hơn.
- CentOS/RHEL/Fedora: `yum install <package>` (cũ hơn) hoặc `dnf install <package>`.
  - Ví dụ: `RUN yum install -y httpd`

## 3. 💡 Docker Core Concepts

### Kiến trúc tổng quan của Docker

```text
+----------------------+                          +------------------------------------------------------------+                         +-----------------------+
|                      | --- Lệnh (build, run) -->|                      DOCKER HOST                           |                         |                       |
|    DOCKER CLIENT     |                          |  +------------------------------------------------------+  |<---- Pull (kéo về) -----|       REGISTRY        |
|  (e.g., `docker` CLI)|                          |  |                  Docker Daemon                       |  |                         |  (e.g., Docker Hub,   |
|  (Bạn tương tác ở đây)|                         |  |                   (`dockerd`)                        |  |---- Push (đẩy lên) ---->|  AWS ECR, Google GCR) |
|                      | <-- Thông tin, kết quả --|  |        (Lắng nghe API, Quản lý Objects)              |  |                         |                       |
+----------------------+                          |  +-----------------------▲--┬---------------------------+  |                         +-----------------------+
                                                  |                          |  |                              |
                                                  | (Tải Images từ Registry  |  | (Chạy Containers từ Images)  |
                                                  |  Lưu trữ Images local)   |  | (Build Images từ Dockerfile) |
                                                  |                          |  |                              |
                                                  |  +-----------------------┴--▼---------------------------+  |
                                                  |  |       IMAGES            |       CONTAINERS           |  |
                                                  |  | (Templates Read-Only)   | (Running Instances)        |  |
                                                  |  |  - ubuntu:latest        |  - my_app_container        |  |
                                                  |  |  - nginx:alpine         |  - db_container            |  |
                                                  |  |  - my_custom_app:v1     |  - ...                     |  |
                                                  |  +-------------------------+----------------------------+  |
                                                  +------------------------------------------------------------+
```

### Docker Engine

Docker Engine là thành phần cốt lõi của Docker, hoạt động theo kiến trúc client-server:

```text
  +-----------------+      +-----------------+      +-------------------------+
  |   Người dùng    |----->|   Docker CLI    |----->|        REST API         |<---+ (Giao tiếp qua socket)
  +-----------------+      |   (`docker`)    |      +-------------------------+    |
                           +-----------------+                                     |
                                                      Docker Daemon (`dockerd`)    |
                                +--------------------------------------------------+
                                |                 "Trái tim của Docker" 🧠         |
                                |  - Chạy ngầm (background process) trên Host OS.  |
                                |  - Lắng nghe các yêu cầu từ Docker API.          |
                                |  - Quản lý các đối tượng Docker: Images,         |
                                |    Containers, Networks, Volumes.                |
                                |  - Tương tác với Kernel của Host OS để tạo       |
                                |    và quản lý sự cô lập của containers.          |
                                +--------------------------------------------------+
```

- **Docker Daemon (`dockerd`)**:
  - Là một service (dịch vụ) chạy ngầm liên tục trên máy chủ (host machine).
  - "Bộ não" 🧠 hay "trái tim" của Docker, chịu trách nhiệm thực hiện các công việc nặng nhọc.
  - Lắng nghe các yêu cầu từ Docker API (thường qua một Unix socket, hoặc network interface).
  - Quản lý vòng đời của các đối tượng Docker:
    - Build images từ Dockerfiles.
    - Tải (pull) images từ registries.
    - Lưu trữ (push) images lên registries.
    - Tạo, chạy, dừng, xóa containers.
    - Quản lý networks cho containers giao tiếp.
    - Quản lý volumes cho lưu trữ dữ liệu bền bỉ.
- **REST API**:
  - Một giao diện (interface) chuẩn hóa mà các chương trình (như Docker CLI) có thể sử dụng để "nói chuyện" và ra lệnh cho Docker Daemon.
  - Cho phép tự động hóa và tích hợp Docker với các công cụ khác.
- **Docker CLI (`docker`)**:
  - Công cụ dòng lệnh (Command Line Interface) chính mà người dùng tương tác với Docker.
  - Khi bạn gõ lệnh `docker run`, `docker ps`, `docker build`, v.v., CLI sẽ dịch lệnh đó thành một yêu cầu API và gửi đến Docker Daemon.
  - Daemon xử lý yêu cầu và CLI hiển thị kết quả cho bạn.
  - CLI có thể giao tiếp với Daemon trên cùng máy hoặc một Daemon từ xa.

### Image

- Là một **template read-only** (chỉ đọc, không thể thay đổi sau khi tạo). Nó giống như một bản thiết kế chi tiết, một khuôn mẫu, hoặc một "snapshot" 📸 của một hệ thống file thu nhỏ, đã được cấu hình sẵn.
- Chứa mọi thứ cần thiết để chạy một ứng dụng:
  - Mã nguồn ứng dụng (hoặc phiên bản đã biên dịch).
  - Một runtime (VD: Node.js, Python interpreter, JRE).
  - Các thư viện hệ thống và ứng dụng.
  - Biến môi trường.
  - File cấu hình mặc định.
  - Metadata (như port nào sẽ được expose, lệnh nào sẽ chạy khi container khởi động).
- Images được xây dựng theo **lớp (layers)**. Mỗi instruction trong `Dockerfile` (sẽ học sau) thường tạo ra một lớp mới, được xếp chồng lên lớp trước đó.

  ```text
  +------------------------------------+  Layer N (VD: Lệnh CMD mặc định)
  |         Default Command            |
  +------------------------------------+
  |        COPY your_app_code          |  Layer N-1 (Mã nguồn ứng dụng của bạn)
  +------------------------------------+
  |        RUN npm install             |  Layer N-2 (Cài đặt dependencies)
  +------------------------------------+
  |        COPY package.json ./        |  Layer N-3
  +------------------------------------+
  |              ...                   |  ...
  +------------------------------------+
  |   FROM node:18-alpine (Base Image) |  Layer 1 (Gồm nhiều lớp con của Node & Alpine)
  +------------------------------------+
  ==> Final Image (read-only)
  ```

- **Lợi ích của layers:**
  - **Tái sử dụng (Reusability)**: Các lớp chung (như base OS, runtime) có thể được chia sẻ giữa nhiều image, tiết kiệm dung lượng disk.
  - **Tối ưu lưu trữ (Storage Efficiency)**: Chỉ phần thay đổi (delta) ở mỗi lớp được lưu trữ. Nếu nhiều image dùng chung một lớp, lớp đó chỉ lưu một lần.
  - **Tốc độ build nhanh hơn (Faster Builds)**: Docker cache lại các lớp không thay đổi. Nếu bạn chỉ thay đổi một lớp ở trên cùng, Docker chỉ cần build lại từ lớp đó, không phải build lại toàn bộ image.
  - **Truyền tải hiệu quả (Efficient Transfers)**: Khi pull hoặc push image, chỉ những lớp chưa có ở local/remote mới được truyền đi.

### Container

- Là một **phiên bản chạy (runnable instance)** của một Image. Giống như một đối tượng (object) được tạo ra từ một lớp (class) trong lập trình hướng đối tượng.
- Khi bạn "chạy" một Image (bằng lệnh `docker run`), Docker Engine sẽ tạo ra một Container từ Image đó.
- Bạn có thể tạo, khởi động, dừng, di chuyển, và xóa Containers.
- Mỗi Container là một môi trường **isolated** (cô lập) và **ephemeral** (tạm thời, trừ khi dùng volumes):
  - Nó có hệ thống file riêng (được tạo từ các lớp của image, cộng thêm một lớp "writable" trên cùng để container có thể thay đổi).
  - Có namespace process riêng (không thấy process của host hay container khác).
  - Có network interface riêng (IP address riêng trong Docker network).
  - Cô lập với các Containers khác và với máy chủ (host machine).
  - Tuy nhiên, tất cả Containers trên cùng một host **chia sẻ kernel của Host OS**. Đây là điểm khác biệt chính với VM.
- **Trạng thái:** Một container có thể ở các trạng thái khác nhau: created, running, paused, exited, dead.

```text
+-----------------------+         +-----------------------+
|     Image: my_app     |         |     Image: database   |
|  (Template Read-Only) |         |  (Template Read-Only) |
|  (Layers: OS, Runtime,|         |  (Layers: OS, DB Eng, |
|   Libs, App Code)     |         |   Config)             |
+-----------------------+         +-----------------------+
          |                                  |
          | .------------ `docker run` ------------. |
          V                                  V
+--------------------------------+  +--------------------------------+
|  Container A (my_app_instance1)|  | Container B (db_instance1)     |
|  (Image Layers + Writable Layer)|  | (Image Layers + Writable Layer)|
|  - Own Filesystem view         |  |  - Own Filesystem view         |
|  - Own Process space           |  |  - Own Process space           |
|  - Own Network Interface       |  |  - Own Network Interface       |
+--------------------------------+  +--------------------------------+

Trên cùng một Host Machine (chia sẻ Kernel của Host OS)
```

### Dockerfile

- Là một **file text** đơn giản, không có phần mở rộng (nhưng theo quy ước, tên là `Dockerfile`).
- Chứa một chuỗi các **instructions** (chỉ dẫn, lệnh) mà Docker Engine sẽ đọc và thực thi tuần tự để tự động **build** (xây dựng) một Docker Image.
- Giống như một "kịch bản", "công thức nấu ăn" hoặc "bản vẽ kỹ thuật" để tạo ra Image.
- Mỗi instruction trong Dockerfile thường tạo ra một layer mới trong image.
- **Luồng làm việc:**
  `Dockerfile` --(Input cho lệnh `docker build . -t my_image_name`)--> `Image` 🖼️

### Registry (Docker Hub)

- Là một **kho lưu trữ (repository)** tập trung và là hệ thống phân phối cho các Docker Images.
- Cho phép bạn lưu trữ (push), quản lý, tìm kiếm và chia sẻ (pull) Images.
- **Docker Hub**:
  - Là registry **công cộng (public)** lớn nhất và mặc định của Docker. Được host bởi Docker, Inc.
  - Chứa hàng ngàn Images được tạo sẵn bởi cộng đồng và các nhà cung cấp phần mềm (ví dụ: `ubuntu`, `nginx`, `python`, `mysql`, `node`).
  - Bạn có thể tạo tài khoản miễn phí và push (đẩy) Image của mình lên Docker Hub dưới dạng public (mọi người thấy) hoặc private (chỉ bạn hoặc team thấy, có giới hạn ở gói miễn phí).
- **Private Registries**:
  - Ngoài Docker Hub, bạn cũng có thể tự host registry riêng của mình (ví dụ dùng Docker Registry image, Harbor) để tăng cường bảo mật và kiểm soát.
  - Các nhà cung cấp cloud lớn cũng cung cấp dịch vụ private registry:
    - Amazon ECR (Elastic Container Registry)
    - Google GCR (Google Container Registry) / Artifact Registry
    - Azure ACR (Azure Container Registry)
    - GitHub Container Registry
- **Các lệnh cơ bản liên quan đến Registry:**

  - `docker login [SERVER_ADDRESS]`: Đăng nhập vào một registry. Mặc định là Docker Hub.
  - `docker pull <image_name>:<tag>`: Tải (download) một Image từ Registry về máy local.

    - _Ví dụ:_ `docker pull ubuntu:22.04`

    ```text
    [Local Machine] <--- (docker pull ubuntu:22.04) --- [☁️ Docker Hub / Other Registry]
    ```

  - `docker push <username>/<image_name>:<tag>`: Đẩy (upload) một Image từ máy local của bạn lên Registry (sau khi đã `docker tag` image đúng cách).

    - _Ví dụ:_ `docker push mydockerhubuser/my-custom-app:1.0`

    ```text
    [Local Machine] --- (docker push myuser/myimage:v1) ---> [☁️ Docker Hub / Other Registry]
    ```

  - `docker search <keyword>`: Tìm kiếm image trên Docker Hub.

  ```text
                             +----------------------------+
                             | Docker Hub / Private Registry|
                             | (e.g., ECR, GCR, Harbor)   |
                             +-----------┬----------------+
                                         |
                      docker pull <image>|  docker push <your_repo/image>
                                         |
                   ┌─────────────────────┴─────────────────────┐
                   │                                           │
                   ▼                                           ▲
      +---------------------------+               +---------------------------+
      |      Local Machine 1      |               |      Local Machine 2      |
      | (Dev Laptop, CI Server)   |               | (Production Server, Staging)|
      +---------------------------+               +---------------------------+
  ```

## 4. ⚙️ Docker CLI Cơ Bản

Cú pháp chung: `docker [OPTIONS] COMMAND [ARGUMENTS...]`
Để xem tất cả các lệnh: `docker --help` hoặc `docker COMMAND --help` (ví dụ `docker run --help`).

### Quản lý Images

- `docker images` hoặc `docker image ls`: Liệt kê tất cả images có trên local machine.
  - `docker images -q`: Chỉ hiển thị Image ID.
- `docker pull <image_name>:<tag>`: Tải image từ registry (mặc định là Docker Hub).
  - `<tag>` chỉ định phiên bản. Nếu không có tag, mặc định là `:latest`.
  - Ví dụ: `docker pull nginx:latest` (phiên bản Nginx mới nhất)
  - Ví dụ: `docker pull ubuntu:20.04` (Ubuntu phiên bản 20.04)
- `docker rmi <image_id_or_name:tag>`: Xóa một hoặc nhiều image khỏi local machine.
  - Image phải không được sử dụng bởi bất kỳ container nào (kể cả container đã dừng).
  - `docker rmi -f <image_id>`: Force remove image (xóa kể cả khi có container đang dùng – không khuyến khích).
  - `docker rmi $(docker images -q -f dangling=true)`: Xóa các image "dangling" (image không có tag và không được container nào tham chiếu, thường là image trung gian sau khi build).
- `docker build -t <image_name>:<tag> <path_to_dockerfile_directory>`: Build một image từ Dockerfile.
  - `-t`: Tag image với tên và phiên bản (VD: `myapp:1.0`, `yourusername/myapp:latest`).
  - `.` (dấu chấm): Chỉ định thư mục hiện tại là "build context" (nơi chứa Dockerfile và các file cần COPY vào image).
  - Ví dụ: `docker build -t my-custom-app:v1.0 .`
- `docker history <image_name:tag>`: Hiển thị các layer và lịch sử build của image.
- `docker inspect <image_name:tag_or_id>`: Hiển thị thông tin chi tiết (JSON) về image.
- `docker tag <source_image_id_or_name:tag> <target_image_name:tag>`: Gắn thêm một tag cho image. Thường dùng để chuẩn bị push lên registry (VD: `docker tag myapp:1.0 myusername/myapp:1.0`).

### Quản lý Containers

- `docker run [OPTIONS] <image_name>:<tag> [COMMAND] [ARG...]`: Tạo và chạy một container mới từ một image. Nếu image chưa có ở local, Docker sẽ tự động `pull` về.
  - `docker run hello-world`: Một ví dụ đơn giản để kiểm tra Docker đã cài đặt đúng chưa.
  - **Common Options:**
    - `-d` (detached): Chạy container ở background và in ra Container ID.
    - `-p <host_port>:<container_port>` (port mapping): Ánh xạ port của host tới port của container.
      - Ví dụ: `-p 8080:80` (truy cập `localhost:8080` trên host sẽ được chuyển tới port `80` của container).
    - `--name <container_name>`: Đặt tên cho container để dễ quản lý. Nếu không đặt, Docker sẽ tự gán một tên ngẫu nhiên.
    - `-it` (interactive + TTY): Chạy container ở chế độ tương tác, kết nối terminal của bạn với STDIN/STDOUT/STDERR của container. Thường dùng để chạy shell.
      - `-i`: Giữ STDIN mở ngay cả khi không attach.
      - `-t`: Cấp một pseudo-TTY (terminal giả).
    - `--rm`: Tự động xóa container khi nó dừng (exit). Rất hữu ích cho các tác vụ chạy một lần.
    - `-v <host_path>:<container_path>` (volume mapping): Mount một thư mục/file từ host vào container. Sẽ học kỹ hơn.
    - `-e <KEY>=<VALUE>` (environment variable): Thiết lập biến môi trường cho container.
    - `--network <network_name>`: Kết nối container vào một network cụ thể.
  - **Ví dụ:**
    - `docker run -d -p 8080:80 --name my_web_server nginx`
    - `docker run -it --rm ubuntu bash` (Mở shell bash trong container Ubuntu, container sẽ bị xóa khi thoát bash)
- `docker ps`: Liệt kê các container đang chạy.
  - `docker ps -a`: Liệt kê tất cả container (cả đang chạy và đã dừng).
  - `docker ps -q`: Chỉ hiển thị Container ID.
- `docker stop <container_id_or_name>`: Dừng một hoặc nhiều container đang chạy (gửi tín hiệu SIGTERM, rồi SIGKILL sau một thời gian chờ).
- `docker start <container_id_or_name>`: Khởi động lại một hoặc nhiều container đã dừng.
- `docker restart <container_id_or_name>`: Khởi động lại một container đang chạy hoặc đã dừng.
- `docker rm <container_id_or_name>`: Xóa một hoặc nhiều container đã dừng.
  - `docker rm -f <container_id_or_name>`: Xóa container (kể cả đang chạy - force, gửi SIGKILL).
  - `docker container prune`: Xóa tất cả các container đã dừng. Trả lời `y` để xác nhận.
  - `docker rm $(docker ps -aq -f status=exited)`: Xóa tất cả các container đã exited.

### Tương tác với Container

- `docker logs <container_id_or_name>`: Xem logs (STDOUT/STDERR) của một container.
  - `docker logs -f <container_id_or_name>`: Theo dõi logs (follow mode - hiển thị log mới khi chúng được tạo ra).
  - `docker logs --tail 50 <container_id_or_name>`: Xem 50 dòng log cuối cùng.
- `docker exec [OPTIONS] <container_id_or_name> <command>`: Chạy một lệnh bên trong một container **đang chạy**.
  - `-it`: Thường dùng với `exec` để có một shell tương tác.
  - Ví dụ: `docker exec -it my_web_server bash` (mở shell `bash` trong container `my_web_server`).
  - Ví dụ: `docker exec my_db_container psql -U user -d dbname -c "SELECT * FROM users;"` (chạy lệnh psql trong container DB).
- `docker cp <host_path> <container_id_or_name>:<container_path>`: Copy file/folder từ host vào container.
  - Ví dụ: `docker cp ./config.json my_app_container:/app/config.json`
- `docker cp <container_id_or_name>:<container_path> <host_path>`: Copy file/folder từ container ra host.
  - Ví dụ: `docker cp my_log_container:/app/logs/error.log ./`
- `docker attach <container_id_or_name>`: Kết nối STDIN, STDOUT, STDERR của terminal hiện tại với một container đang chạy. **Lưu ý:** Nếu thoát khỏi `attach` (Ctrl+C), container có thể sẽ dừng nếu nó là process chính. Thường `docker exec` an toàn hơn cho tương tác.

### Xem thông tin và dọn dẹp

- `docker inspect <container_id_or_name_or_image_id>`: Hiển thị thông tin chi tiết (dưới dạng JSON) về một container, image, network, volume, ...
- `docker top <container_id_or_name>`: Hiển thị các tiến trình đang chạy bên trong container.
- `docker stats [container_id_or_name...]`: Hiển thị thông tin sử dụng tài nguyên (CPU, RAM, Network I/O, Disk I/O) của các container đang chạy, cập nhật liên tục.
- **Dọn dẹp tài nguyên Docker không sử dụng:**
  - `docker system df`: Hiển thị dung lượng disk Docker đang sử dụng.
  - `docker system prune`: Xóa tất cả container đã dừng, network không sử dụng, image dangling, và build cache.
    - `docker system prune -a`: Xóa mạnh hơn, bao gồm cả images không được tag và không được container nào sử dụng (kể cả container đã dừng).
    - `docker system prune --volumes`: Xóa cả volumes không được sử dụng (cẩn thận, có thể mất dữ liệu).
  - `docker image prune`: Xóa image dangling.
    - `docker image prune -a`: Xóa tất cả image không được sử dụng bởi ít nhất một container.
  - `docker container prune`: Xóa tất cả container đã dừng.
  - `docker volume prune`: Xóa tất cả local volume không được sử dụng bởi ít nhất một container.
  - `docker network prune`: Xóa tất cả network không được sử dụng bởi ít nhất một container.

## 5. 📝 Dockerfile: Công Thức Tạo Image

`Dockerfile` là file text không có đuôi, mặc định tên là `Dockerfile`. Nó chứa các chỉ thị (instructions) để Docker tự động build một image.

### Các chỉ thị (Instructions) phổ biến

Mỗi chỉ thị thường tạo một layer mới trong image.

1. **`FROM <image>:<tag>` hoặc `FROM <image>@<digest>`**

   - **Mục đích:** Chỉ định base image (image nền) mà image của bạn sẽ được xây dựng dựa trên đó.
   - **Lưu ý:** _Luôn là instruction đầu tiên trong Dockerfile_ (trừ trường hợp có `ARG` trước `FROM`).
   - Nên dùng tag cụ thể (VD: `ubuntu:22.04`) thay vì `latest` để đảm bảo tính tái lập (reproducibility). Dùng digest (`sha256:...`) cho độ tin cậy cao nhất.
   - Ví dụ: `FROM ubuntu:22.04`, `FROM node:18-alpine`, `FROM mcr.microsoft.com/dotnet/sdk:6.0`

2. **`LABEL <key>=<value> [<key2>=<value2> ...]`**

   - **Mục đích:** Thêm metadata vào image dưới dạng cặp key-value (VD: `maintainer`, `version`, `description`).
   - Ví dụ: `LABEL maintainer="your.email@example.com" version="1.0" description="My awesome app"`

3. **`ARG <name>[=<default_value>]`**

   - **Mục đích:** Định nghĩa biến chỉ tồn tại trong quá trình build image (`docker build`).
   - Giá trị có thể được truyền vào từ lệnh `docker build --build-arg <name>=<value>`.
   - Nếu `ARG` được khai báo trước `FROM`, nó có thể được dùng trong `FROM`.
   - Ví dụ: `ARG APP_VERSION=1.0.0`
   - Ví dụ:

     ```dockerfile
     ARG NODE_VERSION=18
     FROM node:${NODE_VERSION}-alpine as builder
     ```

4. **`ENV <key>=<value>` hoặc `ENV <key1>=<value1> <key2>=<value2> ...`**

   - **Mục đích:** Thiết lập biến môi trường. Biến này sẽ tồn tại cả trong quá trình build và khi container chạy từ image đó.
   - Giá trị có thể được ghi đè khi chạy container (`docker run -e <key>=<new_value>`).
   - Ví dụ: `ENV NODE_ENV=production`
   - Ví dụ:

     ```dockerfile
     ENV APP_HOME=/usr/src/app \
         PATH=$APP_HOME/node_modules/.bin:$PATH
     ```

5. **`WORKDIR /path/to/workdir`**

   - **Mục đích:** Thiết lập thư mục làm việc (working directory) cho các instruction tiếp theo như `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, `ADD`.
   - Nếu thư mục không tồn tại, nó sẽ được tạo.
   - Nên dùng đường dẫn tuyệt đối.
   - Ví dụ: `WORKDIR /app` (các lệnh sau đó như `COPY . .` sẽ copy vào `/app`)

6. **`COPY [--chown=<user>:<group>] <src_on_host>... <dest_in_image>`**

   - **Mục đích:** Sao chép file hoặc thư mục từ "build context" (thư mục chứa Dockerfile trên host) vào filesystem của image.
   - `<src_on_host>` phải là đường dẫn tương đối so với build context.
   - `<dest_in_image>` có thể là đường dẫn tuyệt đối, hoặc tương đối so với `WORKDIR`.
   - Không hỗ trợ lấy file từ URL hoặc giải nén tự động.
   - `--chown`: Thay đổi owner và group của file/thư mục được copy.
   - Ví dụ: `COPY . .` (sao chép toàn bộ nội dung thư mục build context vào WORKDIR trong image)
   - Ví dụ: `COPY package.json yarn.lock ./`
   - Ví dụ: `COPY --chown=appuser:appgroup app.jar /opt/app/`

7. **`ADD [--chown=<user>:<group>] <src_on_host_or_URL>... <dest_in_image>`**

   - **Mục đích:** Tương tự `COPY`, nhưng có thêm một số "magic":
     - Nếu `<src>` là URL, nó sẽ tải file về và copy vào `<dest>`.
     - Nếu `<src>` là một file nén tar (VD: `.tar.gz`, `.tar.bz2`), nó sẽ tự động giải nén vào `<dest>`.
   - **Khuyến cáo:** Ưu tiên dùng `COPY` trừ khi bạn thực sự cần tính năng tải URL hoặc tự động giải nén của `ADD`, vì `COPY` rõ ràng và dễ đoán hơn.
   - Ví dụ: `ADD https://example.com/config.zip /app/config/` (sẽ tải và giải nén)

8. **`RUN <command>` (shell form) hoặc `RUN ["executable", "param1", "param2"]` (exec form)**

   - **Mục đích:** Thực thi bất kỳ lệnh nào trong một layer mới của image, bên trên image hiện tại. Kết quả của lệnh sẽ được commit vào layer mới.
   - Thường dùng để cài đặt packages, dependencies, biên dịch code, tạo thư mục, thay đổi quyền,...
   - **Shell form:** `RUN apt-get update && apt-get install -y nginx` (chạy trong `/bin/sh -c <command>` hoặc shell được chỉ định bởi `SHELL`).
   - **Exec form:** `RUN ["/bin/bash", "-c", "echo hello"]` (không dùng shell, thực thi trực tiếp).
   - Để giảm số lượng layer, có thể nối nhiều lệnh bằng `&&`.
   - Ví dụ:

     ```dockerfile
     RUN apt-get update && apt-get install -y --no-install-recommends \
             python3 python3-pip \
         && rm -rf /var/lib/apt/lists/*
     ```

   - Ví dụ: `RUN npm install --production`

9. **`EXPOSE <port> [<port>/<protocol>...]`**

   - **Mục đích:** Thông báo cho Docker rằng container sẽ lắng nghe trên các network port được chỉ định khi chạy.
   - Đây chỉ là thông tin metadata, **không tự động publish port ra host**. Bạn vẫn cần dùng cờ `-p` hoặc `-P` với `docker run` để thực sự map port.
   - Protocol mặc định là `tcp`. Có thể chỉ định `udp`.
   - Ví dụ: `EXPOSE 80` (ngầm hiểu là 80/tcp)
   - Ví dụ: `EXPOSE 3000/tcp 5000/udp`

10. **`CMD ["executable","param1","param2"]` (exec form - ưu tiên)**

    - `CMD command param1 param2` (shell form)
    - `CMD ["param1","param2"]` (làm tham số mặc định cho `ENTRYPOINT`)
    - **Mục đích:** Cung cấp lệnh mặc định và/hoặc tham số sẽ được thực thi khi container khởi động từ image này.
    - **Lưu ý:**
      - Chỉ có một `CMD` instruction có hiệu lực trong Dockerfile. Nếu có nhiều `CMD`, chỉ `CMD` cuối cùng sẽ được dùng.
      - Lệnh và tham số trong `CMD` có thể bị **ghi đè** hoàn toàn bởi command và arguments được cung cấp khi chạy `docker run <image> [COMMAND_TO_OVERRIDE_CMD]`.
      - **Exec form** (`["executable", ...]`) là dạng được khuyến khích vì nó rõ ràng và không bị ảnh hưởng bởi shell.
    - Ví dụ (exec form): `CMD ["nginx", "-g", "daemon off;"]`
    - Ví dụ (shell form): `CMD echo "Hello Docker"`
    - Ví dụ (làm param cho ENTRYPOINT):

      ```dockerfile
      ENTRYPOINT ["python", "app.py"]
      CMD ["--port", "8080"]
      ```

11. **`ENTRYPOINT ["executable","param1","param2"]` (exec form - ưu tiên)**

    - `ENTRYPOINT command param1 param2` (shell form)
    - **Mục đích:** Cấu hình container sẽ chạy như một executable. Lệnh này sẽ **luôn được thực thi** khi container khởi động.
    - **Khác biệt với `CMD`:**
      - Các tham số truyền vào `docker run <image> [ARGS_FOR_ENTRYPOINT]` sẽ được **nối vào sau** `ENTRYPOINT` (nếu là exec form).
      - `ENTRYPOINT` khó bị ghi đè hơn `CMD`. Để ghi đè `ENTRYPOINT`, cần dùng `docker run --entrypoint <new_command>`.
    - `CMD` có thể được dùng kết hợp với `ENTRYPOINT` để cung cấp các tham số mặc định cho `ENTRYPOINT`.
    - Ví dụ:

      ```dockerfile
      ENTRYPOINT ["java", "-jar", "/app/my-app.jar"]
      CMD ["--profile=prod"] # Tham số mặc định
      # Khi chạy `docker run my-image --profile=dev`, container sẽ chạy:
      # java -jar /app/my-app.jar --profile=dev
      ```

    - Ví dụ (shell form, ít dùng hơn): `ENTRYPOINT exec top -b` (dùng `exec` để `top` là PID 1)

12. **`VOLUME ["/path/to/volume"]` hoặc `VOLUME /path1 /path2 ...`**

    - **Mục đích:** Tạo một mount point với tên được chỉ định và đánh dấu nó là nơi chứa dữ liệu bền bỉ từ host hoặc từ một volume khác.
    - Khi container chạy, Docker sẽ tự động tạo một anonymous volume và mount vào đường dẫn này nếu không có volume nào khác được mount vào đó bằng `-v` hoặc `--mount` khi `docker run`.
    - Hữu ích để lưu trữ dữ liệu mà bạn không muốn bị mất khi container bị xóa (VD: database files, logs, user uploads).
    - Ví dụ: `VOLUME /var/lib/mysql`, `VOLUME /app/data /app/logs`

13. **`USER <user>[:<group>]` hoặc `USER <UID>[:<GID>]`**

    - **Mục đích:** Thiết lập user name (hoặc UID) và tùy chọn group (hoặc GID) để chạy các lệnh `RUN`, `CMD`, `ENTRYPOINT` tiếp theo, cũng như user mặc định khi container chạy.
    - **Best Practice:** Chạy ứng dụng với user không phải root (non-root user) để tăng cường bảo mật. User này cần được tạo trước (VD: bằng `RUN groupadd ... && useradd ...`).
    - Ví dụ:

      ```dockerfile
      RUN groupadd -r myapp && useradd --no-log-init -r -g myapp myappuser
      USER myappuser
      ```

14. **`ONBUILD <INSTRUCTION>`**

    - **Mục đích:** Thêm một trigger instruction vào image. Instruction này sẽ không thực thi khi image hiện tại được build, mà sẽ thực thi khi một image khác sử dụng image này làm base image (`FROM current_image`).
    - Hữu ích cho việc tạo base images dùng chung mà cần thực hiện một số thao tác trên code của image con (VD: copy source code, chạy build script).
    - Ví dụ (trong một base image `my-node-app-base`):

      ```dockerfile
      ONBUILD COPY . /app/src
      ONBUILD RUN npm install
      ```

      Khi một `Dockerfile` khác có `FROM my-node-app-base`, các lệnh `ONBUILD` này sẽ được thực thi.

15. **`HEALTHCHECK [OPTIONS] CMD <command>` hoặc `HEALTHCHECK NONE`**

    - **Mục đích:** Chỉ định cách Docker kiểm tra xem container có còn "khỏe" (healthy) hay không.
    - Lệnh `<command>` sẽ được chạy bên trong container theo định kỳ. Nếu lệnh trả về exit code 0, container được coi là healthy. Exit code 1 là unhealthy.
    - Options: `--interval=DURATION` (mặc định 30s), `--timeout=DURATION` (mặc định 30s), `--start-period=DURATION` (mặc định 0s), `--retries=N` (mặc định 3).
    - `HEALTHCHECK NONE`: Tắt healthcheck được kế thừa từ base image.
    - Ví dụ:

      ```dockerfile
      HEALTHCHECK --interval=5m --timeout=3s \
        CMD curl -f http://localhost/ || exit 1
      ```

16. **`SHELL ["executable", "parameters"]`**
    - **Mục đích:** Thay đổi shell mặc định được sử dụng cho shell form của các lệnh `RUN`, `CMD`, `ENTRYPOINT` (mặc định là `["/bin/sh", "-c"]` trên Linux, `["cmd", "/S", "/C"]` trên Windows).
    - Ví dụ: `SHELL ["/bin/bash", "-o", "pipefail", "-c"]` (sử dụng bash và bật pipefail)

### Ví dụ Dockerfile đơn giản (Node.js App)

Giả sử bạn có một ứng dụng Node.js đơn giản với cấu trúc:

```text
my-node-app/
├── Dockerfile
├── package.json
├── server.js
└── ... (các file khác)
```

`package.json`:

```json
{
  "name": "my-node-app",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "dependencies": {
    "express": "^4.17.1"
    // ... các dependencies khác
  }
}
```

`Dockerfile`:

```dockerfile
# 1. Chọn base image: một phiên bản Node.js cụ thể, ưu tiên Alpine cho image nhỏ gọn
FROM node:18-alpine

# (Tùy chọn) Thêm labels để cung cấp metadata
LABEL maintainer="your.email@example.com"
LABEL version="1.0"
LABEL description="My Awesome Node.js App"

# 2. Tạo thư mục làm việc bên trong container
# Lệnh WORKDIR sẽ tạo thư mục nếu chưa tồn tại và cd vào đó
WORKDIR /usr/src/app

# 3. Sao chép file package.json (và package-lock.json nếu có) vào thư mục làm việc
# Copy những file này trước để tận dụng Docker layer caching.
# Nếu những file này không đổi, layer này sẽ được cache, tiết kiệm thời gian build `npm install`.
COPY package*.json ./

# 4. Cài đặt các dependencies của ứng dụng
# RUN npm ci --only=production  # 'npm ci' nhanh hơn và an toàn hơn cho build, dùng package-lock.json
                                # '--only=production' để bỏ qua devDependencies nếu là build cho production
RUN npm install
# Nếu không phải production build, có thể chỉ cần: RUN npm install

# 5. Sao chép toàn bộ source code của ứng dụng vào thư mục làm việc
# Copy sau khi npm install để nếu code thay đổi thì không cần chạy lại npm install (nếu package*.json không đổi)
COPY . .

# 6. (Tùy chọn) Thiết lập biến môi trường nếu cần
ENV NODE_ENV=production
ENV PORT=3000

# 7. Thông báo port mà ứng dụng sẽ chạy trên đó (metadata, không tự động publish)
EXPOSE ${PORT}
# Hoặc EXPOSE 3000 nếu không dùng biến PORT

# 8. Lệnh để chạy ứng dụng khi container khởi động
# Dùng exec form của CMD để tránh shell-isms và để process Node.js nhận tín hiệu (PID 1)
CMD [ "node", "server.js" ]
# Hoặc nếu dùng script trong package.json: CMD [ "npm", "start" ]
```

**Để build image này:**

```bash
cd /path/to/my-node-app
docker build -t my-node-app:1.0 .
```

### Thứ tự lệnh và Caching

Docker build image theo từng lớp (layer), mỗi lệnh trong Dockerfile thường tạo ra một lớp. Docker sử dụng cơ chế caching rất thông minh:

- Khi build, Docker kiểm tra xem lớp cho một lệnh cụ thể đã tồn tại trong cache chưa.
- Nếu một lệnh và các file liên quan (ví dụ `COPY` file) không thay đổi so với lần build trước, Docker sẽ sử dụng lại lớp đó từ cache.
- **Ngay khi một lớp thay đổi (cache miss), tất cả các lớp tiếp theo sau đó sẽ được build lại, bất kể chúng có thay đổi hay không.**

Do đó, **thứ tự các lệnh rất quan trọng** để tối ưu hóa thời gian build:

- Đặt các lệnh ít thay đổi lên trên cùng (VD: `FROM`, `LABEL`, cài đặt OS packages).
- Các lệnh liên quan đến dependencies (VD: `COPY package.json`, `RUN npm install`) nên đặt trước các lệnh copy source code (`COPY . .`). Vì `package.json` ít thay đổi hơn toàn bộ source code.
- Source code (`COPY . .`) thường thay đổi nhiều nhất, nên đặt gần cuối.

**Sử dụng `.dockerignore` file:**
Tương tự `.gitignore`, tạo file `.dockerignore` trong build context (cùng cấp với `Dockerfile`) để loại bỏ các file/thư mục không cần thiết ra khỏi build context trước khi nó được gửi tới Docker daemon. Điều này giúp:

- Giảm kích thước build context -> gửi tới daemon nhanh hơn.
- Giảm kích thước image (nếu các file đó vô tình bị `COPY`).
- Tránh cache busting không cần thiết.
  Ví dụ `.dockerignore`:

```text
node_modules
npm-debug.log
.git
.vscode
README.md
*.env
```

## 6. 🛠️ Thực Hành: Dockerize Ứng Dụng PHP "Hello World" với Apache

Mục tiêu: Tạo một `Dockerfile` để phục vụ một trang `index.php` đơn giản bằng web server `Apache` với `PHP`.

1. **Tạo thư mục dự án và file `index.php`:**
   Mở terminal của bạn, tạo một thư mục mới (ví dụ `php-hello-docker`) và `cd` vào đó:

   ```bash
   mkdir php-hello-docker
   cd php-hello-docker
   ```

   Bên trong thư mục `php-hello-docker`, tạo file `index.php` với nội dung sau:

   ```php
   <!-- index.php -->
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <meta charset="UTF-8" />
       <meta name="viewport" content="width=device-width, initial-scale=1.0" />
       <title>Hello PHP Docker!</title>
       <style>
         body {
           font-family: Arial, sans-serif;
           display: flex;
           justify-content: center;
           align-items: center;
           height: 100vh;
           margin: 0;
           background-color: #e6e6fa; /* Lavender */
         }
         .container {
           text-align: center;
           padding: 20px;
           background-color: white;
           border-radius: 10px;
           box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
         }
         h1 {
           color: #483d8b; /* DarkSlateBlue */
         }
         p {
           color: #555;
           font-size: 1.2em;
         }
         .php-info {
           margin-top: 15px;
           padding: 10px;
           background-color: #f0f0f0;
           border-left: 4px solid #483d8b;
         }
         img {
           margin-top: 20px;
           width: 100px;
         }
       </style>
     </head>
     <body>
       <div class="container">
         <h1>Hello from PHP inside Docker! 🐘</h1>
         <p>This is my first Dockerized PHP application.</p>
         <div class="php-info">
           <?php
             echo "PHP Version: " . phpversion();
           ?>
         </div>
         <img
           src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png"
           alt="Docker Logo"
         />
       </div>
     </body>
   </html>
   ```

2. **Tạo file `Dockerfile`:**
   Trong cùng thư mục `php-hello-docker`, tạo file `Dockerfile` (không có phần mở rộng) với nội dung sau:

   ```dockerfile
   # Bước 1: Sử dụng image PHP chính thức từ Docker Hub với Apache.
   # Ví dụ: php:8.3-apache (bạn có thể chọn phiên bản PHP khác nếu muốn)
   FROM php:8.3-apache

   # (Tùy chọn) Thêm thông tin về người tạo image
   LABEL maintainer="yourname@example.com"

   # Bước 2: Thiết lập thư mục làm việc (không bắt buộc cho ví dụ này vì Apache đã có mặc định)
   # WORKDIR /var/www/html
   # Image php:apache mặc định sử dụng /var/www/html làm DocumentRoot.

   # Bước 3: Sao chép file index.php tùy chỉnh của chúng ta từ build context
   # vào thư mục phục vụ web của Apache bên trong image.
   # '.' (dấu chấm đầu tiên) là thư mục hiện tại (build context) chứa index.php.
   # '/var/www/html/' là thư mục đích trong container.
   COPY ./index.php /var/www/html/index.php

   # Bước 4: Expose port 80 (Apache mặc định chạy và lắng nghe trên port 80 bên trong container)
   # Đây là metadata, không tự động publish port ra host.
   EXPOSE 80

   # Bước 5: Lệnh mặc định để Apache chạy đã được cấu hình trong base image php:apache.
   # Không cần thêm CMD trừ khi bạn muốn ghi đè hành vi mặc định.
   # CMD ["apache2-foreground"]
   ```

3. **Build Docker image:**
   Đảm bảo bạn đang ở trong thư mục `php-hello-docker` (nơi chứa `index.php` và `Dockerfile`).
   Chạy lệnh sau để build image:

   ```bash
   docker build -t my-first-php-app:1.0 .
   ```

   - `docker build`: Lệnh build image.
   - `-t my-first-php-app:1.0`: Tag image với tên `my-first-php-app` và phiên bản `1.0`.
   - `.` : Chỉ định build context là thư mục hiện tại.

   Kiểm tra image đã được tạo:

   ```bash
   docker images
   ```

   Bạn sẽ thấy `my-first-php-app` với tag `1.0` trong danh sách.

4. **Chạy container từ image vừa build:**

   ```bash
   docker run -d -p 8080:80 --name web_test_php my-first-php-app:1.0
   ```

   - `-d`: Chạy container ở chế độ detached (background).
   - `-p 8080:80`: Map port `8080` của máy host tới port `80` của container (port mà Apache đang lắng nghe).
   - `--name web_test_php`: Đặt tên cho container là `web_test_php` để dễ quản lý.
   - `my-first-php-app:1.0`: Tên image và tag để chạy.

   Kiểm tra container đang chạy:

   ```bash
   docker ps
   ```

   Bạn sẽ thấy container `web_test_php` đang chạy.

5. **Kiểm tra kết quả:**
   Mở trình duyệt web (Chrome, Firefox,...) và truy cập địa chỉ `http://localhost:8080`.
   Bạn sẽ thấy trang "Hello from PHP inside Docker!" cùng với phiên bản PHP đang chạy và logo Docker.

6. **Xem logs của container (tùy chọn):**

   ```bash
   docker logs web_test_php
   ```

   Bạn sẽ thấy logs access của Apache.

7. **Dọn dẹp:**
   Sau khi hoàn thành, bạn có thể dừng và xóa container:

   ```bash
   docker stop web_test_php
   docker rm web_test_php
   ```

   Nếu muốn xóa cả image đã build:

   ```bash
   # docker rmi my-first-php-app:1.0
   ```

Chúc mừng! Bạn đã Dockerize thành công ứng dụng PHP đơn giản đầu tiên của mình.

**Lưu ý thêm:**

- **Nginx + PHP-FPM:** Nếu bạn muốn sử dụng Nginx thay vì Apache cho PHP, `Dockerfile` sẽ phức tạp hơn một chút. Bạn sẽ cần:
  - Một base image có Nginx (ví dụ `nginx:alpine`).
  - Cài đặt PHP-FPM vào image đó.
  - Cấu hình Nginx để chuyển các request `.php` tới PHP-FPM.
  - Sao chép code PHP của bạn.
  - Quản lý cả hai tiến trình (Nginx và PHP-FPM) trong container (thường dùng một process manager như `supervisor`).
    Đây là một bước nâng cao hơn, có thể phù hợp cho một phần thực hành khác hoặc phần mở rộng.
- **Phiên bản PHP:** Bạn có thể dễ dàng thay đổi phiên bản PHP bằng cách chọn tag khác cho image `php:apache` (ví dụ: `php:8.2-apache`, `php:8.1-apache`, etc.).

## 7. 🏋️ Bài Tập Nâng Cao: Dockerize Ứng Dụng PHP Động với Cấu Hình Môi Trường

**Đề bài:** Dockerize một ứng dụng PHP đơn giản có khả năng tùy chỉnh hiển thị thông qua biến môi trường và (tùy chọn) ghi lại số lượt truy cập

**Mục tiêu học tập của bài tập này:**

- Hiểu rõ hơn về việc Dockerize một ứng dụng web động (PHP).
- Thực hành cách sử dụng biến môi trường để cấu hình ứng dụng một cách linh hoạt từ bên ngoài container.
- (Nâng cao) Làm quen với việc xử lý file và quản lý quyền cơ bản trong container Docker.
- (Nâng cao) Tạo tiền đề để giới thiệu về khái niệm "stateful applications" và sự cần thiết của Docker Volumes để lưu trữ dữ liệu bền vững.
