# 📘 PHẦN 5: NHẬP MÔN NEXT.JS VÀ APP ROUTER

## 🎯 Mục tiêu tổng quát

- Hiểu được Next.js là gì và những lợi ích cốt lõi mà nó mang lại so với một ứng dụng React thông thường (SEO, hiệu năng, ...).
- Nắm vững mô hình App Router mới của Next.js, bao gồm routing dựa trên thư mục và layouts.
- Phân biệt và hiểu rõ hai khái niệm nền tảng: Server Components và Client Components.
- Biết cách thiết lập một dự án Next.js và di chuyển một ứng dụng React đã có sang cấu trúc Next.js.

## 🧑‍🏫 Bài 1: Tại sao lại là Next.js?

### Next.js là gì?

Next.js không phải là một sự thay thế cho React. Thay vào đó, nó là một **Framework xây dựng trên nền tảng React**. Nó cung cấp cho bạn các công cụ, quy ước và tối ưu hóa sẵn có để xây dựng các ứng dụng React sẵn sàng cho môi trường production một cách dễ dàng hơn.

### Các vấn đề React SPA (Single Page App) gặp phải

Một ứng dụng React tạo bằng `create-react-app` hay `Vite` mặc định là một SPA, render ở phía client (Client-Side Rendering - CSR). Điều này có một số nhược điểm:

1. **SEO kém**: Các công cụ tìm kiếm (Google bot) ban đầu chỉ nhận được một file HTML trống với một thẻ `<div id="root"></div>` và một file JavaScript lớn. Chúng phải chạy JavaScript để thấy được nội dung, điều này làm giảm khả năng SEO.
2. **Thời gian tải ban đầu chậm**: Người dùng phải tải toàn bộ JavaScript của trang về, sau đó React mới chạy để render ra HTML. Với kết nối mạng chậm, người dùng sẽ nhìn thấy một trang trắng trong thời gian dài.

### Giải pháp của Next.js: Các chiến lược Rendering

Next.js giải quyết các vấn đề trên bằng cách cung cấp các chiến lược rendering phía server.

Sơ đồ so sánh CSR và SSR:

```text
// Client-Side Rendering (React SPA)
1. Browser yêu cầu trang.
2. Server trả về file HTML gần như trống + file JS lớn.
3. Browser tải file JS.
4. Browser chạy React (JS) để render nội dung.
5. Người dùng thấy nội dung. (Có độ trễ)

// Server-Side Rendering (Next.js)
1. Browser yêu cầu trang.
2. Server chạy React, tạo ra file HTML đầy đủ nội dung.
3. Server trả về file HTML đầy đủ đó.
4. Browser hiển thị ngay lập tức nội dung. (Nhanh hơn)
5. Browser tải file JS nhỏ hơn để trang có tính tương tác ("hydration").
```

Next.js hỗ trợ:

- **Server-Side Rendering (SSR)**: HTML được tạo ra trên server cho mỗi request.
- **Static Site Generation (SSG)**: HTML được tạo ra tại thời điểm build. Cực nhanh!
- **Incremental Static Regeneration (ISR)**: Kết hợp SSG và SSR, cho phép cập nhật trang tĩnh mà không cần build lại toàn bộ site.

## 🧑‍🏫 Bài 2: Thiết lập và cấu trúc dự án Next.js

### Khởi tạo dự án

Next.js cung cấp một công cụ CLI để tạo dự án nhanh chóng.

```bash
npx create-next-app@latest
```

Trong quá trình cài đặt, hãy chọn các tùy chọn sau để phù hợp với lộ trình học:

- `What is your project named?` -> `simplestore-nextjs`
- `Would you like to use TypeScript?` -> **No**
- `Would you inlike to use ESLint?` -> **Yes**
- `Would you like to use Tailwind CSS?` -> **Yes** (Rất hữu ích cho styling)
- `Would you like to use 'src/' directory?` -> **Yes** (Giúp tổ chức code tốt hơn)
- `Would you like to use App Router?` -> **Yes** (Đây là mô hình mới và là trọng tâm)
- `Would you like to customize the default import alias?` -> **No** (Giữ mặc định `@/*`)

