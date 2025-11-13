---
prev:
  text: '⚡ Thuật Toán Ứng Dụng'
  link: '/DSA/Part5'
next:
  text: '🎨 CSS - Định Dạng Trang Web'
  link: '/WEB/Part2'
---

# 📘 PHẦN 1: NHẬP MÔN HTML

## 🎯 Mục tiêu tổng quát

- Hiểu về cấu trúc của một trang web HTML
- Biết cách sử dụng các thẻ HTML cơ bản
- Tạo được trang web tĩnh đầu tiên

## 🧑‍🏫 Bài 1: Giới thiệu HTML

### HTML là gì?

- HTML là viết tắt của HyperText Markup Language
- Là ngôn ngữ đánh dấu tiêu chuẩn để tạo các trang web
- HTML mô tả cấu trúc của một trang web bằng các thẻ (tags)
- Các trình duyệt không hiển thị các thẻ HTML nhưng sử dụng chúng để render nội dung trang web

### Cấu trúc cơ bản của trang HTML

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

Hãy thử tạo một file `index.html` với nội dung trên và mở nó trong trình duyệt hoặc sử dụng extension [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) trong Visual Studio Code để xem kết quả.

### Giải thích

- `<!DOCTYPE html>`: Khai báo loại tài liệu HTML5
- `<html>`: Thẻ gốc của một trang HTML
- `<head>`: Chứa các meta thông tin, CSS, JavaScript
- `<title>`: Xác định tiêu đề của trang web
- `<body>`: Chứa nội dung hiển thị của trang web
- `<h1>`: Tiêu đề cấp 1
- `<p>`: Đoạn văn bản

## 🧑‍🏫 Bài 2: Các thẻ HTML cơ bản

### Thẻ tiêu đề

```html
<h1>Tiêu đề cấp 1</h1>
<h2>Tiêu đề cấp 2</h2>
<h3>Tiêu đề cấp 3</h3>
<h4>Tiêu đề cấp 4</h4>
<h5>Tiêu đề cấp 5</h5>
<h6>Tiêu đề cấp 6</h6>
```

### Thẻ định dạng văn bản

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

### Thẻ list (danh sách)

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

### Thẻ liên kết và hình ảnh

```html
<!-- Liên kết -->
<a href="https://www.google.com">Truy cập Google</a>
<a href="trang2.html">Đi đến trang 2</a>
<a href="#section1">Đi đến mục 1 trong trang</a>

<!-- Hình ảnh -->
<img src="image.jpg" alt="Mô tả hình ảnh" width="300" height="200" />
```

## 🧑‍🏫 Bài 3: Bảng và Form trong HTML

### Bảng (Tables)

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

### Form (Biểu mẫu)

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

## 🧑‍🏫 Bài 4: Các thẻ HTML5 ngữ nghĩa (Semantic Elements)

### Định nghĩa

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

### Các thẻ ngữ nghĩa trong HTML5

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

## 🧑‍🏫 Bài 5: Sử dụng Developer Tools trên trình duyệt

### Giới thiệu về Developer Tools

Developer Tools (DevTools) là một bộ công cụ tích hợp trong các trình duyệt web hiện đại như Chrome, Firefox, Edge, Safari, giúp lập trình viên kiểm tra, gỡ lỗi và tối ưu hóa mã nguồn của trang web.

### Cách mở Developer Tools

- Trên Chrome: Nhấn `F12` hoặc `Ctrl + Shift + I` (Windows/Linux) hoặc `Cmd + Option + I` (Mac)
- Trên Firefox: Nhấn `F12` hoặc `Ctrl + Shift + I` (Windows/Linux) hoặc `Cmd + Option + I` (Mac)
- Trên Edge: Nhấn `F12` hoặc `Ctrl + Shift + I` (Windows/Linux) hoặc `Cmd + Option + I` (Mac)
- Trên Safari: Nhấn `Cmd + Option + I` (Mac)

### Các thành phần chính của Developer Tools

- **Elements**: Kiểm tra và chỉnh sửa HTML và CSS của trang web
- **Console**: Hiển thị các thông báo, lỗi và cho phép thực thi mã JavaScript
- **Network**: Kiểm tra các yêu cầu mạng và hiệu suất tải trang
- **Sources**: Xem và gỡ lỗi mã nguồn JavaScript
- **Performance**: Phân tích hiệu suất và tối ưu hóa trang web
- **Memory**: Kiểm tra và quản lý bộ nhớ
- **Application**: Quản lý dữ liệu ứng dụng như cookies, local storage, session storage
- **Security**: Kiểm tra các vấn đề bảo mật của trang web

### Kiểm tra và chỉnh sửa HTML

- Sử dụng tab **Elements** để xem cấu trúc HTML của trang web
- Nhấp chuột phải vào một phần tử và chọn "Edit as HTML" để chỉnh sửa trực tiếp
- Thay đổi sẽ được áp dụng ngay lập tức trên trang web

### Lợi ích của Developer Tools

- Giúp kiểm tra và gỡ lỗi mã nguồn nhanh chóng
- Tối ưu hóa hiệu suất trang web
- Kiểm tra và chỉnh sửa HTML, CSS, JavaScript trực tiếp
- Phân tích và quản lý các yêu cầu mạng
- Kiểm tra các vấn đề bảo mật

## 🧑‍🏫 Bài 6: Emmet - Công cụ hỗ trợ viết HTML nhanh

### Giới thiệu về Emmet

Emmet là một plugin giúp lập trình viên viết code HTML và CSS nhanh hơn bằng cách sử dụng các cú pháp rút gọn, tương tự như CSS selector (bạn sẽ học trong phần CSS). Emmet giúp bạn tiết kiệm thời gian và công sức khi viết mã.

