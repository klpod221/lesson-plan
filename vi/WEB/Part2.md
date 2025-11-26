---
prev:
  text: '📝 Nhập Môn HTML'
  link: '/vi/WEB/Part1'
next:
  text: '🔄 JavaScript'
  link: '/vi/WEB/Part3'
---

# 📘 PHẦN 2: CSS - ĐỊNH DẠNG TRANG WEB

## 🎯 Mục tiêu tổng quát

- Hiểu về CSS và vai trò của nó trong phát triển web
- Thành thạo các cách áp dụng CSS vào HTML
- Nắm vững các thuộc tính CSS cơ bản và cách sử dụng

## 🧑‍🏫 Bài 1: Giới thiệu CSS

### CSS là gì?

- CSS là viết tắt của Cascading Style Sheets
- Được sử dụng để định dạng và trình bày nội dung HTML
- Giúp phân tách nội dung (HTML) và hình thức trình bày (CSS)
- Cho phép áp dụng nhiều style khác nhau trên cùng một trang web

### Cách thêm CSS vào HTML

1. **Inline CSS**: Sử dụng thuộc tính `style` trực tiếp trên thẻ HTML (không được khuyến khích)

   ```html
   <p style="color: blue; font-size: 16px;">Đây là đoạn văn màu xanh.</p>
   ```

2. **Internal CSS**: Sử dụng thẻ `<style>` trong phần `<head>` (không được khuyến khích cho trang lớn)

   ```html
   <head>
     <style>
       p {
         color: blue;
         font-size: 16px;
       }
     </style>
   </head>
   ```

3. **External CSS**: Tạo file CSS riêng và liên kết vào HTML

   ```html
   <head>
     <link rel="stylesheet" href="styles.css" />
   </head>
   ```

Nội dung file styles.css:

```css
p {
  color: blue;
  font-size: 16px;
}
```

### Ưu và nhược điểm từng loại

| Loại CSS | Ưu điểm                                             | Nhược điểm                                   |
| -------- | --------------------------------------------------- | -------------------------------------------- |
| Inline   | Ưu tiên cao nhất, sẽ ghi đè các thuộc tính css khác | Khó bảo trì, code lặp lại nhiều              |
| Internal | Áp dụng cho một trang, không cần file riêng         | Phải copy khi dùng cho trang khác            |
| External | Dễ bảo trì, tái sử dụng trên nhiều trang            | Trang có thể hiển thị trước khi CSS được tải |

## 🧑‍🏫 Bài 2: CSS Selectors (Bộ chọn)

### Cú pháp CSS

```css
selector {
  property: value;
  property: value;
}
```

### Các loại selector cơ bản

```css
/* Element Selector */
p {
  color: blue;
}

/* Class Selector */
.important {
  font-weight: bold;
}

/* ID Selector */
#header {
  background-color: #f0f0f0;
}

/* Universal Selector */
* {
  margin: 0;
  padding: 0;
}

/* Attribute Selector */
input[type="text"] {
  border: 1px solid gray;
}

/* Pseudo-class Selector */
a:hover {
  color: red;
}

/* Pseudo-element Selector */
p::first-letter {
  font-size: 2em;
}
```

### Selector kết hợp

```css
/* Descendant Selector (con cháu) */
article p {
  font-style: italic;
}

/* Child Selector (con trực tiếp) */
ul > li {
  list-style-type: square;
}

/* Adjacent Sibling Selector (anh em liền kề) */
h2 + p {
  font-weight: bold;
}

/* General Sibling Selector (anh em chung) */
h2 ~ p {
  color: gray;
}

/* Multiple Selectors */
h1,
h2,
h3 {
  text-transform: uppercase;
}
```

### Độ ưu tiên (Specificity) trong CSS

1. `!important` (cao nhất)
2. Inline CSS
3. ID selector
4. Class selector, Attribute selector, Pseudo-class
5. Element selector, Pseudo-element
6. Universal selector (`*`)

```css
/* Ví dụ độ ưu tiên */
p {
  color: blue;
} /* Specificity: 0,0,0,1 */
.intro {
  color: red;
} /* Specificity: 0,0,1,0 */
#first {
  color: green;
} /* Specificity: 0,1,0,0 */
p.intro {
  color: purple;
} /* Specificity: 0,0,1,1 */

/* !important ghi đè mọi quy tắc khác */
p {
  color: yellow !important;
} /* Cao nhất */
```