### Cấu trúc thư mục App Router

- `src/app/`: Thư mục quan trọng nhất, chứa toàn bộ các route và UI của ứng dụng.
  - `layout.jsx`: **Root Layout**, file bắt buộc, bao bọc toàn bộ ứng dụng.
  - `page.jsx`: **Homepage**, UI cho route `/`.
- `src/components/`: Thư mục chúng ta tự tạo để chứa các component tái sử dụng.
- `public/`: Chứa các tài sản tĩnh như hình ảnh, fonts.

## 🧑‍🏫 Bài 3: File-based Routing và Layouts

### Routing dựa trên thư mục

Trong App Router, bạn không cần cài đặt thư viện như `react-router-dom`. Các đường dẫn URL được quyết định bởi cấu trúc thư mục bên trong `src/app/`.

- Mỗi **thư mục** đại diện cho một **phân đoạn URL**.
- Một file tên là `page.jsx` bên trong thư mục đó sẽ định nghĩa UI cho phân đoạn đó.

Ví dụ:

- `src/app/page.jsx` -> `http://localhost:3000/`
- `src/app/about/page.jsx` -> `http://localhost:3000/about`
- `src/app/dashboard/settings/page.jsx` -> `http://localhost:3000/dashboard/settings`

### Layouts lồng nhau

Một file `layout.jsx` sẽ bao bọc tất cả các trang con và layout con bên trong nó.

Sơ đồ cấu trúc Layouts:

```text
[ src/app/layout.jsx (Root Layout) ]
  <html>
    <body>
      <Header />
      {children}  <-- Đây là nơi các trang con được render
      <Footer />
    </body>
  </html>
      |
      V
[ src/app/dashboard/layout.jsx (Dashboard Layout) ]
  <section>
    <Sidebar />
    {children}  <-- Đây là nơi page.jsx của dashboard render
  </section>
      |
      V
[ src/app/dashboard/settings/page.jsx (Settings Page) ]
  <h1>Cài đặt</h1>
```

Khi bạn truy cập `/dashboard/settings`, cả 3 file trên sẽ được kết hợp để tạo ra UI cuối cùng.

### Các file đặc biệt: `page.jsx`, `layout.jsx`

- `page.jsx`: Bắt buộc phải có để một route có thể truy cập được.
- `layout.jsx`: Tùy chọn, dùng để chia sẻ UI chung cho một nhóm các trang.

## 🧑‍🏫 Bài 4: Server Components vs. Client Components

### Một sự thay đổi lớn trong tư duy

Đây là khái niệm cốt lõi và mạnh mẽ nhất của App Router. Mọi component trong thư mục `app` **mặc định là Server Component**.

### Server Components (Mặc định)

- **Chạy hoàn toàn trên server.** Code của chúng không bao giờ được gửi xuống trình duyệt.
- **Ưu điểm:**
  - **Bảo mật**: Có thể truy cập trực tiếp vào database, API keys mà không sợ lộ ra phía client.
  - **Hiệu năng**: Giảm lượng JavaScript cần tải về, giúp trang tải nhanh hơn.
  - **Lấy dữ liệu đơn giản**: Có thể dùng `async/await` trực tiếp trong component.
- **Nhược điểm:**
  - **Không có tính tương tác**: Không thể dùng Hooks như `useState`, `useEffect`.
  - **Không có sự kiện**: Không thể dùng `onClick`, `onChange`, ...

```jsx
// src/app/page.jsx (Đây là một Server Component)
async function getProducts() {
  const res = await fetch('https://fakestoreapi.com/products');
  return res.json();
}

export default async function HomePage() {
  const products = await getProducts(); // Lấy dữ liệu trực tiếp

  return (
    <main>
      <h1>Danh sách sản phẩm</h1>
      {/* ... render products */}
    </main>
  );
}
```

### Client Components (`"use client"`)

Để thêm tính tương tác, bạn cần "chuyển đổi" một component thành Client Component.

