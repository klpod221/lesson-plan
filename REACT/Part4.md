# 📘 PHẦN 4: REACT NÂNG CAO - QUẢN LÝ TRẠNG THÁI VÀ TỐI ƯU HÓA

- [📘 PHẦN 4: REACT NÂNG CAO - QUẢN LÝ TRẠNG THÁI VÀ TỐI ƯU HÓA](#-phần-4-react-nâng-cao---quản-lý-trạng-thái-và-tối-ưu-hóa)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Quản lý State toàn cục với Context API](#-bài-1-quản-lý-state-toàn-cục-với-context-api)
    - [Vấn đề: Prop Drilling](#vấn-đề-prop-drilling)
    - [Giải pháp: Context API](#giải-pháp-context-api)
    - [Ví dụ: Xây dựng Cart Context](#ví-dụ-xây-dựng-cart-context)
  - [🧑‍🏫 Bài 2: Tái sử dụng Logic với Custom Hooks](#-bài-2-tái-sử-dụng-logic-với-custom-hooks)
    - [Custom Hook là gì?](#custom-hook-là-gì)
    - [Ví dụ: Tạo hook `useFetch`](#ví-dụ-tạo-hook-usefetch)
  - [🧑‍🏫 Bài 3: Tối ưu hóa hiệu năng](#-bài-3-tối-ưu-hóa-hiệu-năng)
    - [Khi nào cần tối ưu?](#khi-nào-cần-tối-ưu)
    - [`React.memo` và `useCallback`](#reactmemo-và-usecallback)
    - [`useMemo` cho các tính toán phức tạp](#usememo-cho-các-tính-toán-phức-tạp)
  - [🧑‍🏫 Bài 4: Giới thiệu Routing với React Router](#-bài-4-giới-thiệu-routing-với-react-router)
    - [Single Page Application (SPA) và Routing](#single-page-application-spa-và-routing)
    - [Cài đặt và thiết lập cơ bản](#cài-đặt-và-thiết-lập-cơ-bản)
    - [Các thành phần cốt lõi](#các-thành-phần-cốt-lõi)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Hoàn thiện "SimpleStore" với các kỹ thuật nâng cao](#-bài-tập-lớn-cuối-phần-hoàn-thiện-simplestore-với-các-kỹ-thuật-nâng-cao)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Xây dựng và sử dụng Context API để quản lý trạng thái toàn cục một cách hiệu quả.
- Viết các Custom Hooks để đóng gói và tái sử dụng logic stateful.
- Áp dụng các kỹ thuật tối ưu hóa hiệu năng (`React.memo`, `useCallback`, `useMemo`) vào ứng dụng thực tế.
- Tích hợp React Router để tạo ra một ứng dụng đa trang (Single Page Application).
- Cấu trúc lại ứng dụng "SimpleStore" theo hướng module hóa, dễ bảo trì và mở rộng.

---

## 🧑‍🏫 Bài 1: Quản lý State toàn cục với Context API

### Vấn đề: Prop Drilling

Khi ứng dụng lớn dần, việc truyền state và các hàm xử lý từ component cha cao nhất xuống các component con sâu bên trong (qua nhiều cấp) trở nên rất cồng kềnh và khó bảo trì. Vấn đề này được gọi là **Prop Drilling**.

Sơ đồ Prop Drilling:
```
App (state) -> Page (props) -> Section (props) -> ComponentCầnDữLiệu (props)
```

### Giải pháp: Context API
Context API cung cấp một cách để chia sẻ dữ liệu giữa các component mà không cần phải truyền props một cách tường minh qua từng cấp của cây component.

Sơ đồ Context API:
```
App
 |
 V
[ Context Provider (cung cấp state) ]
 |
 +--> Page
 |     |
 |     +--> Section
 |           |
 |           +--> ComponentCầnDữLiệu (dùng useContext để lấy state trực tiếp)
 +--> AnotherComponent (cũng có thể lấy state từ Context)
```

### Ví dụ: Xây dựng Cart Context
Chúng ta sẽ tạo một context riêng để quản lý toàn bộ logic của giỏ hàng.

**1. Tạo Context và Provider (`src/context/CartContext.jsx`)**
```jsx
import { createContext, useContext, useReducer } from 'react';

// Reducer để xử lý logic giỏ hàng phức tạp
const cartReducer = (state, action) => {
  switch (action.type) {
    case 'ADD_ITEM':
      // logic thêm sản phẩm...
      // (kiểm tra nếu đã tồn tại, tăng số lượng)
      return { ...state, items: [...state.items, action.payload] };
    case 'REMOVE_ITEM':
      // logic xóa sản phẩm...
      return { ...state, items: state.items.filter(item => item.id !== action.payload.id) };
    default:
      return state;
  }
};

// 1. Tạo Context
const CartContext = createContext();

// 2. Tạo Provider Component
export function CartProvider({ children }) {
  const [state, dispatch] = useReducer(cartReducer, { items: [] });

  const value = {
    cartState: state,
    addToCart: (product) => dispatch({ type: 'ADD_ITEM', payload: product }),
    removeFromCart: (product) => dispatch({ type: 'REMOVE_ITEM', payload: product }),
  };

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
}

// 3. Tạo custom hook để sử dụng context dễ dàng hơn
export function useCart() {
  return useContext(CartContext);
}
```

**2. Bọc ứng dụng bằng Provider (`src/main.jsx` hoặc `App.jsx`)**
```jsx
import { CartProvider } from './context/CartContext';

//...
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <CartProvider>
      <App />
    </CartProvider>
  </React.StrictMode>
);
```

**3. Sử dụng trong bất kỳ component nào**
```jsx
// src/components/ProductCard.jsx
import { useCart } from '../context/CartContext';

function ProductCard({ product }) {
  const { addToCart } = useCart();

  return (
    <div>
      <h3>{product.title}</h3>
      <button onClick={() => addToCart(product)}>Thêm vào giỏ hàng</button>
    </div>
  );
}
```

---

## 🧑‍🏫 Bài 2: Tái sử dụng Logic với Custom Hooks

### Custom Hook là gì?
Là một hàm JavaScript có tên bắt đầu bằng `use` và có thể gọi các Hook khác bên trong nó. Custom Hook giúp chúng ta **trích xuất và tái sử dụng logic stateful** từ một component.

### Ví dụ: Tạo hook `useFetch`
Chúng ta có thể đóng gói logic lấy dữ liệu (bao gồm loading, data, error) từ Bài 3 vào một hook có thể tái sử dụng.

```jsx
// src/hooks/useFetch.js
import { useState, useEffect } from 'react';

export function useFetch(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    // Sử dụng AbortController để hủy request nếu component unmount
    const controller = new AbortController();
    const signal = controller.signal;

    const fetchData = async () => {
      setLoading(true);
      try {
        const response = await fetch(url, { signal });
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const result = await response.json();
        setData(result);
      } catch (err) {
        if (err.name !== 'AbortError') {
          setError(err.message);
        }
      } finally {
        setLoading(false);
      }
    };

    fetchData();

    // Cleanup function để hủy request
    return () => {
      controller.abort();
    };
  }, [url]); // Chạy lại khi url thay đổi

  return { data, loading, error };
}
```

**Sử dụng `useFetch`:**
```jsx
// src/components/ProductList.jsx
import { useFetch } from '../hooks/useFetch';

function ProductList() {
  const { data: products, loading, error } = useFetch('https://fakestoreapi.com/products');

  if (loading) return <p>Đang tải...</p>;
  if (error) return <p>Lỗi: {error}</p>;

  // ... render danh sách products
}
```
Code của component trở nên gọn gàng và dễ đọc hơn rất nhiều!

---

## 🧑‍🏫 Bài 3: Tối ưu hóa hiệu năng

### Khi nào cần tối ưu?
**Đừng tối ưu hóa sớm!** Chỉ tối ưu khi bạn nhận thấy ứng dụng có vấn đề về hiệu năng (ví dụ: UI bị giật, lag khi nhập liệu). React vốn đã rất nhanh.

### `React.memo` và `useCallback`
- `React.memo`: Bọc một component để nó chỉ render lại khi `props` thay đổi.
- `useCallback`: Ghi nhớ một hàm, đảm bảo nó không được tạo lại trên mỗi lần render, giúp `React.memo` hoạt động hiệu quả.

```jsx
// ProductCard.jsx (Component con)
import React from 'react';
const ProductCard = React.memo(({ product, onAddToCart }) => {
  console.log(`Rendering ProductCard: ${product.title}`);
  // ...
});

// ProductList.jsx (Component cha)
import { useCallback } from 'react';
// ...
const handleAddToCart = useCallback((product) => {
  // logic thêm vào giỏ hàng
}, []); // Mảng phụ thuộc rỗng nếu logic không phụ thuộc vào state/props khác

return (
  <div>
    {products.map(p => (
      <ProductCard key={p.id} product={p} onAddToCart={handleAddToCart} />
    ))}
  </div>
);
```
Bây giờ, `ProductCard` sẽ không bị render lại một cách không cần thiết khi `ProductList` render lại.

### `useMemo` cho các tính toán phức tạp
Dùng `useMemo` để ghi nhớ kết quả của một phép tính tốn kém, tránh tính toán lại trên mỗi lần render.

```jsx
function ProductList({ products, searchTerm }) {
  // Phép tính lọc danh sách có thể tốn kém nếu `products` rất lớn
  const filteredProducts = useMemo(() => {
    return products.filter(p =>
      p.title.toLowerCase().includes(searchTerm.toLowerCase())
    );
  }, [products, searchTerm]); // Chỉ tính lại khi products hoặc searchTerm thay đổi

  return (
    //... render `filteredProducts`
  );
}
```

---

## 🧑‍🏫 Bài 4: Giới thiệu Routing với React Router

### Single Page Application (SPA) và Routing
React tạo ra các SPA, nơi toàn bộ ứng dụng chạy trên một trang HTML duy nhất. React Router là thư viện phổ biến nhất giúp tạo ra các "trang" ảo, đồng bộ giao diện với URL trên thanh địa chỉ mà không cần tải lại toàn bộ trang.

### Cài đặt và thiết lập cơ bản
```bash
npm install react-router-dom
```

Bọc ứng dụng của bạn trong `BrowserRouter` (thường trong `src/main.jsx`).

```jsx
// src/main.jsx
import { BrowserRouter } from 'react-router-dom';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <BrowserRouter>
      {/* Các Provider khác như CartProvider có thể đặt ở đây */}
      <App />
    </BrowserRouter>
  </React.StrictMode>
);
```

### Các thành phần cốt lõi

- **`<Routes>`**: Bọc tất cả các route của bạn.
- **`<Route>`**: Định nghĩa một route.
    - `path`: Đường dẫn URL.
    - `element`: Component sẽ được render khi URL khớp.
- **`<Link>`**: Thay thế cho thẻ `<a>` để điều hướng nội bộ mà không reload trang.
- **`useParams`**: Hook để lấy các tham số động từ URL (ví dụ: `/products/:id`).

**Ví dụ trong `App.jsx`:**
```jsx
import { Routes, Route, Link } from 'react-router-dom';
import HomePage from './pages/HomePage';
import AboutPage from './pages/AboutPage';
import ProductDetailPage from './pages/ProductDetailPage';

function App() {
  return (
    <div>
      <nav>
        <Link to="/">Trang chủ</Link> | <Link to="/about">Giới thiệu</Link>
      </nav>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/about" element={<AboutPage />} />
        {/* Route động */}
        <Route path="/product/:productId" element={<ProductDetailPage />} />
      </Routes>
    </div>
  );
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Hoàn thiện "SimpleStore" với các kỹ thuật nâng cao

### Mô tả bài toán
Tái cấu trúc và nâng cấp toàn bộ ứng dụng "SimpleStore" để nó trở thành một SPA hoàn chỉnh, dễ bảo trì và tối ưu.

### Yêu cầu
1.  **Cấu trúc thư mục**: Sắp xếp lại code theo cấu trúc sau:
    -   `src/components`: Các component tái sử dụng (Button, Card, ...).
    -   `src/pages`: Các component đại diện cho một trang (HomePage, CartPage, ...).
    -   `src/context`: Nơi chứa các file context (CartContext.jsx).
    -   `src/hooks`: Nơi chứa các custom hook (useFetch.js).
2.  **Quản lý State Giỏ hàng**:
    -   Tạo `CartContext.jsx` như ví dụ ở Bài 1.
    -   Di chuyển toàn bộ logic quản lý giỏ hàng từ `App.jsx` vào `CartContext`.
    -   Sử dụng `useCart` hook trong các component cần tương tác với giỏ hàng.
3.  **Tái sử dụng Logic Fetch**:
    -   Tạo custom hook `useFetch.js` như ví dụ ở Bài 2.
    -   Sử dụng hook này trong trang danh sách sản phẩm để lấy dữ liệu.
4.  **Routing**:
    -   Cài đặt `react-router-dom`.
    -   Tạo ít nhất 3 trang:
        -   `HomePage.jsx`: Hiển thị danh sách tất cả sản phẩm.
        -   `ProductDetailPage.jsx`: Hiển thị chi tiết một sản phẩm khi click vào. Sử dụng `useParams` để lấy `productId` từ URL.
        -   `CartPage.jsx`: Hiển thị các sản phẩm có trong giỏ hàng.
    -   Tạo một component `Header.jsx` chứa các `Link` để điều hướng giữa các trang.
5.  **(Nâng cao) Tối ưu hóa**:
    -   Thêm chức năng tìm kiếm sản phẩm trong `HomePage`.
    -   Áp dụng `useMemo` để tính toán danh sách sản phẩm được lọc.
    -   Bọc `ProductCard` trong `React.memo` và sử dụng `useCallback` cho hàm "Thêm vào giỏ hàng" để ngăn re-render không cần thiết.

**Mục tiêu:** Kết thúc phần này, bạn sẽ có một dự án React hoàn chỉnh, được cấu trúc tốt, áp dụng các pattern hiện đại và sẵn sàng để mở rộng thêm các tính năng phức tạp hơn.