Bạn có thể đến trang chủ của Emmet để xem ví dụ bằng hình ảnh: [Emmet](https://emmet.io/).

### Cú pháp cơ bản của Emmet

```text
element
element>child
element+sibling
element*n
element.classname
element#id
element[attribute=value]
element{text content}
```

### Ví dụ sử dụng Emmet

| Cú pháp Emmet    | Kết quả HTML                                                                     |
| ---------------- | -------------------------------------------------------------------------------- |
| `div`            | `<div></div>`                                                                    |
| `div>ul>li`      | `<div><ul><li></li></ul></div>`                                                  |
| `div+p+bq`       | `<div></div><p></p><blockquote></blockquote>`                                    |
| `ul>li*5`        | `<ul><li></li><li></li><li></li><li></li><li></li></ul>`                         |
| `div.container`  | `<div class="container"></div>`                                                  |
| `div#header`     | `<div id="header"></div>`                                                        |
| `a[href=#]`      | `<a href="#"></a>`                                                               |
| `p{Hello World}` | `<p>Hello World</p>`                                                             |
| `ul>li.item$*3`  | `<ul><li class="item1"></li><li class="item2"></li><li class="item3"></li></ul>` |

### Emmet cho form

```text
form:get
input:text
input:email
input:password
input:submit
```

Kết quả:

```html
<!-- form:get -->
<form action="" method="get"></form>

<!-- input:text -->
<input type="text" name="" id="" />

<!-- input:email -->
<input type="email" name="" id="" />

<!-- input:password -->
<input type="password" name="" id="" />

<!-- input:submit -->
<input type="submit" value="" />
```

### Lợi ích của Emmet

- Tiết kiệm thời gian khi viết HTML và CSS
- Giảm số lượng phím bấm cần thiết
- Giảm lỗi cú pháp
- Được tích hợp sẵn trong nhiều IDE và text editor phổ biến như VS Code, Sublime Text, Atom, WebStorm...

### Các trình soạn thảo hỗ trợ Emmet

- Visual Studio Code
- Sublime Text
- Atom
- WebStorm
- Notepad++
- và nhiều IDE khác...

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng trang Portfolio (Hồ sơ cá nhân)

### Mô tả bài toán

Tạo một trang web giới thiệu bản thân với đầy đủ các phần sau:

- Header: Tên và ảnh đại diện
- Phần giới thiệu: Thông tin cá nhân, học vấn
- Phần kỹ năng: Liệt kê các kỹ năng cùng với mức độ thành thạo
- Phần dự án: Giới thiệu các dự án đã làm
- Phần liên hệ: Form để người khác có thể gửi tin nhắn
- Footer: Thông tin bản quyền, liên kết mạng xã hội

### Yêu cầu

- Sử dụng HTML5 semantic elements
- Tạo bảng hiển thị thông tin học vấn
- Tạo form liên hệ với các trường cần thiết
- Thêm hình ảnh và liên kết

### Mockup trang web tham khảo

```text
+---------------------------------------------------------+
|                      MY PORTFOLIO                       |
+---------------------------------------------------------+
| [Profile Photo]    John Doe                             |
|                    Web Developer                        |
+---------------------------------------------------------+
|                   ABOUT ME                              |
+---------------------------------------------------------+
| Hello! I'm John, a passionate web developer with        |
| 1 years of experience creating modern web applications. |
|                                                         |
| [Education]                                             |
| +---------------------------------------------------+   |
| | Degree               | Institution      | Year    |   |
| |----------------------|-----------------|----------|   |
| | B.S. Computer Science| ABC University  | 2018     |   |
| | Web Dev Certification| XYZ Institute   | 2019     |   |
| +---------------------------------------------------+   |
+---------------------------------------------------------+
|                   SKILLS                                |
+---------------------------------------------------------+
| Java        [███████████████████████░░] 95%             |
| SQL         [██████████████████████░░░] 90%             |
| HTML        [███████████████████░░░░░░] 85%             |
| CSS         [█████████████████░░░░░░░░] 75%             |
| JavaScript  [███████████████░░░░░░░░░░] 70%             |
+---------------------------------------------------------+
|                   PROJECTS                              |
+---------------------------------------------------------+
| +------------------------+  +------------------------+  |
| | [Project 1 Screenshot] |  | [Project 2 Screenshot] |  |
| | E-Commerce Website     |  | Task Manager App       |  |
| | HTML, CSS, JavaScript  |  | React, Node.js         |  |
| | [View Project] [Code]  |  | [View Project] [Code]  |  |
| +------------------------+  +------------------------+  |
|                                                         |
| +------------------------+  +------------------------+  |
| | [Project 3 Screenshot] |  | [Project 4 Screenshot] |  |
| | Portfolio Website      |  | Weather App            |  |
| | React, CSS             |  | JavaScript, API        |  |
| | [View Project] [Code]  |  | [View Project] [Code]  |  |
| +------------------------+  +------------------------+  |
+---------------------------------------------------------+
|                   CONTACT ME                            |
+---------------------------------------------------------+
| +--------------------------------------------------+    |
| | Name:    [________________________]              |    |
| | Email:   [________________________]              |    |
| | Subject: [________________________]              |    |
| | Message:                                         |    |
| | [                                            ]   |    |
| | [                                            ]   |    |
| |                                                  |    |
| |                             [Submit Message]     |    |
| +--------------------------------------------------+    |
+---------------------------------------------------------+
|                   FOOTER                                |
+---------------------------------------------------------+
| © 2025 John Doe - All Rights Reserved                   |
|                                                         |
| [GitHub] [LinkedIn] [Twitter] [Instagram]               |
+---------------------------------------------------------+
```