### Box Model

- Đây là mô hình hộp trong CSS mô tả không gian chiếm bởi một phần tử HTML

```css
div {
  width: 300px; /* Chiều rộng nội dung */
  height: 200px; /* Chiều cao nội dung */

  padding: 20px; /* Khoảng cách từ nội dung đến viền */
  border: 5px solid black; /* Viền */
  margin: 30px; /* Khoảng cách từ viền đến phần tử khác */
}
```

### Chi tiết Box Model

- **Content**: Vùng hiển thị nội dung thực tế (`width`, `height`)
- **Padding**: Khoảng cách giữa nội dung và border (`padding`)
- **Border**: Viền bao quanh padding và nội dung (`border`)
- **Margin**: Khoảng cách giữa border và phần tử lân cận (`margin`)

### Box-sizing

```css
/* Standard box model */
box-sizing: content-box; /* Mặc định */

/* Alternative box model */
box-sizing: border-box; /* width/height bao gồm cả padding và border */

/* Áp dụng border-box cho tất cả phần tử */
* {
  box-sizing: border-box;
}
```

### Margin, Padding và Border

```css
/* Cách viết đầy đủ */
margin-top: 10px;
margin-right: 20px;
margin-bottom: 10px;
margin-left: 20px;

/* Cách viết tắt theo chiều kim đồng hồ (top, right, bottom, left) */
margin: 10px 20px 10px 20px;

/* Cách viết tắt khi đối xứng */
margin: 10px 20px; /* top/bottom 10px, left/right 20px */
margin: 10px; /* tất cả 4 phía đều 10px */

/* Tương tự cho padding */
padding: 10px 20px 15px 25px;

/* Border */
border-width: 2px;
border-style: solid;
border-color: black;

/* Cách viết tắt */
border: 2px solid black;

/* Border cho từng cạnh */
border-top: 2px solid red;
border-right: 2px dashed blue;
border-bottom: 2px dotted green;
border-left: 2px double orange;
```

## 🧑‍🏫 Bài 4: Typography và màu sắc

### Typography (kiểu chữ)

```css
p {
  /* Font family */
  font-family: Arial, Helvetica, sans-serif;

  /* Kích thước chữ */
  font-size: 16px; /* px - pixel */
  font-size: 1.2em; /* em - tương đối với phần tử cha */
  font-size: 1.2rem; /* rem - tương đối với phần tử gốc (html) */

  /* Kiểu chữ */
  font-style: normal; /* normal, italic, oblique */

  /* Độ đậm */
  font-weight: bold; /* normal, bold, 100-900 */

  /* Khoảng cách giữa các dòng */
  line-height: 1.5;

  /* Căn chỉnh văn bản */
  text-align: center; /* left, right, center, justify */

  /* Trang trí văn bản */
  text-decoration: underline; /* none, underline, line-through, overline */

  /* Chuyển đổi văn bản */
  text-transform: uppercase; /* none, capitalize, uppercase, lowercase */

  /* Khoảng cách giữa các chữ */
  letter-spacing: 2px;

  /* Khoảng cách giữa các từ */
  word-spacing: 5px;
}
```

### Sử dụng Google Fonts (hoặc font từ các nguồn online khác)

```html
<head>
  <link
    href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"
    rel="stylesheet"
  />
</head>
```

```css
body {
  font-family: "Roboto", sans-serif;
}
```

### Sử dụng font từ file cục bộ

```css
@font-face {
  font-family: "MyFont";
  src: url("fonts/MyFont.woff2") format("woff2"), url("fonts/MyFont.ttf") format("truetype");
  font-weight: normal;
  font-style: normal;
}
```

```css
body {
  font-family: "MyFont", sans-serif;
}
```

### Màu sắc

```css
/* Tên màu */
color: red;
background-color: yellow;

/* Mã hex */
color: #ff0000; /* Đỏ */
color: #00ff00; /* Xanh lá */
color: #0000ff; /* Xanh dương */

/* RGB và RGBA */
color: rgb(255, 0, 0); /* Đỏ */
color: rgba(255, 0, 0, 0.5); /* Đỏ với độ trong suốt 50% */

/* HSL và HSLA (Hue, Saturation, Lightness) */
color: hsl(0, 100%, 50%); /* Đỏ */
color: hsla(0, 100%, 50%, 0.5); /* Đỏ với độ trong suốt 50% */
```

