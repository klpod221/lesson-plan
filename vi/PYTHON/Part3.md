# 🌐 PHẦN 3: NHẬP MÔN PHÁT TRIỂN WEB VỚI FLASK

## 🎯 Mục tiêu tổng quát

- Hiểu được các khái niệm cơ bản của web: HTTP, Client-Server, Request-Response.
- Xây dựng được một trang web động đơn giản bằng Flask.
- Biết cách sử dụng routing để tạo các trang khác nhau.
- Sử dụng template engine Jinja2 để hiển thị dữ liệu lên HTML.
- Xử lý được dữ liệu người dùng gửi lên từ các form HTML.
- Tổ chức một dự án Flask theo cấu trúc chuẩn.
- Chuyển đổi ứng dụng dòng lệnh ở Phần 2 thành một ứng dụng web hoàn chỉnh.

## 🧑‍🏫 Bài 1: Giới thiệu Web và Flask

### Mô hình Client-Server

Web hoạt động dựa trên mô hình Client-Server.

- **Client**: Trình duyệt web của bạn (Chrome, Firefox,...). Nó gửi đi các **Request** (yêu cầu) để lấy thông tin.
- **Server**: Máy tính chứa code ứng dụng web của bạn (Flask app). Nó lắng nghe các request, xử lý chúng và trả về các **Response** (phản hồi), thường là mã HTML, CSS, JavaScript.

Sơ đồ mô hình:

```text
+----------------+                           +-----------------+
|                |      1. HTTP Request      |                 |
|     Client     | ------------------------> |      Server     |
| (Trình duyệt)  |      (GET /contacts)      | (Flask App)     |
|                |                           |                 |
|                |      2. HTTP Response     |                 |
|                | <------------------------ |                 |
+----------------+      (HTML, CSS,...)      +-----------------+
```

### Flask là gì?

- Flask là một "micro-framework" để phát triển web bằng Python.
- "Micro" không có nghĩa là nó yếu, mà là nó cung cấp các thành phần cốt lõi cần thiết (routing, request handling, templating) và để bạn tự do lựa chọn các công cụ khác (cơ sở dữ liệu, form validation,...).
- Rất phù hợp cho người mới bắt đầu vì sự đơn giản và dễ hiểu.

### Ứng dụng Flask đầu tiên

1. **Cài đặt Flask**: Mở terminal và chạy lệnh:

    ```bash
    pip install Flask
    ```

2. **Tạo file `app.py`**:

    ```python
    # File: app.py
    from flask import Flask

    # Tạo một instance của lớp Flask
    app = Flask(__name__)

    # Định nghĩa một route cho trang chủ ('/')
    @app.route('/')
    def hello_world():
        return '<h1>Hello, World from Flask!</h1>'

    # Định nghĩa một route khác
    @app.route('/about')
    def about_page():
        return 'Đây là trang giới thiệu.'

    # Dòng này để đảm bảo server chỉ chạy khi file này được thực thi trực tiếp
    if __name__ == '__main__':
        app.run(debug=True) # debug=True để server tự khởi động lại khi có thay đổi code
    ```

3. **Chạy ứng dụng**: Mở terminal trong cùng thư mục và chạy:

    ```bash
    python app.py
    ```

4. Mở trình duyệt và truy cập:
    - `http://127.0.0.1:5000` để xem "Hello, World from Flask!".
    - `http://127.0.0.1:5000/about` để xem trang giới thiệu.

## 🧑‍🏫 Bài 2: Routing và Templates

### Routing (Định tuyến)

Routing là cơ chế ánh xạ một URL đến một hàm Python cụ thể.

```python
from flask import Flask

app = Flask(__name__)

# Route tĩnh
@app.route('/')
def index():
    return "Trang chủ"

# Route động: Lấy giá trị từ URL
@app.route('/user/<username>')
def show_user_profile(username):
    # 'username' sẽ là bất cứ thứ gì người dùng gõ sau '/user/'
    return f'<h1>Xin chào, {username}!</h1>'

# Route động với kiểu dữ liệu
@app.route('/post/<int:post_id>')
def show_post(post_id):
    # Flask sẽ đảm bảo post_id là một số nguyên
    return f'Đây là bài viết số {post_id}'
```

### Templates với Jinja2

Thay vì trả về chuỗi HTML trực tiếp trong Python, chúng ta nên tách HTML ra các file riêng gọi là **template**. Flask sử dụng template engine tên là **Jinja2**.

