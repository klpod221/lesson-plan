# 📘 PHẦN 1: NỀN TẢNG REACT

## 🎯 Mục tiêu tổng quát

- Hiểu được khái niệm cơ bản về React, tại sao nó ra đời và vai trò của nó trong phát triển web hiện đại.
- Nắm vững cú pháp JSX để mô tả giao diện người dùng.
- Biết cách tạo và sử dụng các Components để xây dựng giao diện theo hướng module hóa.
- Hiểu và sử dụng `props` để truyền dữ liệu từ component cha xuống component con.

## 🧑‍🏫 Bài 1: Giới thiệu React và Môi trường

### React là gì?

- React là một thư viện JavaScript mã nguồn mở, dùng để xây dựng giao diện người dùng (UI).
- Được phát triển bởi Facebook.
- React hoạt động dựa trên khái niệm **Components** - các khối xây dựng độc lập và tái sử dụng.
- React sử dụng **Virtual DOM** để tối ưu hóa việc cập nhật và render giao diện, giúp ứng dụng nhanh và hiệu quả.

Sơ đồ hoạt động cơ bản:

```text
[ Dữ liệu (State/Props) ] ----> [ React Component ] ----> [ Giao diện (UI) ]
```

### Thiết lập môi trường (Vite)

Chúng ta sẽ sử dụng Vite, một công cụ build hiện đại, để tạo dự án React một cách nhanh chóng.

Mở terminal và chạy lệnh sau:

```bash
# Sử dụng npm
npm create vite@latest simple-store -- --template react

# Hoặc sử dụng yarn
# yarn create vite simple-store --template react

# Di chuyển vào thư mục dự án
cd simple-store

# Cài đặt các dependencies
npm install

# Chạy server phát triển
npm run dev
```

Truy cập vào địa chỉ `http://localhost:5173` (hoặc cổng khác được hiển thị trong terminal) để xem ứng dụng của bạn.

## 🧑‍🏫 Bài 2: JSX - JavaScript XML

### Cú pháp JSX

JSX là một phần mở rộng cú pháp cho JavaScript, cho phép viết code trông giống HTML ngay trong file JavaScript.

```jsx
// src/App.jsx

// Thay vì viết:
// return React.createElement('h1', {className: 'greeting'}, 'Hello, world!');

// Chúng ta viết với JSX:
function App() {
  return <h1>Hello, world!</h1>;
}

export default App;
```

**Lưu ý:**

- `class` trong HTML được viết thành `className` trong JSX.
- Mọi thẻ phải được đóng (`<br>` phải thành `<br />`).
- Component chỉ có thể trả về một phần tử gốc duy nhất. Sử dụng Fragment (`<>...</>`) nếu cần.

### Nhúng biểu thức JavaScript vào JSX

Bạn có thể nhúng bất kỳ biểu thức JavaScript nào vào trong JSX bằng cách đặt nó trong cặp dấu ngoặc nhọn `{}`.

```jsx
// src/App.jsx

function App() {
  const name = "React Developer";
  const product = {
    title: "Laptop Pro",
    price: 25000000
  };

  return (
    <>
      <h1>Xin chào, {name}!</h1>
      <p>Sản phẩm: {product.title}</p>
      <p>Giá: {product.price.toLocaleString()} VNĐ</p>
      <p>Năm hiện tại: {new Date().getFullYear()}</p>
    </>
  );
}

export default App;
```

## 🧑‍🏫 Bài 3: Components và Props

### Function Components

Component là những hàm JavaScript độc lập, nhận đầu vào là `props` và trả về các phần tử React mô tả những gì sẽ hiển thị trên màn hình.

```jsx
// src/components/Greeting.jsx
function Greeting() {
  return <h2>Welcome to our store!</h2>;
}

export default Greeting;
```

### Props (Properties)

Props (viết tắt của properties) là cách để truyền dữ liệu từ component cha xuống component con. Props là đối tượng chỉ đọc.

Sơ đồ truyền Props:

```text
[ App Component (dữ liệu) ] ----(props)----> [ ProductCard Component ]
```

**Ví dụ:**

```jsx
// src/components/ProductCard.jsx
function ProductCard(props) {
  // props là một object: { name: "iPhone 15", price: 22000000 }
  return (
    <div className="product-card">
      <h3>{props.name}</h3>
      <p>Giá: {props.price.toLocaleString()} VNĐ</p>
    </div>
  );
}
export default ProductCard;

// src/App.jsx
import ProductCard from './components/ProductCard';

function App() {
  return (
    <div>
      <h1>Sản phẩm nổi bật</h1>
      <ProductCard name="iPhone 15 Pro" price={30000000} />
      <ProductCard name="Macbook Air M2" price={28000000} />
    </div>
  );
}
export default App;
```

### Tổ chức Components

Tạo một cây component để quản lý giao diện.

```text
App
├── Header.jsx
└── ProductList.jsx
    ├── ProductCard.jsx
    ├── ProductCard.jsx
    └── ...
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng giao diện tĩnh cho trang "SimpleStore"

### Mô tả bài toán

Tạo một trang web hiển thị danh sách các sản phẩm. Dữ liệu sản phẩm sẽ được lưu trữ tạm thời trong một mảng JavaScript. Giao diện hoàn toàn tĩnh, chưa có tương tác.

### Yêu cầu

1. **Cấu trúc thư mục:**
    - Tạo thư mục `src/components`.
    - Bên trong, tạo các file component: `Header.jsx`, `ProductList.jsx`, `ProductCard.jsx`.
2. **Dữ liệu:**
    - Trong file `src/App.jsx`, tạo một mảng dữ liệu `products` chứa thông tin của ít nhất 4 sản phẩm. Mỗi sản phẩm là một object có `id`, `name`, `price`, và `imageUrl`.
3. **Component `ProductCard.jsx`:**
    - Nhận `name`, `price`, `imageUrl` qua `props`.
    - Hiển thị thông tin sản phẩm trong một thẻ `div` có style đơn giản.
4. **Component `ProductList.jsx`:**
    - Nhận mảng `products` qua `props`.
    - Sử dụng hàm `.map()` để lặp qua mảng `products` và render ra một danh sách các `ProductCard`.
5. **Component `Header.jsx`:**
    - Hiển thị tiêu đề của trang web, ví dụ: "Welcome to SimpleStore".
6. **Component `App.jsx`:**
    - Là component gốc, import và sắp xếp `Header` và `ProductList`.
    - Truyền mảng `products` vào cho `ProductList`.

**Mục tiêu:** Kết thúc phần này, bạn sẽ có một trang web hiển thị danh sách sản phẩm, được xây dựng hoàn toàn bằng các component React và dữ liệu tĩnh.