## 🧑‍🏫 Bài 5: Layout và Positioning

### Display Property

```css
/* Các giá trị phổ biến của display */
display: block; /* Phần tử block chiếm toàn bộ chiều rộng */
display: inline; /* Phần tử inline chiếm đủ không gian cần thiết */
display: inline-block; /* Kết hợp tính chất của inline và block */
display: none; /* Ẩn phần tử khỏi trang */
display: flex; /* Flexible Box Layout */
display: grid; /* Grid Layout */
```

### Position Property

```css
/* Static (mặc định) */
position: static;

/* Relative - tương đối so với vị trí ban đầu */
position: relative;
top: 10px;
left: 20px;

/* Absolute - tương đối so với phần tử cha gần nhất có position khác static */
position: absolute;
top: 0;
right: 0;

/* Fixed - tương đối so với viewport */
position: fixed;
bottom: 20px;
right: 20px;

/* Sticky - kết hợp relative và fixed */
position: sticky;
top: 0;
```

### Float và Clear

```css
/* Float */
float: left; /* Phần tử nổi về bên trái */
float: right; /* Phần tử nổi về bên phải */
float: none; /* Không nổi (mặc định) */

/* Clear - ngăn các phần tử nổi xung quanh */
clear: left; /* Không cho phần tử nổi bên trái */
clear: right; /* Không cho phần tử nổi bên phải */
clear: both; /* Không cho phần tử nổi cả hai bên */
```

### Z-index - Xếp lớp phần tử

```css
/* Phần tử có z-index cao hơn sẽ hiển thị phía trên */
.background {
  position: relative;
  z-index: 1;
}

.foreground {
  position: relative;
  z-index: 2; /* Hiển thị phía trên .background */
}
```

## 🧑‍🏫 Bài 6: Flexbox Layout

### Flexbox

- Đây là một mô hình layout một chiều giúp bố trí các phần tử trong container linh hoạt

```css
.container {
  display: flex; /* Kích hoạt flexbox */

  /* Hướng của main axis */
  flex-direction: row; /* row (mặc định), row-reverse, column, column-reverse */

  /* Xử lý khi phần tử tràn ra khỏi container */
  flex-wrap: wrap; /* nowrap (mặc định), wrap, wrap-reverse */

  /* Kết hợp direction và wrap */
  flex-flow: row wrap;

  /* Căn chỉnh phần tử theo main axis */
  justify-content: center; /* flex-start, flex-end, center, space-between, space-around, space-evenly */

  /* Căn chỉnh phần tử theo cross axis */
  align-items: center; /* stretch, flex-start, flex-end, center, baseline */

  /* Căn chỉnh các hàng/cột trong container */
  align-content: space-between; /* stretch, flex-start, flex-end, center, space-between, space-around */
}

.item {
  /* Thứ tự hiển thị */
  order: 2;

  /* Khả năng co giãn (tăng kích thước) */
  flex-grow: 1;

  /* Khả năng co lại (giảm kích thước) */
  flex-shrink: 1;

  /* Kích thước ban đầu */
  flex-basis: 200px;

  /* Kết hợp grow, shrink và basis */
  flex: 1 1 200px;

  /* Ghi đè align-items cho từng phần tử */
  align-self: flex-end;
}
```

### Ví dụ ứng dụng Flexbox

```css
/* Navigation bar */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #333;
  padding: 10px 20px;
}

.logo {
  flex: 1;
}

.nav-links {
  display: flex;
  list-style: none;
}

.nav-links li {
  margin-left: 20px;
}

/* Card layout */
.card-container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.card {
  flex: 0 1 calc(33.333% - 20px);
  padding: 20px;
  border: 1px solid #ddd;
}
```

## 🧑‍🏫 Bài 7: Grid Layout

### Grid Layout

- Đây là một hệ thống layout hai chiều, giúp bố trí phần tử theo cả hàng và cột