1. Tạo thư mục `templates` trong cùng cấp với `app.py`.
2. Tạo file `index.html` bên trong thư mục `templates`.

`templates/index.html`:

```html
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>{{ page_title }}</title> <!-- Sử dụng biến từ Python -->
</head>
<body>
    <h1>{{ main_heading }}</h1>
    
    <h3>Danh sách trái cây:</h3>
    <ul>
        <!-- Vòng lặp for trong Jinja2 -->
        {% for fruit in fruits %}
            <li>{{ fruit.capitalize() }}</li>
        {% endfor %}
    </ul>

    <!-- Cấu trúc điều kiện if trong Jinja2 -->
    {% if is_logged_in %}
        <p>Chào mừng bạn đã quay trở lại!</p>
    {% else %}
        <p>Vui lòng đăng nhập.</p>
    {% endif %}
</body>
</html>
```

`app.py`:

```python
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    # Dữ liệu sẽ được truyền vào template
    page_title = "Trang chủ của tôi"
    main_heading = "Chào mừng đến với Flask Templates"
    fruits_list = ["táo", "cam", "chuối", "dâu"]
    user_is_logged_in = True

    # render_template sẽ tìm file trong thư mục 'templates' và truyền dữ liệu vào
    return render_template(
        'index.html',
        page_title=page_title,
        main_heading=main_heading,
        fruits=fruits_list,
        is_logged_in=user_is_logged_in
    )

if __name__ == '__main__':
    app.run(debug=True)
```

## 🧑‍🏫 Bài 3: Xử lý Form và Request

### Phương thức GET và POST

- **GET**: Dùng để *yêu cầu* dữ liệu từ server. Khi bạn gõ một địa chỉ vào trình duyệt, đó là một request GET. Dữ liệu được gửi đi trên URL.
- **POST**: Dùng để *gửi* dữ liệu lên server để tạo hoặc cập nhật tài nguyên. Dữ liệu được gửi đi trong phần thân (body) của request, không hiển thị trên URL.

Sơ đồ so sánh:

```text
       GET Request (/search?q=python)            POST Request (/login)
+----------------------------------------+ +-----------------------------------------+
| URL: /search?q=python                  | | URL: /login                             |
| Method: GET                            | | Method: POST                            |
| Body: (trống)                          | | Body: username=admin&password=123   |
| Mục đích: Lấy thông tin tìm kiếm       | | Mục đích: Gửi thông tin đăng nhập       |
+----------------------------------------+ +-----------------------------------------+
```

### Xử lý dữ liệu từ Form

Flask cung cấp đối tượng `request` để truy cập vào dữ liệu của request hiện tại.

`templates/login.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
</head>
<body>
    <h2>Form Đăng nhập</h2>
    <!-- action="/login" chỉ định URL xử lý form -->
    <!-- method="post" chỉ định phương thức gửi dữ liệu -->
    <form action="/login" method="post">
        <div>
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username">
        </div>
        <div>
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password">
        </div>
        <button type="submit">Đăng nhập</button>
    </form>
</body>
</html>
```

`app.py`:

```python
from flask import Flask, render_template, request

app = Flask(__name__)

# Thêm methods=['GET', 'POST'] để route này có thể nhận cả 2 loại request
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        # Nếu là POST, xử lý dữ liệu form
        # request.form là một dictionary chứa dữ liệu từ form
        username = request.form['username']
        password = request.form['password']

        # (Trong thực tế, bạn sẽ kiểm tra username/password với database)
        if username == 'admin' and password == '12345':
            return f"<h1>Đăng nhập thành công với tên {username}!</h1>"
        else:
            return "<h1>Tên đăng nhập hoặc mật khẩu không đúng.</h1>"
    else:
        # Nếu là GET, chỉ hiển thị form
        return render_template('login.html')

if __name__ == '__main__':
    app.run(debug=True)
```

## 🧑‍🏫 Bài 4: Cấu trúc dự án và File tĩnh

### Tổ chức thư mục dự án

Khi dự án lớn hơn, việc đặt tất cả vào một file `app.py` là không tốt. Ta nên tổ chức theo cấu trúc sau:

