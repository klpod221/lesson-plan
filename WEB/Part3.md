# 📘 PHẦN 3: JAVASCRIPT - LẬP TRÌNH CHO WEB

## Nội dung

- [📘 PHẦN 3: JAVASCRIPT - LẬP TRÌNH CHO WEB](#-phần-3-javascript---lập-trình-cho-web)
  - [Table of Contents](#table-of-contents)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu JavaScript](#-bài-1-giới-thiệu-javascript)
  - [🧑‍🏫 Bài 2: Cú pháp và biến trong JavaScript](#-bài-2-cú-pháp-và-biến-trong-javascript)
  - [🧑‍🏫 Bài 3: Cấu trúc điều khiển](#-bài-3-cấu-trúc-điều-khiển)
  - [🧑‍🏫 Bài 4: Hàm trong JavaScript](#-bài-4-hàm-trong-javascript)
  - [🧑‍🏫 Bài 5: Object và Array](#-bài-5-object-và-array)
  - [🧑‍🏫 Bài 6: DOM - Document Object Model](#-bài-6-dom---document-object-model)
  - [🧑‍🏫 Bài 7: Sự kiện và xử lý sự kiện](#-bài-7-sự-kiện-và-xử-lý-sự-kiện)
  - [🧑‍🏫 Bài 8: Asynchronous JavaScript](#-bài-8-asynchronous-javascript)
  - [🧑‍🏫 Bài 9: Local Storage và Session Storage](#-bài-9-local-storage-và-session-storage)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN](#-bài-tập-lớn-cuối-phần)
    - [**Đề bài: Xây dựng ứng dụng Quản lý nhiệm vụ (Todo List)**](#đề-bài-xây-dựng-ứng-dụng-quản-lý-nhiệm-vụ-todo-list)

## 🎯 Mục tiêu tổng quát

- Hiểu về JavaScript và vai trò của nó trong phát triển web
- Thành thạo cú pháp và các cấu trúc cơ bản của JavaScript
- Biết cách thao tác với DOM để tạo trang web động
- Xử lý sự kiện, gọi API và xử lý dữ liệu

---

## 🧑‍🏫 Bài 1: Giới thiệu JavaScript

**JavaScript là gì?**

- Là ngôn ngữ lập trình kịch bản phía client-side
- Được nhúng vào trang HTML để tạo tính tương tác cho trang web
- Có thể thay đổi nội dung HTML, thuộc tính, CSS, phản ứng với sự kiện
- Hiện nay cũng được sử dụng ở server-side (Node.js) và mobile app (React Native)

**Cách thêm JavaScript vào HTML:**

1. **Inline JavaScript**: Sử dụng thuộc tính `onclick`, `onload`, ...

```html
<button onclick="alert('Hello!')">Nhấn vào đây</button>
```

2. **Internal JavaScript**: Sử dụng thẻ `<script>` trong trang HTML

```html
<script>
  function sayHello() {
    alert("Hello World!");
  }
</script>
```

3. **External JavaScript**: Tạo file JS riêng và liên kết vào HTML

```html
<script src="script.js"></script>
```

**Vị trí đặt JavaScript:**

```html
<!DOCTYPE html>
<html>
  <head>
    <!-- JavaScript trong head -->
    <script src="head-script.js"></script>
  </head>
  <body>
    <!-- Nội dung trang -->

    <!-- JavaScript ở cuối body (khuyến nghị) -->
    <script src="body-script.js"></script>
  </body>
</html>
```

**Output trong JavaScript:**

```javascript
// Hiển thị thông báo popup
alert("Hello World!");

// Ghi ra console
console.log("Hello World!");

// Ghi ra trang HTML
document.write("<p>Hello World!</p>");

// Điền vào một phần tử HTML
document.getElementById("demo").innerHTML = "Hello World!";
```

---

## 🧑‍🏫 Bài 2: Cú pháp và biến trong JavaScript

**Khai báo biến:**

```javascript
// Khai báo biến với var (phạm vi function-scoped)
var name = "John";

// Khai báo biến với let (phạm vi block-scoped, ES6)
let age = 30;

// Khai báo hằng với const (không thể thay đổi giá trị, ES6)
const PI = 3.14159;

// Khai báo nhiều biến
let firstName = "John",
  lastName = "Doe",
  fullName = firstName + " " + lastName;
```

**Kiểu dữ liệu:**

```javascript
// Number
let count = 10;
let price = 99.99;

// String
let text = "Hello World";
let quote = 'JavaScript is "fun"';

// Boolean
let isActive = true;
let isComplete = false;

// Null và Undefined
let empty = null;
let notDefined; // undefined

// Object
let person = {
  firstName: "John",
  lastName: "Doe",
  age: 30,
};

// Array
let colors = ["Red", "Green", "Blue"];

// Kiểm tra kiểu dữ liệu
console.log(typeof count); // "number"
console.log(typeof text); // "string"
console.log(typeof isActive); // "boolean"
console.log(typeof person); // "object"
console.log(typeof colors); // "object" (array là một loại object)
```

**Phép toán và biểu thức:**

```javascript
// Phép toán số học
let x = 10,
  y = 5;
let sum = x + y; // 15
let diff = x - y; // 5
let product = x * y; // 50
let quotient = x / y; // 2
let remainder = x % y; // 0
let power = x ** y; // 100000 (ES6)

// Phép toán gán
let a = 10;
a += 5; // a = a + 5 = 15
a -= 3; // a = a - 3 = 12
a *= 2; // a = a * 2 = 24
a /= 4; // a = a / 4 = 6
a %= 4; // a = a % 4 = 2

// Phép toán tăng/giảm
let i = 5;
i++; // i = 6 (tăng sau)
++i; // i = 7 (tăng trước)
i--; // i = 6 (giảm sau)
--i; // i = 5 (giảm trước)

// Phép toán chuỗi
let greeting = "Hello";
let name = "World";
let message = greeting + " " + name; // "Hello World"

// Template literals (ES6)
let templateMessage = `${greeting} ${name}!`; // "Hello World!"
let multiline = `Line 1
Line 2
Line 3`;
```

**Scope (phạm vi) biến:**

```javascript
// Global scope
let globalVar = "I am global";

function exampleFunction() {
  // Function scope
  var functionVar = "I am function-scoped";

  if (true) {
    // Block scope
    let blockVar = "I am block-scoped";
    var notReallyBlockVar = "I am still function-scoped";

    console.log(globalVar); // Truy cập được
    console.log(functionVar); // Truy cập được
    console.log(blockVar); // Truy cập được
    console.log(notReallyBlockVar); // Truy cập được
  }

  console.log(globalVar); // Truy cập được
  console.log(functionVar); // Truy cập được
  // console.log(blockVar);      // Lỗi: blockVar is not defined
  console.log(notReallyBlockVar); // Truy cập được
}

console.log(globalVar); // Truy cập được
// console.log(functionVar);     // Lỗi: functionVar is not defined
// console.log(blockVar);        // Lỗi: blockVar is not defined
// console.log(notReallyBlockVar); // Lỗi: notReallyBlockVar is not defined
```

---

## 🧑‍🏫 Bài 3: Cấu trúc điều khiển

**Câu lệnh điều kiện:**

```javascript
// if
let age = 18;
if (age >= 18) {
  console.log("Bạn đã đủ tuổi bầu cử");
}

// if-else
if (age >= 18) {
  console.log("Bạn đã đủ tuổi bầu cử");
} else {
  console.log("Bạn chưa đủ tuổi bầu cử");
}

// if-else if-else
let score = 75;
if (score >= 90) {
  console.log("Xuất sắc");
} else if (score >= 80) {
  console.log("Giỏi");
} else if (score >= 70) {
  console.log("Khá");
} else if (score >= 60) {
  console.log("Trung bình");
} else {
  console.log("Yếu");
}

// Toán tử ba ngôi
let status = age >= 18 ? "Trưởng thành" : "Chưa trưởng thành";

// Switch case
let day = 3;
let dayName;

switch (day) {
  case 1:
    dayName = "Chủ nhật";
    break;
  case 2:
    dayName = "Thứ hai";
    break;
  case 3:
    dayName = "Thứ ba";
    break;
  case 4:
    dayName = "Thứ tư";
    break;
  case 5:
    dayName = "Thứ năm";
    break;
  case 6:
    dayName = "Thứ sáu";
    break;
  case 7:
    dayName = "Thứ bảy";
    break;
  default:
    dayName = "Ngày không hợp lệ";
}
console.log(dayName); // "Thứ ba"
```

**Vòng lặp:**

```javascript
// for
for (let i = 0; i < 5; i++) {
  console.log(i); // 0, 1, 2, 3, 4
}

// for...in (duyệt thuộc tính của object)
const person = { name: "John", age: 30, job: "Developer" };
for (let key in person) {
  console.log(`${key}: ${person[key]}`);
}

// for...of (duyệt các phần tử của mảng/collection, ES6)
const colors = ["red", "green", "blue"];
for (let color of colors) {
  console.log(color);
}

// while
let i = 0;
while (i < 5) {
  console.log(i);
  i++;
}

// do...while
let j = 0;
do {
  console.log(j);
  j++;
} while (j < 5);

// break và continue
for (let i = 0; i < 10; i++) {
  if (i === 5) {
    break; // Thoát khỏi vòng lặp khi i = 5
  }
  console.log(i); // 0, 1, 2, 3, 4
}

for (let i = 0; i < 10; i++) {
  if (i === 5) {
    continue; // Bỏ qua lần lặp khi i = 5
  }
  console.log(i); // 0, 1, 2, 3, 4, 6, 7, 8, 9
}
```

---

## 🧑‍🏫 Bài 4: Hàm trong JavaScript

**Định nghĩa hàm:**

```javascript
// Khai báo hàm
function greet(name) {
  return `Hello, ${name}!`;
}

// Function expression
const sayHello = function (name) {
  return `Hello, ${name}!`;
};

// Arrow function (ES6)
const welcome = (name) => {
  return `Welcome, ${name}!`;
};

// Arrow function rút gọn
const shortWelcome = (name) => `Welcome, ${name}!`;

// Gọi hàm
console.log(greet("John")); // "Hello, John!"
console.log(sayHello("Jane")); // "Hello, Jane!"
console.log(welcome("Bob")); // "Welcome, Bob!"
console.log(shortWelcome("Alice")); // "Welcome, Alice!"
```

**Tham số hàm:**

```javascript
// Tham số mặc định (ES6)
function greet(name = "Guest") {
  return `Hello, ${name}!`;
}
console.log(greet()); // "Hello, Guest!"
console.log(greet("John")); // "Hello, John!"

// Rest parameters (ES6)
function sum(...numbers) {
  return numbers.reduce((total, num) => total + num, 0);
}
console.log(sum(1, 2)); // 3
console.log(sum(1, 2, 3, 4, 5)); // 15

// Arguments object (cách cũ)
function oldSum() {
  let total = 0;
  for (let i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}
```

**Phạm vi và closure:**

```javascript
// Lexical scope
let globalVar = "global";

function outer() {
  let outerVar = "outer";

  function inner() {
    let innerVar = "inner";
    console.log(globalVar); // Truy cập biến global
    console.log(outerVar); // Truy cập biến outer
    console.log(innerVar); // Truy cập biến inner
  }

  inner();
}

// Closure - hàm nhớ môi trường khi nó được tạo ra
function createCounter() {
  let count = 0;

  return function () {
    count++;
    return count;
  };
}

const counter = createCounter();
console.log(counter()); // 1
console.log(counter()); // 2
console.log(counter()); // 3
```

**Higher-order functions:**

```javascript
// Hàm nhận hàm khác làm tham số
function doOperation(a, b, operationFn) {
  return operationFn(a, b);
}

function add(a, b) {
  return a + b;
}

function multiply(a, b) {
  return a * b;
}

console.log(doOperation(5, 3, add)); // 8
console.log(doOperation(5, 3, multiply)); // 15

// Hàm trả về hàm khác
function createMultiplier(factor) {
  return function (number) {
    return number * factor;
  };
}

const double = createMultiplier(2);
const triple = createMultiplier(3);

console.log(double(5)); // 10
console.log(triple(5)); // 15
```

---

## 🧑‍🏫 Bài 5: Object và Array

**Object:**

```javascript
// Tạo object với object literal
const person = {
  firstName: "John",
  lastName: "Doe",
  age: 30,
  hobbies: ["reading", "music", "sports"],
  address: {
    street: "123 Main St",
    city: "New York",
    country: "USA",
  },
  fullName: function () {
    return this.firstName + " " + this.lastName;
  },
};

// Truy cập thuộc tính
console.log(person.firstName); // "John"
console.log(person["lastName"]); // "Doe"
console.log(person.address.city); // "New York"
console.log(person.fullName()); // "John Doe"

// Thêm/sửa thuộc tính
person.email = "john.doe@example.com";
person.age = 31;

// Xóa thuộc tính
delete person.age;

// Kiểm tra thuộc tính tồn tại
console.log("email" in person); // true
console.log(person.hasOwnProperty("age")); // false

// Object methods
console.log(Object.keys(person)); // ["firstName", "lastName", "hobbies", "address", "fullName", "email"]
console.log(Object.values(person)); // [Array với các giá trị]
console.log(Object.entries(person)); // [Array với các cặp key-value]

// Object destructuring (ES6)
const {
  firstName,
  lastName,
  address: { city },
} = person;
console.log(firstName); // "John"
console.log(city); // "New York"
```

**Array:**

```javascript
// Tạo array
const fruits = ["Apple", "Banana", "Orange"];
const mixed = [1, "hello", true, { name: "John" }, [1, 2, 3]];
const newArray = new Array(1, 2, 3);

// Truy cập phần tử
console.log(fruits[0]); // "Apple"
console.log(mixed[3].name); // "John"

// Thay đổi phần tử
fruits[1] = "Grape";

// Array properties
console.log(fruits.length); // 3

// Array methods
fruits.push("Mango"); // Thêm vào cuối
const last = fruits.pop(); // Xóa và trả về phần tử cuối
const first = fruits.shift(); // Xóa và trả về phần tử đầu
fruits.unshift("Strawberry"); // Thêm vào đầu

const newFruits = fruits.concat(["Kiwi", "Pineapple"]); // Nối mảng
const sliced = fruits.slice(1, 3); // Trích xuất từ index 1 đến 2
fruits.splice(1, 1, "Peach", "Lemon"); // Xóa 1 phần tử từ index 1, thêm 2 phần tử mới

// Tìm kiếm
console.log(fruits.indexOf("Apple")); // Tìm index đầu tiên, trả về -1 nếu không tìm thấy
console.log(fruits.includes("Mango")); // true/false

// Sắp xếp
fruits.sort(); // Sắp xếp theo alphabet
fruits.reverse(); // Đảo ngược mảng

// Duyệt mảng với các higher-order functions
const numbers = [1, 2, 3, 4, 5];

// forEach: thực hiện hành động trên từng phần tử
numbers.forEach((num) => console.log(num * 2));

// map: tạo mảng mới từ mảng ban đầu
const doubled = numbers.map((num) => num * 2);

// filter: lọc phần tử theo điều kiện
const evenNumbers = numbers.filter((num) => num % 2 === 0);

// reduce: tính toán giá trị tích lũy
const sum = numbers.reduce((total, num) => total + num, 0);

// find: tìm phần tử đầu tiên thỏa mãn điều kiện
const foundNumber = numbers.find((num) => num > 3);

// every: kiểm tra tất cả phần tử thỏa mãn điều kiện
const allPositive = numbers.every((num) => num > 0);

// some: kiểm tra có ít nhất một phần tử thỏa mãn điều kiện
const hasEven = numbers.some((num) => num % 2 === 0);

// Array destructuring (ES6)
const [first, second, ...rest] = [1, 2, 3, 4, 5];
console.log(first); // 1
console.log(second); // 2
console.log(rest); // [3, 4, 5]
```

---

## 🧑‍🏫 Bài 6: DOM - Document Object Model

**DOM là gì?**

- DOM (Document Object Model) là một API cho HTML và XML
- Biểu diễn trang web dưới dạng cấu trúc cây các node
- Cho phép JavaScript truy cập và thay đổi nội dung, cấu trúc và style của trang web

**Truy cập phần tử DOM:**

```javascript
// Truy cập theo ID
const header = document.getElementById("header");

// Truy cập theo class name (trả về HTMLCollection)
const containers = document.getElementsByClassName("container");

// Truy cập theo tag name (trả về HTMLCollection)
const paragraphs = document.getElementsByTagName("p");

// Truy cập bằng CSS selector (trả về phần tử đầu tiên)
const firstButton = document.querySelector("button");

// Truy cập bằng CSS selector (trả về NodeList)
const allButtons = document.querySelectorAll("button.primary");

// Truy cập node con
const children = header.children; // HTMLCollection con trực tiếp
const childNodes = header.childNodes; // NodeList (bao gồm cả text nodes)
const firstChild = header.firstChild; // Node đầu tiên (có thể là text node)
const firstElement = header.firstElementChild; // Element đầu tiên

// Truy cập node cha
const parent = header.parentNode;
const parentElement = header.parentElement;

// Truy cập node anh em
const nextSibling = header.nextSibling;
const nextElement = header.nextElementSibling;
const prevSibling = header.previousSibling;
const prevElement = header.previousElementSibling;
```

**Thay đổi nội dung DOM:**

```javascript
// Thay đổi nội dung
element.textContent = "Nội dung mới"; // Chỉ thay đổi text
element.innerHTML = "<strong>Nội dung</strong> HTML mới"; // Parse và thay đổi HTML

// Thay đổi thuộc tính
element.setAttribute("id", "newId");
element.id = "newId"; // Trực tiếp qua thuộc tính
const attrValue = element.getAttribute("data-value");
element.removeAttribute("title");

// Thay đổi style
element.style.color = "red";
element.style.backgroundColor = "lightblue";
element.style.fontSize = "16px";

// Thêm/xóa class
element.classList.add("active");
element.classList.remove("hidden");
element.classList.toggle("selected"); // Thêm nếu chưa có, xóa nếu đã có
element.classList.contains("active"); // Kiểm tra class tồn tại
```

**Tạo và thêm/xóa phần tử:**

```javascript
// Tạo phần tử mới
const newDiv = document.createElement("div");
const textNode = document.createTextNode("Nội dung mới");

// Thêm nội dung vào phần tử
newDiv.textContent = "Thêm nội dung";
newDiv.appendChild(textNode);

// Thêm vào DOM
parentElement.appendChild(newDiv); // Thêm vào cuối
parentElement.insertBefore(newDiv, referenceElement); // Thêm trước phần tử tham chiếu

// Phương thức chèn mới (ES6)
parentElement.append(newDiv, textNode); // Thêm nhiều node vào cuối
parentElement.prepend(newDiv); // Thêm vào đầu
referenceElement.before(newDiv); // Thêm trước phần tử
referenceElement.after(newDiv); // Thêm sau phần tử
element.replaceWith(newDiv); // Thay thế phần tử

// Xóa phần tử
parentElement.removeChild(childElement); // Cách cũ
element.remove(); // Cách mới (ES6)

// Clone phần tử
const clone = element.cloneNode(true); // true: clone toàn bộ subtree, false: chỉ clone node
```

---

## 🧑‍🏫 Bài 7: Sự kiện và xử lý sự kiện

**Đăng ký sự kiện:**

```javascript
// Phương thức 1: Thuộc tính HTML (không khuyến khích)
<button onclick="handleClick()">Click me</button>;

// Phương thức 2: DOM property
button.onclick = function () {
  console.log("Button clicked");
};

// Phương thức 3: addEventListener (khuyến nghị)
button.addEventListener("click", function (event) {
  console.log("Button clicked", event);
});

// Sử dụng arrow function
button.addEventListener("click", (event) => {
  console.log("Button clicked", event);
});

// Xóa event listener
function handleClick(event) {
  console.log("Button clicked");
}
button.addEventListener("click", handleClick);
button.removeEventListener("click", handleClick);
```

**Các loại sự kiện phổ biến:**

```javascript
// Mouse events
element.addEventListener("click", handler); // Click chuột
element.addEventListener("dblclick", handler); // Double-click
element.addEventListener("mousedown", handler); // Nhấn chuột xuống
element.addEventListener("mouseup", handler); // Thả chuột
element.addEventListener("mousemove", handler); // Di chuyển chuột
element.addEventListener("mouseover", handler); // Chuột di chuyển vào element
element.addEventListener("mouseout", handler); // Chuột di chuyển ra khỏi element

// Keyboard events
element.addEventListener("keydown", handler); // Phím được nhấn
element.addEventListener("keyup", handler); // Phím được thả
element.addEventListener("keypress", handler); // Phím được nhấn (chỉ ký tự)

// Form events
form.addEventListener("submit", handler); // Form được submit
input.addEventListener("change", handler); // Giá trị thay đổi và mất focus
input.addEventListener("input", handler); // Giá trị thay đổi (realtime)
input.addEventListener("focus", handler); // Element được focus
input.addEventListener("blur", handler); // Element mất focus

// Document/Window events
window.addEventListener("load", handler); // Trang và tài nguyên được tải xong
document.addEventListener("DOMContentLoaded", handler); // DOM đã sẵn sàng
window.addEventListener("resize", handler); // Kích thước cửa sổ thay đổi
window.addEventListener("scroll", handler); // Cuộn trang
```

**Event object:**

```javascript
element.addEventListener("click", function (event) {
  // Thông tin chung
  console.log(event.type); // Loại event (e.g., "click")
  console.log(event.target); // Phần tử gốc kích hoạt sự kiện
  console.log(event.currentTarget); // Phần tử đang xử lý sự kiện
  console.log(event.timeStamp); // Thời gian xảy ra sự kiện

  // Mouse event
  console.log(event.clientX, event.clientY); // Vị trí chuột (viewport)
  console.log(event.pageX, event.pageY); // Vị trí chuột (document)
  console.log(event.button); // Nút chuột (0: trái, 1: giữa, 2: phải)

  // Keyboard event
  console.log(event.key); // Phím đã nhấn
  console.log(event.keyCode); // Mã ASCII của phím (deprecated)
  console.log(event.code); // Mã vật lý của phím (e.g., "KeyA")
  console.log(event.ctrlKey); // Xác định Ctrl key được nhấn
  console.log(event.shiftKey); // Xác định Shift key được nhấn
  console.log(event.altKey); // Xác định Alt key được nhấn

  // Dừng hành vi mặc định
  event.preventDefault();

  // Ngăn sự kiện lan truyền (bubbling)
  event.stopPropagation();
});
```

**Event propagation:**

```javascript
// Bubbling (mặc định): sự kiện lan từ target lên ancestor
// Capturing: sự kiện lan từ ancestor xuống target

// useCapture parameter (boolean thứ 3)
parent.addEventListener("click", parentHandler, true); // Capturing phase
child.addEventListener("click", childHandler, false); // Bubbling phase (mặc định)

function handleEvent(event) {
  console.log(`${event.currentTarget.tagName} was clicked`);
  console.log(`Event phase: ${event.eventPhase}`);
  // 1: Capturing, 2: Target, 3: Bubbling
}
```

**Event delegation:**

```javascript
// Sử dụng sự kiện lan truyền để xử lý nhiều phần tử con với một handler
document
  .getElementById("parent-list")
  .addEventListener("click", function (event) {
    if (event.target.tagName === "LI") {
      console.log("List item clicked:", event.target.textContent);
    }
  });
```

---

## 🧑‍🏫 Bài 8: Asynchronous JavaScript

**Callback:**

```javascript
// Callback function
function fetchData(callback) {
  setTimeout(() => {
    const data = { name: "John", age: 30 };
    callback(null, data); // null là error (không có lỗi)
  }, 1000);
}

fetchData((error, data) => {
  if (error) {
    console.error("Error:", error);
  } else {
    console.log("Data:", data);
  }
});

// Callback Hell
fetchUserData((error, user) => {
  if (error) {
    console.error(error);
  } else {
    fetchUserPosts(user.id, (error, posts) => {
      if (error) {
        console.error(error);
      } else {
        fetchPostComments(posts[0].id, (error, comments) => {
          if (error) {
            console.error(error);
          } else {
            console.log(comments);
          }
        });
      }
    });
  }
});
```

**Promises:**

```javascript
// Tạo Promise
function fetchData() {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const success = true;
      if (success) {
        resolve({ name: "John", age: 30 });
      } else {
        reject(new Error("Failed to fetch data"));
      }
    }, 1000);
  });
}

// Sử dụng Promise
fetchData()
  .then((data) => {
    console.log("Data:", data);
    return processData(data); // Return promise khác để chain
  })
  .then((processedData) => {
    console.log("Processed:", processedData);
  })
  .catch((error) => {
    console.error("Error:", error);
  })
  .finally(() => {
    console.log("Operation completed");
  });

// Promise.all - chờ tất cả promises hoàn thành
Promise.all([fetchUsers(), fetchPosts(), fetchComments()])
  .then(([users, posts, comments]) => {
    console.log(users, posts, comments);
  })
  .catch((error) => {
    console.error(error);
  });

// Promise.race - chờ promise đầu tiên hoàn thành
Promise.race([fetchData1(), fetchData2()])
  .then((result) => {
    console.log("First result:", result);
  })
  .catch((error) => {
    console.error("First error:", error);
  });

// Promise.allSettled - chờ tất cả promises hoàn thành (ES2020)
Promise.allSettled([fetchData1(), fetchData2()]).then((results) => {
  results.forEach((result) => {
    if (result.status === "fulfilled") {
      console.log("Success:", result.value);
    } else {
      console.log("Error:", result.reason);
    }
  });
});
```

**Async/Await (ES8):**

```javascript
// Async function luôn trả về promise
async function fetchUserData() {
  try {
    // Await tạm dừng thực thi cho đến khi promise hoàn thành
    const user = await fetchUser();
    const posts = await fetchPosts(user.id);
    const comments = await fetchComments(posts[0].id);

    return { user, posts, comments };
  } catch (error) {
    console.error("Error:", error);
    throw error; // Rethrow để xử lý bên ngoài nếu cần
  } finally {
    console.log("Operation completed");
  }
}

// Gọi async function
fetchUserData()
  .then((data) => console.log("All data:", data))
  .catch((error) => console.error("Error in main:", error));

// Chạy nhiều promises song song
async function fetchAllData() {
  try {
    // Chạy các promises đồng thời
    const [users, products, orders] = await Promise.all([
      fetchUsers(),
      fetchProducts(),
      fetchOrders(),
    ]);

    return { users, products, orders };
  } catch (error) {
    console.error("Error:", error);
  }
}
```

**Fetch API:**

```javascript
// Fetch API - giao diện hiện đại để gọi API
fetch("https://api.example.com/data")
  .then((response) => {
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return response.json(); // Parse response body thành JSON
  })
  .then((data) => {
    console.log("Data:", data);
  })
  .catch((error) => {
    console.error("Error:", error);
  });

// POST request với Fetch
fetch("https://api.example.com/users", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    name: "John",
    email: "john@example.com",
  }),
})
  .then((response) => response.json())
  .then((data) => console.log("Success:", data))
  .catch((error) => console.error("Error:", error));

// Async/await với fetch
async function fetchUsers() {
  try {
    const response = await fetch("https://api.example.com/users");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const users = await response.json();
    return users;
  } catch (error) {
    console.error("Error fetching users:", error);
    throw error;
  }
}
```

---

## 🧑‍🏫 Bài 9: Local Storage và Session Storage

**Web Storage API:**

```javascript
// LocalStorage - dữ liệu được lưu trữ không giới hạn thời gian
// Lưu dữ liệu
localStorage.setItem("username", "john_doe");
localStorage.setItem(
  "preferences",
  JSON.stringify({ theme: "dark", fontSize: 14 })
);

// Đọc dữ liệu
const username = localStorage.getItem("username");
const preferences = JSON.parse(localStorage.getItem("preferences"));

// Xóa một item
localStorage.removeItem("username");

// Xóa tất cả
localStorage.clear();

// SessionStorage - dữ liệu chỉ được lưu trong phiên làm việc hiện tại
sessionStorage.setItem("temp_data", "some value");
const tempData = sessionStorage.getItem("temp_data");
sessionStorage.removeItem("temp_data");
sessionStorage.clear();

// Lắng nghe sự kiện thay đổi storage (trên các tab/window khác)
window.addEventListener("storage", (event) => {
  console.log("Storage changed:", event.key, event.newValue, event.oldValue);
});
```

**Trường hợp sử dụng:**

```javascript
// Lưu trạng thái ứng dụng
function saveAppState() {
  const state = {
    darkMode: true,
    sidebar: "collapsed",
    lastVisitedPage: "/products",
  };
  localStorage.setItem("appState", JSON.stringify(state));
}

// Lưu giỏ hàng
function addToCart(product) {
  // Lấy giỏ hàng hiện tại hoặc tạo mới
  let cart = JSON.parse(localStorage.getItem("cart")) || [];

  // Thêm sản phẩm vào giỏ hàng
  cart.push(product);

  // Lưu giỏ hàng
  localStorage.setItem("cart", JSON.stringify(cart));
}

// Theo dõi đăng nhập
function login(user) {
  sessionStorage.setItem("currentUser", JSON.stringify(user));
  localStorage.setItem("lastLogin", new Date().toISOString());
}

function checkLogin() {
  const user = sessionStorage.getItem("currentUser");
  return user ? JSON.parse(user) : null;
}

function logout() {
  sessionStorage.removeItem("currentUser");
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN

### **Đề bài: Xây dựng ứng dụng Quản lý nhiệm vụ (Todo List)**

Xây dựng một ứng dụng Todo List hoàn chỉnh với các chức năng:

1. Thêm nhiệm vụ mới
2. Đánh dấu nhiệm vụ đã hoàn thành
3. Xóa nhiệm vụ
4. Lọc nhiệm vụ (tất cả, đã hoàn thành, chưa hoàn thành)
5. Lưu trữ dữ liệu sử dụng Local Storage
6. Giao diện người dùng thân thiện (sử dụng HTML/CSS đã học)

**Yêu cầu:**

- Sử dụng JavaScript thuần, không dùng thư viện
- Áp dụng kiến thức DOM, Events, Local Storage
- Thực hiện validation cho form nhập nhiệm vụ
- Sử dụng ES6+ features (arrow functions, destructuring, etc.)
- Triển khai theo mô hình MVC hoặc module pattern

**Tính năng nâng cao (không bắt buộc):**

- Thêm chức năng sửa nhiệm vụ
- Thêm chức năng phân loại nhiệm vụ theo danh mục
- Thêm chức năng drag-and-drop để sắp xếp
- Hiển thị thống kê (số lượng đã hoàn thành/chưa hoàn thành)
- Thêm deadline và thông báo

**Mockup ứng dụng:**

```text
+-----------------------------------------------+
|                  TODO LIST                    |
+-----------------------------------------------+
| Add new task: [______________________] [Add]  |
+-----------------------------------------------+
| Filters: [All] [Active] [Completed]           |
+-----------------------------------------------+
| [ ] Task 1                             [X]    |
| [x] Task 2 (completed)                 [X]    |
| [ ] Task 3                             [X]    |
+-----------------------------------------------+
| 2 tasks left | Clear completed                |
+-----------------------------------------------+
```

---

[⬅️ Trở lại: WEB/Part2.md](../WEB/Part2.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: WEB/Part4.md](../WEB/Part4.md)
