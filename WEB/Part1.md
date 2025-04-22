# 📘 PHẦN 1: NHẬP MÔN HTML

- [📘 PHẦN 1: NHẬP MÔN HTML](#-phần-1-nhập-môn-html)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu HTML](#-bài-1-giới-thiệu-html)
  - [🧑‍🏫 Bài 2: Các thẻ HTML cơ bản](#-bài-2-các-thẻ-html-cơ-bản)
  - [🧑‍🏫 Bài 3: Bảng và Form trong HTML](#-bài-3-bảng-và-form-trong-html)
  - [🧑‍🏫 Bài 4: Các thẻ HTML5 ngữ nghĩa (Semantic Elements)](#-bài-4-các-thẻ-html5-ngữ-nghĩa-semantic-elements)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Xây dựng trang Hồ sơ cá nhân**](#đề-bài-xây-dựng-trang-hồ-sơ-cá-nhân)
    - [**Yêu cầu:**](#yêu-cầu)
    - [**Kết quả tham khảo:**](#kết-quả-tham-khảo)

## 🎯 Mục tiêu tổng quát

- Hiểu về cấu trúc của một trang web HTML
- Biết cách sử dụng các thẻ HTML cơ bản
- Tạo được trang web tĩnh đầu tiên

---

## 🧑‍🏫 Bài 1: Giới thiệu HTML

**HTML là gì?**

- HTML là viết tắt của HyperText Markup Language
- Là ngôn ngữ đánh dấu tiêu chuẩn để tạo các trang web
- HTML mô tả cấu trúc của một trang web bằng các thẻ (tags)
- Các trình duyệt không hiển thị các thẻ HTML nhưng sử dụng chúng để render nội dung trang web

**Cấu trúc cơ bản của trang HTML:**

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Tiêu đề trang</title>
  </head>
  <body>
    <h1>Đây là tiêu đề</h1>
    <p>Đây là đoạn văn bản.</p>
  </body>
</html>
```

**Giải thích:**

- `<!DOCTYPE html>`: Khai báo loại tài liệu HTML5
- `<html>`: Thẻ gốc của một trang HTML
- `<head>`: Chứa các meta thông tin, CSS, JavaScript
- `<title>`: Xác định tiêu đề của trang web
- `<body>`: Chứa nội dung hiển thị của trang web
- `<h1>`: Tiêu đề cấp 1
- `<p>`: Đoạn văn bản

---

## 🧑‍🏫 Bài 2: Các thẻ HTML cơ bản

**Thẻ tiêu đề:**

```html
<h1>Tiêu đề cấp 1</h1>
<h2>Tiêu đề cấp 2</h2>
<h3>Tiêu đề cấp 3</h3>
<h4>Tiêu đề cấp 4</h4>
<h5>Tiêu đề cấp 5</h5>
<h6>Tiêu đề cấp 6</h6>
```

**Thẻ định dạng văn bản:**

```html
<p>Đây là một đoạn văn bản.</p>
<b>Văn bản in đậm</b>
<i>Văn bản in nghiêng</i>
<u>Văn bản gạch chân</u>
<strong>Văn bản nhấn mạnh</strong>
<em>Văn bản nhấn mạnh (thường hiển thị nghiêng)</em>
<mark>Văn bản được đánh dấu</mark>
<small>Văn bản nhỏ hơn</small>
<del>Văn bản bị gạch ngang</del>
<sub>Văn bản chỉ số dưới</sub>
<sup>Văn bản chỉ số trên</sup>
```

**Thẻ list (danh sách):**

```html
<!-- Danh sách có thứ tự -->
<ol>
  <li>Mục thứ nhất</li>
  <li>Mục thứ hai</li>
  <li>Mục thứ ba</li>
</ol>

<!-- Danh sách không thứ tự -->
<ul>
  <li>Mục đầu tiên</li>
  <li>Mục thứ hai</li>
  <li>Mục thứ ba</li>
</ul>

<!-- Danh sách mô tả -->
<dl>
  <dt>HTML</dt>
  <dd>HyperText Markup Language</dd>
  <dt>CSS</dt>
  <dd>Cascading Style Sheets</dd>
</dl>
```

**Thẻ liên kết và hình ảnh:**

```html
<!-- Liên kết -->
<a href="https://www.google.com">Truy cập Google</a>
<a href="trang2.html">Đi đến trang 2</a>
<a href="#section1">Đi đến mục 1 trong trang</a>

<!-- Hình ảnh -->
<img src="image.jpg" alt="Mô tả hình ảnh" width="300" height="200" />
```

---

## 🧑‍🏫 Bài 3: Bảng và Form trong HTML

**Bảng (Tables):**

```html
<table border="1">
  <thead>
    <tr>
      <th>STT</th>
      <th>Tên</th>
      <th>Tuổi</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>Nguyễn Văn A</td>
      <td>20</td>
    </tr>
    <tr>
      <td>2</td>
      <td>Trần Thị B</td>
      <td>22</td>
    </tr>
  </tbody>
</table>
```

**Form (Biểu mẫu):**

```html
<form action="/submit-form" method="post">
  <div>
    <label for="name">Họ tên:</label>
    <input type="text" id="name" name="name" required />
  </div>

  <div>
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required />
  </div>

  <div>
    <label for="password">Mật khẩu:</label>
    <input type="password" id="password" name="password" required />
  </div>

  <div>
    <label>Giới tính:</label>
    <input type="radio" id="male" name="gender" value="male" />
    <label for="male">Nam</label>
    <input type="radio" id="female" name="gender" value="female" />
    <label for="female">Nữ</label>
  </div>

  <div>
    <label>Sở thích:</label>
    <input type="checkbox" id="reading" name="hobby" value="reading" />
    <label for="reading">Đọc sách</label>
    <input type="checkbox" id="sports" name="hobby" value="sports" />
    <label for="sports">Thể thao</label>
  </div>

  <div>
    <label for="country">Quốc gia:</label>
    <select id="country" name="country">
      <option value="">Chọn quốc gia</option>
      <option value="vn">Việt Nam</option>
      <option value="us">Hoa Kỳ</option>
      <option value="uk">Anh</option>
    </select>
  </div>

  <div>
    <label for="message">Tin nhắn:</label>
    <textarea id="message" name="message" rows="4" cols="30"></textarea>
  </div>

  <div>
    <button type="submit">Gửi</button>
    <button type="reset">Xóa</button>
  </div>
</form>
```

---

## 🧑‍🏫 Bài 4: Các thẻ HTML5 ngữ nghĩa (Semantic Elements)

HTML5 giới thiệu các thẻ ngữ nghĩa giúp tổ chức và mô tả rõ ràng hơn cấu trúc trang web:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Trang web với HTML5 Semantic</title>
  </head>
  <body>
    <header>
      <h1>Tên Website</h1>
      <nav>
        <ul>
          <li><a href="#home">Trang chủ</a></li>
          <li><a href="#about">Giới thiệu</a></li>
          <li><a href="#services">Dịch vụ</a></li>
          <li><a href="#contact">Liên hệ</a></li>
        </ul>
      </nav>
    </header>

    <main>
      <section id="home">
        <h2>Trang chủ</h2>
        <p>Nội dung trang chủ...</p>
      </section>

      <section id="about">
        <h2>Giới thiệu</h2>
        <p>Nội dung giới thiệu...</p>
      </section>

      <section id="services">
        <h2>Dịch vụ</h2>
        <article>
          <h3>Dịch vụ 1</h3>
          <p>Mô tả dịch vụ 1...</p>
        </article>
        <article>
          <h3>Dịch vụ 2</h3>
          <p>Mô tả dịch vụ 2...</p>
        </article>
      </section>

      <section id="contact">
        <h2>Liên hệ</h2>
        <form>
          <!-- Form elements -->
        </form>
      </section>

      <aside>
        <h3>Nội dung phụ</h3>
        <p>Thông tin bổ sung...</p>
      </aside>
    </main>

    <footer>
      <p>&copy; 2023 Tên Website. All rights reserved.</p>
    </footer>
  </body>
</html>
```

**Các thẻ ngữ nghĩa trong HTML5:**

- `<header>`: Định nghĩa phần đầu của trang web hoặc một section
- `<nav>`: Định nghĩa khu vực chứa các liên kết điều hướng
- `<main>`: Xác định nội dung chính của trang
- `<section>`: Định nghĩa một phần trong tài liệu
- `<article>`: Xác định một nội dung độc lập, tự chứa
- `<aside>`: Định nghĩa nội dung bên cạnh nội dung chính (như sidebar)
- `<footer>`: Định nghĩa phần chân của trang web hoặc một section
- `<figure>`: Chỉ định nội dung tự chứa như hình minh họa, biểu đồ, ảnh, v.v.
- `<figcaption>`: Định nghĩa chú thích cho thẻ figure
- `<time>`: Định nghĩa ngày/giờ

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Xây dựng trang Hồ sơ cá nhân**

Tạo một trang web giới thiệu bản thân với đầy đủ các phần sau:

- Header: Tên và ảnh đại diện
- Phần giới thiệu: Thông tin cá nhân, học vấn
- Phần kỹ năng: Liệt kê các kỹ năng cùng với mức độ thành thạo
- Phần dự án: Giới thiệu các dự án đã làm
- Phần liên hệ: Form để người khác có thể gửi tin nhắn
- Footer: Thông tin bản quyền, liên kết mạng xã hội

### **Yêu cầu:**

- Sử dụng HTML5 semantic elements
- Tạo bảng hiển thị thông tin học vấn
- Tạo form liên hệ với các trường cần thiết
- Thêm hình ảnh và liên kết

### **Kết quả tham khảo:**

```text
Trang Hồ sơ cá nhân hoàn chỉnh với các phần:
- Header có ảnh đại diện và tên cá nhân
- Thông tin cá nhân và học vấn
- Danh sách kỹ năng và dự án
- Form liên hệ
- Footer với thông tin liên lạc
```

---

[⬅️ Trở lại: DSA/Part5.md](../DSA/Part5.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: WEB/Part2.md](../WEB/Part2.md)