```css
.container {
  display: grid;

  /* Định nghĩa các cột */
  grid-template-columns: 1fr 2fr 1fr;
  grid-template-columns: repeat(3, 1fr);

  /* Định nghĩa các hàng */
  grid-template-rows: 100px auto 100px;

  /* Định nghĩa khoảng cách giữa các phần tử */
  gap: 20px;
  column-gap: 10px;
  row-gap: 15px;

  /* Đặt tên cho các vùng và xác định cấu trúc grid */
  grid-template-areas:
    "header header header"
    "sidebar content content"
    "footer footer footer";
}

.item {
  /* Vị trí phần tử theo cột (start / end) */
  grid-column: 1 / 3;
  grid-column: 1 / span 2;

  /* Vị trí phần tử theo hàng (start / end) */
  grid-row: 2 / 4;
  grid-row: 2 / span 2;

  /* Kết hợp cả hàng và cột */
  grid-area: 2 / 1 / 4 / 3;

  /* Sử dụng tên grid-area đã định nghĩa */
  grid-area: header;
}

/* Căn chỉnh phần tử trong ô grid */
.item {
  justify-self: center; /* start, end, center, stretch */
  align-self: center; /* start, end, center, stretch */
}

.container {
  /* Căn chỉnh tất cả phần tử trong grid */
  justify-items: center;
  align-items: center;

  /* Căn chỉnh toàn bộ grid trong container */
  justify-content: space-between;
  align-content: space-around;
}
```

### Ví dụ ứng dụng Grid

```css
/* Layout trang web */
.page-container {
  display: grid;
  grid-template-areas:
    "header header header"
    "nav content sidebar"
    "footer footer footer";
  grid-template-columns: 1fr 4fr 1fr;
  grid-template-rows: auto 1fr auto;
  min-height: 100vh;
  gap: 10px;
}

.header {
  grid-area: header;
}
.nav {
  grid-area: nav;
}
.content {
  grid-area: content;
}
.sidebar {
  grid-area: sidebar;
}
.footer {
  grid-area: footer;
}

/* Grid gallery */
.gallery {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 10px;
}
```

## 🧑‍🏫 Bài 8: Responsive Web Design

### Responsive Web Design

- Giúp trang web hiển thị phù hợp trên nhiều thiết bị với kích thước màn hình khác nhau

### Media Queries

```css
/* Breakpoint: thiết bị nhỏ (điện thoại) */
@media (max-width: 576px) {
  .container {
    width: 100%;
  }
}

/* Breakpoint: thiết bị trung bình (tablet) */
@media (min-width: 577px) and (max-width: 992px) {
  .container {
    width: 90%;
  }
}

/* Breakpoint: thiết bị lớn (desktop) */
@media (min-width: 993px) {
  .container {
    width: 80%;
    max-width: 1200px;
  }
}

/* Media query theo hướng màn hình */
@media (orientation: landscape) {
  /* CSS khi màn hình ngang */
}

@media (orientation: portrait) {
  /* CSS khi màn hình dọc */
}

/* Media query kết hợp */
@media (min-width: 768px) and (orientation: landscape) {
  /* CSS khi màn hình ngang và rộng tối thiểu 768px */
}
```

### Viewport Meta Tag

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
```

### Responsive Units

```css
/* Đơn vị tương đối */
.container {
  width: 80%; /* % dựa trên phần tử cha */
  font-size: 1.2em; /* em dựa trên font-size của phần tử cha */
  font-size: 1.2rem; /* rem dựa trên font-size của phần tử html */

  width: 100vw; /* vw - 1% chiều rộng viewport */
  height: 100vh; /* vh - 1% chiều cao viewport */

  min-height: 50vh; /* tối thiểu 50% chiều cao viewport */
  max-width: 1200px; /* tối đa 1200px */
}
```

### Mobile-first Approach

- Thiết kế giao diện cho thiết bị di động trước, sau đó mở rộng cho các thiết bị lớn hơn

```css
/* Styles mặc định cho thiết bị di động */
.container {
  width: 100%;
}

/* Sau đó mở rộng cho màn hình lớn hơn */
@media (min-width: 768px) {
  .container {
    width: 750px;
  }
}

@media (min-width: 992px) {
  .container {
    width: 970px;
  }
}

@media (min-width: 1200px) {
  .container {
    width: 1170px;
  }
}
```

### Responsive Images

```css
img {
  max-width: 100%;
  height: auto;
}
```

```html
<picture>
  <source media="(max-width: 576px)" srcset="small.jpg" />
  <source media="(max-width: 992px)" srcset="medium.jpg" />
  <img src="large.jpg" alt="Responsive image" />
