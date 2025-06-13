# ⚙️ PHẦN 8: TỰ ĐỘNG HÓA VÀ LẬP TRÌNH SCRIPTING VỚI PYTHON

- [⚙️ PHẦN 8: TỰ ĐỘNG HÓA VÀ LẬP TRÌNH SCRIPTING VỚI PYTHON](#️-phần-8-tự-động-hóa-và-lập-trình-scripting-với-python)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Thao tác với Hệ thống File](#-bài-1-thao-tác-với-hệ-thống-file)
    - [`pathlib`: Con đường hiện đại để làm việc với file](#pathlib-con-đường-hiện-đại-để-làm-việc-với-file)
    - [`shutil`: Các thao tác file cấp cao](#shutil-các-thao-tác-file-cấp-cao)
  - [🧑‍🏫 Bài 2: Tương tác với các Tiến trình và Web](#-bài-2-tương-tác-với-các-tiến-trình-và-web)
    - [Chạy các chương trình khác với `subprocess`](#chạy-các-chương-trình-khác-với-subprocess)
    - [Tự động hóa Web Scraping với `requests` và `BeautifulSoup`](#tự-động-hóa-web-scraping-với-requests-và-beautifulsoup)
  - [🧑‍🏫 Bài 3: Tự động hóa các Ứng dụng Văn phòng](#-bài-3-tự-động-hóa-các-ứng-dụng-văn-phòng)
    - [Làm việc với file Excel bằng `openpyxl`](#làm-việc-với-file-excel-bằng-openpyxl)
    - [Tự động gửi Email với `smtplib`](#tự-động-gửi-email-với-smtplib)
  - [🧑‍🏫 Bài 4: Tự động hóa Giao diện và Lập lịch](#-bài-4-tự-động-hóa-giao-diện-và-lập-lịch)
    - [Điều khiển Chuột và Bàn phím với `pyautogui`](#điều-khiển-chuột-và-bàn-phím-với-pyautogui)
    - [Lập lịch chạy Script với `schedule`](#lập-lịch-chạy-script-với-schedule)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Script tự động dọn dẹp Thư mục](#-bài-tập-lớn-cuối-phần-script-tự-động-dọn-dẹp-thư-mục)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Sử dụng Python để thao tác với các file và thư mục trên máy tính một cách hiệu quả.
- Viết script để tương tác với các chương trình khác và thu thập thông tin từ web.
- Tự động hóa các tác vụ liên quan đến ứng dụng văn phòng như Excel và Email.
- Có khả năng điều khiển giao diện người dùng (GUI) và lập lịch để các script tự động chạy theo thời gian định sẵn.
- Xây dựng một script tự động hóa hoàn chỉnh để giải quyết một vấn đề thực tế.

---

## 🧑‍🏫 Bài 1: Thao tác với Hệ thống File

### `pathlib`: Con đường hiện đại để làm việc với file

- `pathlib` là thư viện chuẩn của Python 3, cung cấp một cách tiếp cận hướng đối tượng và trực quan để làm việc với các đường dẫn file, bất kể hệ điều hành.

```python
from pathlib import Path

# Tạo một đối tượng Path
p = Path('.') # '.' đại diện cho thư mục hiện tại

# Liệt kê tất cả file và thư mục con
for item in p.iterdir():
    print(item)

# Tạo một đường dẫn mới
data_folder = Path('./data')
# Tạo thư mục nếu nó chưa tồn tại
data_folder.mkdir(exist_ok=True)

# Tạo một đường dẫn file
file_path = data_folder / 'my_file.txt'

# Ghi vào file
file_path.write_text('Hello from pathlib!', encoding='utf-8')

# Đọc từ file
content = file_path.read_text(encoding='utf-8')
print(f"Nội dung file: {content}")

# Lấy các thông tin về file
print(f"Tên file: {file_path.name}")
print(f"Phần mở rộng: {file_path.suffix}")
print(f"Thư mục cha: {file_path.parent}")
```

### `shutil`: Các thao tác file cấp cao

- `shutil` (shell utilities) cung cấp các hàm để sao chép, di chuyển, đổi tên và xóa file/thư mục.

```python
import shutil

# Tạo một file để làm ví dụ
source_file = Path('./source.txt')
source_file.write_text('This is the source file.')

# 1. Sao chép file
dest_file = Path('./destination.txt')
shutil.copy(source_file, dest_file)
print(f"Đã sao chép {source_file} đến {dest_file}")

# 2. Di chuyển/Đổi tên file
new_location = Path('./data/moved_source.txt')
shutil.move(source_file, new_location)
print(f"Đã di chuyển {source_file} đến {new_location}")

# 3. Xóa một cây thư mục (cẩn thận!)
# shutil.rmtree('./data')
# print("Đã xóa thư mục 'data' và toàn bộ nội dung.")
```

---

## 🧑‍🏫 Bài 2: Tương tác với các Tiến trình và Web

### Chạy các chương trình khác với `subprocess`

- `subprocess` cho phép script Python của bạn chạy các lệnh hoặc chương trình khác và tương tác với chúng.

```python
import subprocess

# Chạy một lệnh đơn giản và lấy kết quả (ví dụ trên Linux/macOS)
# Trên Windows, có thể dùng 'dir' thay cho 'ls -l'
try:
    result = subprocess.run(
        ['ls', '-l'], 
        capture_output=True, 
        text=True, 
        check=True
    )
    print("Output:\n", result.stdout)
except FileNotFoundError:
    print("Lệnh 'ls' không tìm thấy. Bạn có đang dùng Windows không?")
except subprocess.CalledProcessError as e:
    print("Lệnh thực thi bị lỗi:", e.stderr)

```

### Tự động hóa Web Scraping với `requests` và `BeautifulSoup`

- Đây là một ứng dụng cực kỳ phổ biến của scripting: tự động thu thập dữ liệu từ các trang web không cung cấp API.

```python
import requests
from bs4 import BeautifulSoup

# 1. Tải nội dung HTML của trang web
url = 'https://news.ycombinator.com'
try:
    response = requests.get(url)
    response.raise_for_status() # Báo lỗi nếu request không thành công

    # 2. Phân tích HTML bằng BeautifulSoup
    soup = BeautifulSoup(response.text, 'html.parser')

    # 3. Trích xuất thông tin (ví dụ: lấy tiêu đề các bài viết)
    print(f"Các tiêu đề bài viết từ {url}:\n")
    # Các thẻ chứa tiêu đề trên Hacker News có class 'titleline'
    headlines = soup.find_all(class_='titleline')
    for i, headline in enumerate(headlines[:10], 1):
        print(f"{i}. {headline.get_text()}")

except requests.exceptions.RequestException as e:
    print(f"Lỗi khi truy cập web: {e}")
```

---

## 🧑‍🏫 Bài 3: Tự động hóa các Ứng dụng Văn phòng

### Làm việc với file Excel bằng `openpyxl`

- Trong khi Pandas (Phần 6) rất mạnh để phân tích, `openpyxl` cho phép bạn kiểm soát chi tiết hơn từng ô, định dạng, và các sheet trong file Excel.
- Cài đặt: `pip install openpyxl`

```python
from openpyxl import Workbook

# Tạo một workbook mới
wb = Workbook()
# Lấy sheet đang hoạt động
ws = wb.active
ws.title = "Báo cáo Doanh thu"

# Ghi dữ liệu vào các ô
ws['A1'] = "Sản phẩm"
ws['B1'] = "Số lượng"
ws['C1'] = "Doanh thu"

data = [
    ('Laptop', 10, 25000),
    ('Bàn phím', 50, 5000),
    ('Chuột', 75, 3750),
]

for row in data:
    ws.append(row)

# Lưu file
wb.save("báo_cáo.xlsx")
print("Đã tạo file báo_cáo.xlsx")
```

### Tự động gửi Email với `smtplib`

- Python có các thư viện chuẩn để gửi email qua giao thức SMTP. Rất hữu ích để gửi thông báo, báo cáo tự động.
- **Lưu ý:** Với các dịch vụ như Gmail, bạn cần bật "Quyền truy cập của ứng dụng kém an toàn" hoặc tạo "Mật khẩu ứng dụng".

```python
import smtplib
from email.message import EmailMessage

# --- Cấu hình ---
EMAIL_ADDRESS = 'your_email@gmail.com'
EMAIL_PASSWORD = 'your_app_password' # Mật khẩu ứng dụng, không phải mật khẩu chính
CONTACTS = ['recipient1@example.com', 'recipient2@example.com']

# --- Tạo nội dung email ---
msg = EmailMessage()
msg['Subject'] = 'Báo cáo tự động hàng ngày'
msg['From'] = EMAIL_ADDRESS
msg['To'] = ', '.join(CONTACTS)
msg.set_content('Đây là báo cáo được gửi tự động từ script Python.')

# --- Gửi email ---
try:
    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
        smtp.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
        smtp.send_message(msg)
    print("Email đã được gửi thành công!")
except Exception as e:
    print(f"Gửi email thất bại: {e}")

```

---

## 🧑‍🏫 Bài 4: Tự động hóa Giao diện và Lập lịch

### Điều khiển Chuột và Bàn phím với `pyautogui`

- Thư viện này cho phép bạn mô phỏng các hành động của người dùng trên giao diện đồ họa (GUI). Rất hữu ích để tự động hóa các ứng dụng không có API.
- Cài đặt: `pip install pyautogui`
- **Cảnh báo**: Script này sẽ chiếm quyền điều khiển máy tính của bạn. Hãy sẵn sàng để dừng nó (di chuột đến góc trên cùng bên trái màn hình).

```python
import pyautogui
import time

# Lấy kích thước màn hình
screenWidth, screenHeight = pyautogui.size()
print(f"Kích thước màn hình: {screenWidth}x{screenHeight}")

# Di chuyển chuột đến tọa độ (100, 100) trong 2 giây
pyautogui.moveTo(100, 100, duration=2)

# Click chuột
pyautogui.click()

# Tự động gõ phím
time.sleep(1) # Chờ 1 giây
pyautogui.write('Hello from PyAutoGUI!', interval=0.1)

# Nhấn phím nóng (ví dụ: Ctrl+A để chọn tất cả)
pyautogui.hotkey('ctrl', 'a')
```

### Lập lịch chạy Script với `schedule`

- Thư viện `schedule` cung cấp một API đơn giản, dễ đọc để lập lịch các tác vụ trong Python.
- Cài đặt: `pip install schedule`

```python
import schedule
import time

def job():
    print("Tôi đang làm việc... Thời gian hiện tại:", time.ctime())

# Lập lịch cho công việc
schedule.every(10).seconds.do(job)
schedule.every().minute.at(":17").do(job) # Chạy vào giây thứ 17 mỗi phút
schedule.every().hour.do(job)
schedule.every().day.at("10:30").do(job)
schedule.every().monday.do(job)

print("Bắt đầu lập lịch. Nhấn Ctrl+C để thoát.")

while True:
    schedule.run_pending()
    time.sleep(1)
```
**Lưu ý:** `schedule` chỉ chạy khi script Python đang hoạt động. Để lập lịch chạy ngay cả khi bạn không mở terminal, bạn cần dùng các công cụ của hệ điều hành như **Cron** (trên Linux/macOS) hoặc **Task Scheduler** (trên Windows).

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Script tự động dọn dẹp Thư mục

### Mô tả bài toán

Thư mục "Downloads" của bạn thường trở nên lộn xộn với đủ loại file: ảnh, tài liệu, file nén, file cài đặt... Bạn cần viết một script Python để tự động sắp xếp các file này vào các thư mục con tương ứng dựa trên phần mở rộng của chúng.

### Yêu cầu

1.  **Thiết lập cấu trúc**:
    - Tạo một thư mục gốc, ví dụ `messy_folder`.
    - Bên trong `messy_folder`, tạo ra một vài file giả lập với các phần mở rộng khác nhau:
      - `image1.jpg`, `photo.png`
      - `document.docx`, `report.pdf`
      - `archive.zip`, `data.rar`
      - `script.py`, `text.txt`

2.  **Viết Script `organizer.py`**:
    - Script sẽ chỉ định `messy_folder` là thư mục nguồn.
    - Script sẽ định nghĩa các danh mục và các phần mở rộng tương ứng, ví dụ:
      ```python
      CATEGORIES = {
          "IMAGES": [".jpg", ".jpeg", ".png", ".gif"],
          "DOCUMENTS": [".pdf", ".docx", ".txt"],
          "ARCHIVES": [".zip", ".rar", ".tar"],
          "SCRIPTS": [".py", ".js"]
      }
      ```
    - Dùng `pathlib` để duyệt qua tất cả các file (không phải thư mục) trong `messy_folder`.
    - Với mỗi file, kiểm tra phần mở rộng của nó (`.suffix`).
    - Dựa vào phần mở rộng, xác định file đó thuộc danh mục nào.
    - Tạo một thư mục con tương ứng với danh mục (ví dụ `messy_folder/IMAGES`) nếu nó chưa tồn tại.
    - Di chuyển file vào thư mục con đó.

3.  **Ghi Log (Tùy chọn nhưng khuyến khích)**:
    - Sau khi di chuyển tất cả các file, script sẽ ghi một file `log.txt` trong `messy_folder`, tóm tắt lại các hành động đã thực hiện. Ví dụ:
      ```
      File Organization Log - [Ngày giờ hiện tại]
      -----------------------------------------
      Moved image1.jpg to IMAGES
      Moved report.pdf to DOCUMENTS
      ...
      Summary: 2 image(s), 1 document(s) moved.
      ```

4.  **Hướng dẫn sử dụng**:
    - Cuối script, có thể in ra một thông báo "Dọn dẹp hoàn tất! Xem log.txt để biết chi tiết."