```text
contact_app/
│
├── app.py              # File chính khởi tạo và chạy Flask app
├── manager.py          # Class ContactManager (tái sử dụng từ Phần 2)
├── contact.py          # Class Contact (tái sử dụng từ Phần 2)
├── contacts.json       # File dữ liệu
│
├── static/             # Chứa các file tĩnh
│   └── css/
│       └── style.css   # File CSS để trang trí
│
└── templates/          # Chứa các file template HTML
    ├── index.html      # Trang hiển thị danh sách
    ├── add_contact.html # Trang thêm liên hệ mới
    └── layout.html     # (Tùy chọn) Template cơ sở để các trang khác kế thừa
```

### Sử dụng file tĩnh (CSS, JS, Images)

- Các file không thay đổi như CSS, JavaScript, hình ảnh được gọi là file tĩnh.
- Flask tìm các file này trong thư mục `static`.
- Ta dùng hàm `url_for()` trong template để tạo đường dẫn đúng đến file tĩnh.

`static/css/style.css`:

```css
body {
    font-family: sans-serif;
    margin: 2em;
}
table {
    width: 100%;
    border-collapse: collapse;
}
th, td {
    border: 1px solid #ccc;
    padding: 8px;
    text-align: left;
}
th {
    background-color: #f2f2f2;
}
```

`templates/index.html` (thêm dòng link CSS):

```html
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Danh bạ</title>
    <!-- Tạo link đến file CSS bằng url_for() -->
    <link rel="stylesheet" href="{{ url_for('static', filename='css/style.css') }}">
</head>
<body>
    <!-- Nội dung trang -->
</body>
</html>
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng Web App Quản lý Danh bạ

### Mô tả bài toán

Chuyển đổi hoàn toàn ứng dụng Quản lý Danh bạ từ giao diện dòng lệnh (Phần 2) thành một ứng dụng web tương tác bằng Flask. Người dùng sẽ tương tác với ứng dụng thông qua trình duyệt web.

### Yêu cầu

1. **Tổ chức dự án**:
    - Tạo cấu trúc thư mục như đã hướng dẫn ở Bài 4.
    - Tái sử dụng các file `contact.py`, `manager.py` và `contacts.json` từ bài tập Phần 2.

2. **Chức năng chính**:
    - **Trang chủ (`/`)**:
      - Hiển thị danh sách tất cả các liên hệ trong một bảng HTML.
      - Dữ liệu được đọc từ `contacts.json` thông qua `ContactManager`.
      - Mỗi hàng của bảng hiển thị tên, điện thoại, email của liên hệ.
    - **Trang Thêm liên hệ (`/add`)**:
      - Hiển thị một form HTML cho phép người dùng nhập tên, số điện thoại, email.
      - Route này phải xử lý cả `GET` (hiển thị form) và `POST` (nhận dữ liệu).
      - Khi form được gửi đi (POST), ứng dụng phải:
        - Lấy dữ liệu từ form.
        - Tạo một đối tượng `Contact` mới.
        - Dùng `ContactManager` để thêm liên hệ và lưu vào `contacts.json`.
        - **Chuyển hướng (redirect)** người dùng về trang chủ để xem danh sách đã cập nhật.

3. **Giao diện**:
    - Sử dụng một file `style.css` đơn giản để làm cho bảng và form trông dễ nhìn hơn.
    - Liên kết file CSS vào các template HTML bằng `url_for()`.

4. **Luồng dữ liệu**:
    - Tận dụng `render_template` để gửi dữ liệu (danh sách liên hệ) từ Python sang HTML.
    - Tận dụng đối tượng `request` để lấy dữ liệu từ HTML (form) về Python.

### Sơ đồ luồng dữ liệu (Ví dụ: Thêm liên hệ)

```text
(User)           (Browser)              (Flask App)             (Files)
  |                  |                      |                      |
  | Click "Thêm Mới" |                      |                      |
  |----------------->| GET /add             |                      |
  |                  |--------------------->| render_template()    |
  |                  |                      |<---------------------|
  |                  |<-- (Hiển thị form)   |                      |
  |<-----------------|                      |                      |
  |                  |                      |                      |
  | Nhập data, Submit|                      |                      |
  |----------------->| POST /add            |                      |
  |                  |--------------------->| request.form['...']  |
  |                  |                      | manager.add_contact()|
  |                  |                      | manager.save()------>| contacts.json
  |                  |                      | redirect('/')        |
  |                  |<---------------------|                      |
  |                  | GET / (Tải lại)      |                      |
  |                  |--------------------->| manager.load() <-----| contacts.json
  |                  |                      | render_template()    |
  |                  |<--(Hiển thị DS mới)  |                      |
  |<-----------------|                      |                      |
```