</picture>
```

## 🧑‍🏫 Bài 9: CSS Transitions và Animations

### Transitions (Hiệu ứng chuyển đổi)

```css
.button {
  background-color: blue;
  color: white;

  /* Thuộc tính, thời gian, timing function, delay */
  transition: background-color 0.3s ease 0.1s;

  /* Nhiều thuộc tính */
  transition: background-color 0.3s ease, transform 0.2s ease-in;

  /* Tất cả thuộc tính */
  transition: all 0.3s ease;
}

.button:hover {
  background-color: darkblue;
  transform: scale(1.1);
}
```

### Animations (Hoạt hình)

```css
/* Định nghĩa animation với @keyframes */
@keyframes slideIn {
  from {
    transform: translateX(-100%);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
}

@keyframes pulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.1);
  }
  100% {
    transform: scale(1);
  }
}

/* Áp dụng animation */
.element {
  /* tên, thời gian, timing function, delay, số lần lặp, direction, fill-mode */
  animation: slideIn 1s ease-out 0.5s forwards;

  /* Nhiều animation */
  animation: slideIn 1s ease-out, pulse 2s infinite;
}
```

### Animation Properties

```css
.element {
  animation-name: slideIn;
  animation-duration: 1s;
  animation-timing-function: ease-out;
  animation-delay: 0.5s;
  animation-iteration-count: 3; /* số nguyên hoặc infinite */
  animation-direction: alternate; /* normal, reverse, alternate, alternate-reverse */
  animation-fill-mode: forwards; /* none, forwards, backwards, both */
  animation-play-state: running; /* running, paused */
}
```

### Transform

```css
.element {
  /* Xoay */
  transform: rotate(45deg);
  transform: rotateX(45deg);
  transform: rotateY(45deg);

  /* Tỷ lệ */
  transform: scale(1.5);
  transform: scaleX(1.5);
  transform: scaleY(0.5);

  /* Dịch chuyển */
  transform: translate(50px, 20px);
  transform: translateX(50px);
  transform: translateY(20px);

  /* Nghiêng */
  transform: skew(20deg, 10deg);
  transform: skewX(20deg);
  transform: skewY(10deg);

  /* Kết hợp */
  transform: rotate(45deg) scale(1.5) translateX(50px);
}
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng giao diện trang web Portfolio sử dụng CSS

### Mô tả bài toán

Tiếp tục từ bài tập HTML ở phần 1, bạn sẽ thiết kế và định dạng trang Hồ sơ cá nhân với CSS để tạo ra một portfolio chuyên nghiệp. Bạn có thể tham khảo trang [Portfolio](https://klpod221.com) của mình để lấy ý tưởng.

### Yêu cầu

1. Sử dụng external CSS
2. Tạo layout responsive:
   - Hiển thị tốt trên điện thoại (< 576px)
   - Hiển thị tốt trên tablet (< 992px)
   - Hiển thị tốt trên desktop (≥ 992px)
3. Áp dụng Flexbox hoặc Grid cho layout chính
4. Tạo navigation menu có responsive
5. Thiết kế các phần:
   - Kỹ năng: hiển thị mức độ thành thạo dưới dạng thanh progress
   - Dự án: hiển thị dưới dạng grid cards có hover effect
   - Form liên hệ: có styling và validation hiển thị
6. Sử dụng ít nhất 2 animation/transition cho các phần tử

### Gợi ý thiết kế

```css
/* Reset CSS */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* Layout chính */
body {
  font-family: "Roboto", sans-serif;
  line-height: 1.6;
  color: #333;
}

.container {
  width: 90%;
  max-width: 1200px;
  margin: 0 auto;
}

/* Header */
header {
  background-color: #2c3e50;
  color: white;
  text-align: center;
  padding: 60px 0;
}

/* Responsive menu */
nav {
  background-color: #34495e;
}

/* Ví dụ animation */
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.project-card {
  animation: fadeIn 1s ease-in;
}

/* Media queries */
@media (max-width: 576px) {
  /* Mobile styles */
}

@media (min-width: 577px) and (max-width: 991px) {
  /* Tablet styles */
}

@media (min-width: 992px) {
  /* Desktop styles */
}
```

### Kết quả mong đợi

Một trang portfolio hoàn chỉnh với giao diện hấp dẫn, layout responsive, các hiệu ứng tương tác và hoạt ảnh phù hợp để thu hút người xem.
