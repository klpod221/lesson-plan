# 📘 PHẦN 2: TRẠNG THÁI (STATE) VÀ TÍNH TƯƠNG TÁC

## 🎯 Mục tiêu tổng quát

- Hiểu khái niệm `state` và vai trò của nó trong việc tạo ra các component động.
- Sử dụng Hook `useState` để quản lý trạng thái của component.
- Xử lý các sự kiện người dùng như click, nhập liệu.
- Sử dụng render có điều kiện để hiển thị hoặc ẩn các phần tử UI.
- Nắm vững cách render danh sách dữ liệu và tầm quan trọng của `key`.

## 🧑‍🏫 Bài 1: State và Hook `useState`

### State là gì?

- **State** là dữ liệu riêng tư của một component, có thể thay đổi theo thời gian (thường là do tương tác của người dùng).
- Khi **state** thay đổi, React sẽ tự động **render lại (re-render)** component đó để cập nhật giao diện.
- **Props** là để truyền dữ liệu từ cha xuống con, còn **State** là để quản lý dữ liệu nội tại của component.

Sơ đồ hoạt động của State:

```text
[ Tương tác người dùng (ví dụ: click) ]
    |
    V
[ Gọi hàm setState() ]
    |
    V
[ State thay đổi ]
    |
    V
[ React render lại Component ]
    |
    V
[ Giao diện được cập nhật ]
```

### Giới thiệu Hook `useState`

`useState` là một **Hook** cho phép bạn thêm state vào function component.

```jsx
import { useState } from 'react';

function Counter() {
  // Khai báo một biến state tên là `count`
  // `setCount` là hàm để cập nhật giá trị cho `count`
  const [count, setCount] = useState(0); // 0 là giá trị khởi tạo

  return (
    <div>
      <p>Bạn đã click {count} lần</p>
      {/* Sẽ học ở bài sau */}
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}
```

### Cập nhật State

- **Không bao giờ** thay đổi state trực tiếp: `count = count + 1;` (SAI)
- **Luôn luôn** sử dụng hàm setter do `useState` cung cấp: `setCount(count + 1);` (ĐÚNG)
- Khi cập nhật state dựa trên giá trị cũ, nên dùng dạng callback để đảm bảo tính chính xác:

  ```jsx
  setCount(prevCount => prevCount + 1);
  ```

## 🧑‍🏫 Bài 2: Xử lý sự kiện (Handling Events)

### Sự kiện trong React

- Tên sự kiện trong React được viết theo kiểu `camelCase`, ví dụ: `onClick`, `onChange`.
- Bạn truyền một hàm vào trình xử lý sự kiện, thay vì một chuỗi.

```jsx
function AlertButton() {
  function handleClick() {
    alert('Bạn đã click vào nút!');
  }

  return (
    <button onClick={handleClick}>
      Bấm vào đây
    </button>
  );
}
```

### Truyền hàm xử lý sự kiện qua Props

Bạn có thể truyền các hàm xử lý sự kiện từ component cha xuống component con.

Sơ đồ luồng sự kiện:

```text
[ Parent Component (định nghĩa hàm onAction) ] --(props: onAction)--> [ Child Component (Button) ]
                ^                                                                |
                |----------------(Khi click, gọi props.onAction())---------------|
```

```jsx
// Child: Button.jsx
function Button({ onCustomClick, children }) {
  return (
    <button onClick={onCustomClick}>
      {children}
    </button>
  );
}

// Parent: App.jsx
import Button from './Button';

function App() {
  function handlePlayClick() {
    alert('Đang phát video!');
  }
  function handleUploadClick() {
    alert('Đang tải lên!');
  }
  return (
    <div>
      <Button onCustomClick={handlePlayClick}>Phát video</Button>
      <Button onCustomClick={handleUploadClick}>Tải lên</Button>
    </div>
  );
}
```

## 🧑‍🏫 Bài 3: Render có điều kiện và List

### Render có điều kiện (Conditional Rendering)

Bạn có thể dùng các biểu thức điều kiện của JavaScript để quyết định phần UI nào sẽ được render.

