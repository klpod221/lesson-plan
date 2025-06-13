# 📘 PHẦN 3: VÒNG ĐỜI, SIDE EFFECTS VÀ HOOKS CHUYÊN SÂU

- [📘 PHẦN 3: VÒNG ĐỜI, SIDE EFFECTS VÀ HOOKS CHUYÊN SÂU](#-phần-3-vòng-đời-side-effects-và-hooks-chuyên-sâu)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Side Effects và Hook `useEffect`](#-bài-1-side-effects-và-hook-useeffect)
    - [Side Effect là gì?](#side-effect-là-gì)
    - [Cú pháp cơ bản của `useEffect`](#cú-pháp-cơ-bản-của-useeffect)
  - [🧑‍🏫 Bài 2: Mảng phụ thuộc (Dependency Array) trong `useEffect`](#-bài-2-mảng-phụ-thuộc-dependency-array-trong-useeffect)
    - [Trường hợp 1: Không có mảng phụ thuộc](#trường-hợp-1-không-có-mảng-phụ-thuộc)
    - [Trường hợp 2: Mảng rỗng `[]`](#trường-hợp-2-mảng-rỗng-)
    - [Trường hợp 3: Mảng có giá trị `[prop, state]`](#trường-hợp-3-mảng-có-giá-trị-prop-state)
  - [🧑‍🏫 Bài 3: Lấy dữ liệu từ API (Data Fetching)](#-bài-3-lấy-dữ-liệu-từ-api-data-fetching)
    - [Quy trình lấy dữ liệu](#quy-trình-lấy-dữ-liệu)
    - [Ví dụ hoàn chỉnh](#ví-dụ-hoàn-chỉnh)
  - [🧑‍🏫 Bài 4: Hàm dọn dẹp (Cleanup Function)](#-bài-4-hàm-dọn-dẹp-cleanup-function)
    - [Tại sao cần cleanup?](#tại-sao-cần-cleanup)
    - [Cách hoạt động](#cách-hoạt-động)
  - [🧑‍🏫 Bài 5: Cẩm nang React Hooks Chuyên sâu](#-bài-5-cẩm-nang-react-hooks-chuyên-sâu)
    - [Nhóm 1: Hooks Cơ bản (State \& Effects)](#nhóm-1-hooks-cơ-bản-state--effects)
    - [Nhóm 2: Hooks về Context](#nhóm-2-hooks-về-context)
    - [Nhóm 3: Hooks về Tối ưu hóa Hiệu năng (Performance)](#nhóm-3-hooks-về-tối-ưu-hóa-hiệu-năng-performance)
    - [Nhóm 4: Hooks về Ref](#nhóm-4-hooks-về-ref)
    - [Nhóm 5: Hooks Nâng cao \& Ít dùng hơn](#nhóm-5-hooks-nâng-cao--ít-dùng-hơn)
    - [Nhóm 6: Hooks mới trong React 18+](#nhóm-6-hooks-mới-trong-react-18)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Lấy dữ liệu sản phẩm động cho "SimpleStore"](#-bài-tập-lớn-cuối-phần-lấy-dữ-liệu-sản-phẩm-động-cho-simplestore)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Hiểu rõ khái niệm "side effect" và vai trò của `useEffect`.
- Nắm vững cách dùng `useEffect` để lấy dữ liệu từ API và xử lý các trạng thái.
- Hiểu sâu sắc và phân biệt được cách sử dụng của hầu hết các Hooks trong React.
- Nắm vững các Hook dùng để tối ưu hóa hiệu năng và giải quyết các bài toán phức tạp.
- Cập nhật kiến thức về các Hook mới nhất được giới thiệu trong React 18.

---

## 🧑‍🏫 Bài 1: Side Effects và Hook `useEffect`

### Side Effect là gì?

Trong React, các component có nhiệm vụ chính là render UI dựa trên `props` và `state`. Bất kỳ hành động nào không liên quan trực tiếp đến việc render UI được gọi là **Side Effect**.

**Ví dụ về các Side Effects:**
- Lấy dữ liệu từ một API bên ngoài.
- Cập nhật tiêu đề của trang (`document.title`).
- Thiết lập và hủy các bộ đếm thời gian (`setTimeout`, `setInterval`).
- Tương tác trực tiếp với DOM.

`useEffect` là Hook cho phép bạn thực thi các side effects từ bên trong function components.

### Cú pháp cơ bản của `useEffect`

```jsx
import { useEffect } from 'react';

useEffect(() => {
  // Hàm này chứa mã của side effect
}, [dependencies]); // Mảng phụ thuộc
```
Sơ đồ mô phỏng:
```
[ Component Render ] ---> [ useEffect chạy ] ---> [ Thực thi Side Effect (ví dụ: gọi API) ]
```

---

## 🧑‍🏫 Bài 2: Mảng phụ thuộc (Dependency Array) trong `useEffect`

Mảng phụ thuộc quyết định **khi nào** effect sẽ được chạy lại.

### Trường hợp 1: Không có mảng phụ thuộc
Effect sẽ chạy **sau mỗi lần render**. Rất ít dùng và cần cẩn thận để tránh vòng lặp vô hạn.

### Trường hợp 2: Mảng rỗng `[]`
Effect chỉ chạy **một lần duy nhất** sau lần render đầu tiên. Đây là trường hợp phổ biến nhất để gọi API lấy dữ liệu ban đầu.

### Trường hợp 3: Mảng có giá trị `[prop, state]`
Effect sẽ chạy lần đầu, và **chạy lại mỗi khi** bất kỳ giá trị nào trong mảng phụ thuộc thay đổi.

---

## 🧑‍🏫 Bài 3: Lấy dữ liệu từ API (Data Fetching)

Đây là ứng dụng quan trọng nhất của `useEffect`. Chúng ta cần quản lý 3 trạng thái: dữ liệu, trạng thái tải, và lỗi.

### Quy trình lấy dữ liệu
1.  **Khởi tạo states**: `useState` cho `data`, `loading`, `error`.
2.  **Gọi `useEffect`**: Với mảng phụ thuộc `[]` để chỉ chạy một lần.
3.  **Bên trong `useEffect`**:
    -   Đặt `loading` thành `true`.
    -   Dùng `fetch` trong khối `try...catch`.
    -   `try`: Nếu thành công, cập nhật state `data`, đặt `loading` thành `false`.
    -   `catch`: Nếu thất bại, cập nhật state `error`, đặt `loading` thành `false`.

### Ví dụ hoàn chỉnh
```jsx
import { useState, useEffect } from 'react';

function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      setError(null);
      try {
        const response = await fetch(`https://jsonplaceholder.typicode.com/users/${userId}`);
        if (!response.ok) throw new Error('Network response was not ok');
        const data = await response.json();
        setUser(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, [userId]);

  if (loading) return <p>Đang tải...</p>;
  if (error) return <p>Lỗi: {error}</p>;

  return <div><h1>{user?.name}</h1><p>Email: {user?.email}</p></div>;
}
```

---

## 🧑‍🏫 Bài 4: Hàm dọn dẹp (Cleanup Function)

### Tại sao cần cleanup?
Một số side effects cần được "dọn dẹp" khi component bị gỡ khỏi DOM (unmount) để tránh rò rỉ bộ nhớ (memory leak). Ví dụ: hủy timer, gỡ event listener.

### Cách hoạt động
`useEffect` có thể trả về một hàm. Hàm này sẽ được React gọi khi component sắp bị unmount hoặc trước khi effect chạy lại.

```jsx
useEffect(() => {
  const timerId = setInterval(() => console.log('Tick'), 1000);
  // Hàm cleanup
  return () => clearInterval(timerId);
}, []);
```

---

## 🧑‍🏫 Bài 5: Cẩm nang React Hooks Chuyên sâu

Phần này sẽ đi sâu vào toàn bộ các Hooks quan trọng trong React, phân loại theo chức năng để bạn dễ dàng tham khảo và nắm vững.

### Nhóm 1: Hooks Cơ bản (State & Effects)
- **`useState`**: Hook cơ bản nhất, cho phép function component có state riêng.
- **`useEffect`**: Hook để thực thi các "side effect" như đã trình bày ở trên.

### Nhóm 2: Hooks về Context
- **`useContext`**: Cho phép component đọc giá trị từ một React Context mà không cần prop drilling (truyền props qua nhiều cấp). Rất hữu ích để chia sẻ dữ liệu "toàn cục" như theme, ngôn ngữ, thông tin người dùng.

```jsx
// 1. Tạo Context:
// const ThemeContext = createContext('light');

// 2. Cung cấp Context trong component cha:
// <ThemeContext.Provider value={theme}>...</ThemeContext.Provider>

// 3. Sử dụng Context trong component con:
// const theme = useContext(ThemeContext);
```

### Nhóm 3: Hooks về Tối ưu hóa Hiệu năng (Performance)
- **`useMemo`**: Ghi nhớ (memoize) **kết quả** của một phép tính tốn kém, chỉ tính lại khi phụ thuộc thay đổi. Dùng cho việc lọc/sắp xếp danh sách lớn.
  ```jsx
  const memoizedValue = useMemo(() => computeExpensiveValue(a, b), [a, b]);
  ```

- **`useCallback`**: Ghi nhớ (memoize) một **định nghĩa hàm**, giúp nó không bị tạo lại trên mỗi lần render. Rất quan trọng khi truyền hàm xuống các component con đã được tối ưu bằng `React.memo`.
  ```jsx
  const memoizedCallback = useCallback(() => { doSomething(a, b); }, [a, b]);
  ```
- **`React.memo`**: Một Higher-Order Component (HOC), không phải Hook. Nó bọc một component và ngăn component đó re-render nếu các `props` của nó không thay đổi.

### Nhóm 4: Hooks về Ref
- **`useRef`**: Tạo ra một object `{ current: ... }` tồn tại trong suốt vòng đời của component.
    1.  **Truy cập DOM**: `<input ref={myRef} />` để có thể gọi `myRef.current.focus()`.
    2.  **Lưu trữ giá trị**: Dùng để lưu một biến mà không gây re-render khi thay đổi (ví dụ: timer ID).

- **`forwardRef`**: HOC cho phép component nhận `ref` và "chuyển tiếp" nó xuống một phần tử con.
- **`useImperativeHandle`**: Dùng chung với `forwardRef` để tùy chỉnh "API" mà ref phơi ra cho component cha, thay vì phơi ra toàn bộ DOM node.

```jsx
// MyInput.js
const MyInput = forwardRef((props, ref) => {
  const inputRef = useRef();
  useImperativeHandle(ref, () => ({
    focus: () => { inputRef.current.focus(); } // Chỉ phơi ra hàm focus
  }));
  return <input ref={inputRef} {...props} />;
});
```

### Nhóm 5: Hooks Nâng cao & Ít dùng hơn
- **`useReducer`**: Một lựa chọn thay thế cho `useState` để quản lý state phức tạp, giúp tách biệt logic cập nhật state ra khỏi component.
  ```jsx
  const [state, dispatch] = useReducer(reducer, initialState);
  ```
- **`useLayoutEffect`**: Giống hệt `useEffect` về cú pháp, nhưng chạy **đồng bộ** sau khi DOM thay đổi và *trước khi* trình duyệt vẽ lên màn hình. Dùng để đọc layout DOM và thay đổi nó ngay lập tức để tránh hiện tượng "nhấp nháy".

### Nhóm 6: Hooks mới trong React 18+
- **`useId`**: Tạo ra một ID duy nhất và ổn định trên cả server và client, giải quyết vấn đề hydration mismatch trong Server-Side Rendering (SSR).
  ```jsx
  const id = useId();
  return <><label htmlFor={id}>...</label><input id={id} /></>;
  ```
- **`useTransition`**: Đánh dấu một cập nhật state là "không khẩn cấp" (transition), giúp UI luôn phản hồi trong khi các re-render chậm đang diễn ra.
  ```jsx
  const [isPending, startTransition] = useTransition();
  //...
  startTransition(() => {
    // Cập nhật state gây re-render chậm ở đây
  });
  ```
- **`useDeferredValue`**: Trì hoãn việc cập nhật một giá trị. Một cách tiếp cận đơn giản hơn `useTransition` để giữ cho UI mượt mà khi một giá trị nào đó gây ra re-render chậm.
  ```jsx
  const deferredQuery = useDeferredValue(query);
  // Dùng `deferredQuery` cho component render chậm.
  ```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Lấy dữ liệu sản phẩm động cho "SimpleStore"

### Mô tả bài toán
Nâng cấp trang "SimpleStore" để không còn sử dụng dữ liệu sản phẩm cứng trong code nữa. Thay vào đó, chúng ta sẽ lấy danh sách sản phẩm từ một API công khai.

### Yêu cầu
1.  **Chọn API**: Sử dụng API miễn phí `https://fakestoreapi.com/products` để lấy danh sách sản phẩm.
2.  **Quản lý State trong `App.jsx`**:
    -   Xóa mảng `products` cứng.
    -   Tạo 3 state mới: `products`, `loading`, `error`.
3.  **Sử dụng `useEffect`**:
    -   Trong `App.jsx`, viết một `useEffect` với mảng phụ thuộc rỗng `[]`.
    -   Bên trong effect, thực hiện việc gọi API đến `https://fakestoreapi.com/products`.
    -   Xử lý các trường hợp:
        -   Khi bắt đầu gọi, `setLoading(true)`.
        -   Nếu gọi thành công, `setProducts(data)` với dữ liệu nhận về.
        -   Nếu có lỗi, `setError(errorMessage)`.
        -   Cuối cùng, dù thành công hay thất bại, `setLoading(false)`.
4.  **Render có điều kiện**:
    -   Trong phần JSX của `App.jsx`, hiển thị giao diện dựa trên các state trên:
        -   Nếu `loading` là `true`, hiển thị một thông báo như `<div>Đang tải sản phẩm...</div>`.
        -   Nếu `error` có giá trị, hiển thị thông báo lỗi: `<div>Đã xảy ra lỗi: {error}</div>`.
        -   Nếu không loading và không có lỗi, render component `ProductList` và truyền `products` đã lấy được vào.
5.  **Cập nhật `ProductCard`**:
    -   Đảm bảo `ProductCard` của bạn nhận các props phù hợp với dữ liệu từ API (`title`, `price`, `image`).

**Mục tiêu:** Kết thúc phần này, "SimpleStore" sẽ trở thành một ứng dụng web động thực sự, có khả năng lấy và hiển thị dữ liệu từ internet, đồng thời xử lý các trạng thái tải và lỗi một cách chuyên nghiệp.