- **Cách làm**: Thêm chỉ thị `"use client";` ở dòng đầu tiên của file.
- **Đặc điểm**:
  - Hoạt động giống hệt các component React truyền thống.
  - Có thể sử dụng `useState`, `useEffect`, và các sự kiện.
  - Code của chúng sẽ được gửi xuống trình duyệt.

```jsx
// src/components/Counter.jsx
"use client"; // Đánh dấu đây là Client Component

import { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      Clicked {count} times
    </button>
  );
}
```

### Khi nào dùng cái nào?

- **Server Component (Mặc định):** Dùng cho mọi thứ không cần tương tác. Hiển thị dữ liệu, layout tĩnh, trang tĩnh...
- **Client Component (`"use client";`):** Chỉ dùng khi bạn cần:
  - Sự kiện (`onClick`, `onChange`...)
  - State và Vòng đời (`useState`, `useEffect`, `useReducer`...)
  - Sử dụng các API chỉ có ở trình duyệt (ví dụ: `localStorage`).
- **Nguyên tắc**: Giữ các Client Component nhỏ nhất có thể và đẩy chúng xuống sâu trong cây component. Ví dụ: Thay vì biến toàn bộ trang sản phẩm thành Client Component, chỉ biến cái nút "Thêm vào giỏ" thành Client Component.

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Di chuyển "SimpleStore" sang Next.js

### Mô tả bài toán

Xây dựng lại dự án "SimpleStore" từ đầu bằng Next.js và mô hình App Router, áp dụng các kiến thức đã học về Server/Client Components và routing.

### Yêu cầu

1. **Thiết lập dự án**: Tạo một dự án Next.js mới tên là `simplestore-nextjs` với các tùy chọn đã hướng dẫn.
2. **Di chuyển Components**:
    - Copy các component từ dự án React cũ (`Header`, `ProductCard`, ...) vào thư mục `src/components` của dự án mới.
    - Xác định các component cần tính tương tác (ví dụ: `ProductCard` có nút "Thêm vào giỏ", `Header` cần hiển thị số lượng trong giỏ hàng) và thêm `"use client";` vào đầu các file đó.
3. **Xây dựng Routing và Layouts**:
    - Trong `src/app/layout.jsx`, thiết lập layout gốc cho toàn bộ ứng dụng (thẻ `<html>`, `<body>`). Import và đặt component `Header` vào đây để nó được chia sẻ trên mọi trang.
    - Trong `src/app/page.jsx`, xây dựng trang chủ hiển thị danh sách sản phẩm.
4. **Lấy dữ liệu kiểu Next.js**:
    - Trong `src/app/page.jsx` (là một Server Component), hãy xóa custom hook `useFetch`.
    - Sử dụng `async/await` trực tiếp trong component `HomePage` để gọi API và lấy danh sách sản phẩm như ví dụ ở trên.
5. **Xử lý Context Provider**:
    - Context Provider (như `CartProvider`) bắt buộc phải chạy trong một Client Component vì nó dùng `useReducer`.
    - Tạo một file mới `src/context/ClientProviders.jsx`. Trong file này, thêm `"use client";`, import `CartProvider` và tạo một component mới bao bọc `children` bằng `CartProvider`.

        ```jsx
        // src/context/ClientProviders.jsx
        "use client";
        import { CartProvider } from './CartContext'; // Giả sử CartContext đã được copy qua

        export function ClientProviders({ children }) {
          return <CartProvider>{children}</CartProvider>;
        }
        ```

    - Trong `src/app/layout.jsx` (Server Component), import và sử dụng `ClientProviders` để bọc `{children}`. Điều này cho phép bạn cung cấp context cho toàn bộ ứng dụng mà vẫn giữ layout là một Server Component.

**Mục tiêu**: Kết thúc phần này, bạn sẽ có một phiên bản "SimpleStore" chạy trên Next.js, tận dụng được sức mạnh của Server-Side Rendering để tải trang nhanh hơn, và hiểu rõ cách cân bằng giữa Server và Client Components.