```jsx
function UserGreeting({ isLoggedIn }) {
  // Cách 1: Dùng if/else
  if (isLoggedIn) {
    return <h1>Chào mừng trở lại!</h1>;
  }
  return <h1>Vui lòng đăng nhập.</h1>;

  // Cách 2: Dùng toán tử ba ngôi (thường dùng trong JSX)
  return (
    <div>
      {isLoggedIn ? <p>Bạn đã đăng nhập</p> : <p>Bạn chưa đăng nhập</p>}
    </div>
  );

  // Cách 3: Dùng toán tử && (chỉ render nếu điều kiện đúng)
  return (
    <div>
      {isLoggedIn && <p>Giỏ hàng của bạn</p>}
    </div>
  );
}
```

### Render danh sách và thuộc tính `key`

Sử dụng hàm `.map()` để biến một mảng dữ liệu thành một mảng các phần tử React.

- **`key`** là một thuộc tính đặc biệt bạn cần cung cấp khi tạo danh sách các phần tử.
- `key` giúp React xác định phần tử nào đã thay đổi, được thêm vào hoặc bị xóa đi.
- `key` phải là một chuỗi hoặc số **duy nhất** trong danh sách anh em của nó. Thường dùng `id` của dữ liệu.

```jsx
function ProductList({ products }) {
  const listItems = products.map(product =>
    <li key={product.id}>
      {product.name}
    </li>
  );

  return <ul>{listItems}</ul>;
}
```

**Lưu ý:** Không nên dùng index của mảng làm `key` nếu danh sách có thể thay đổi thứ tự, thêm, xóa.

## 🧑‍🏫 Bài 4: Xử lý Form cơ bản

### Controlled Components

Trong HTML, các thẻ form như `<input>`, `<textarea>` tự quản lý state của chúng. Trong React, chúng ta có thể làm cho component React trở thành "nguồn chân lý duy nhất" bằng cách sử dụng state. Một thẻ input có giá trị được kiểm soát bởi React được gọi là "controlled component".

```jsx
import { useState } from 'react';

function NameForm() {
  const [name, setName] = useState('');

  function handleChange(event) {
    setName(event.target.value);
  }

  function handleSubmit(event) {
    event.preventDefault(); // Ngăn trình duyệt reload
    alert('Tên đã được gửi: ' .concat(name));
  }

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Tên:
        <input type="text" value={name} onChange={handleChange} />
      </label>
      <input type="submit" value="Gửi" />
    </form>
  );
}
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Thêm giỏ hàng và tương tác cho "SimpleStore"

### Mô tả bài toán

Nâng cấp trang "SimpleStore" đã tạo ở Phần 1. Thêm chức năng cho phép người dùng "Thêm vào giỏ hàng" và xem tổng số lượng sản phẩm trong giỏ.

### Yêu cầu

1. **Component `Header.jsx`:**
    - Sử dụng `useState` để quản lý số lượng sản phẩm trong giỏ hàng (`cartCount`).
    - Hiển thị `cartCount` ở góc trên bên phải của header. Ví dụ: `Giỏ hàng (0)`.
2. **Component `App.jsx`:**
    - Quản lý state của giỏ hàng, có thể là một mảng các sản phẩm trong giỏ: `const [cart, setCart] = useState([]);`
    - Viết một hàm `handleAddToCart(product)` để xử lý việc thêm sản phẩm vào giỏ hàng. Hàm này sẽ được truyền xuống `ProductList` và `ProductCard`.
        - Logic bên trong: `setCart(prevCart => [...prevCart, product]);`
3. **Component `ProductCard.jsx`:**
    - Nhận hàm `onAddToCart` từ `props`.
    - Thêm một nút "Thêm vào giỏ hàng".
    - Khi click vào nút này, gọi hàm `onAddToCart` và truyền thông tin sản phẩm của card đó vào.
4. **Kết nối các component:**
    - `App` component sẽ truyền hàm `handleAddToCart` xuống `ProductList`.
    - `ProductList` sẽ truyền tiếp hàm đó xuống từng `ProductCard`.
    - Khi một sản phẩm được thêm vào giỏ hàng (state `cart` trong `App` thay đổi), `App` sẽ tính toán tổng số lượng và truyền xuống `Header` để cập nhật hiển thị.
        - Sơ đồ: `App (state: cart) --(props: cart.length)--> Header`
        - Sơ đồ: `App (hàm: handleAddToCart) --props--> ProductList --props--> ProductCard`

**Mục tiêu:** Kết thúc phần này, ứng dụng của bạn sẽ có tính tương tác. Người dùng có thể click vào nút và thấy giao diện (số lượng trong giỏ hàng) được cập nhật ngay lập tức.
