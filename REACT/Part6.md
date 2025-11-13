# 📘 PHẦN 6: ROUTING VÀ DATA FETCHING NÂNG CAO TRONG NEXT.JS

## 🎯 Mục tiêu tổng quát

- Xây dựng các trang có URL động, ví dụ như trang chi tiết sản phẩm.
- Tận dụng các file `loading.jsx` và `error.jsx` của Next.js để cải thiện trải nghiệm người dùng.
- Hiểu sâu về cách Next.js quản lý việc fetch và cache dữ liệu trên server.
- Nắm vững các chiến lược revalidating dữ liệu (SSR, ISR) để cân bằng giữa hiệu năng và độ tươi mới của dữ liệu.
- Sử dụng các công cụ tối ưu hóa tích hợp sẵn của Next.js cho hình ảnh và fonts.

## 🧑‍🏫 Bài 1: Dynamic Routes (Route động)

### Tạo Route động

Để tạo các trang có URL thay đổi, ví dụ `/products/1`, `/products/2`, chúng ta sử dụng dấu ngoặc vuông `[]` trong tên thư mục.

- **Cấu trúc thư mục:** `src/app/products/[productId]/page.jsx`
- **URL tương ứng:**
  - `http://localhost:3000/products/1`
  - `http://localhost:3000/products/abc`
  - `http://localhost:3000/products/anything-here`

### Truy cập tham số (params)

Trong component `page.jsx` của route động, bạn có thể truy cập các tham số này qua `props`.

```jsx
// src/app/products/[productId]/page.jsx

// Đây là một Server Component, nên ta có thể làm nó thành async
async function getProduct(id) {
  const res = await fetch(`https://fakestoreapi.com/products/${id}`);
  return res.json();
}

// Props `params` sẽ chứa các tham số động từ URL
export default async function ProductDetailPage({ params }) {
  const { productId } = params; // productId khớp với tên thư mục [productId]
  const product = await getProduct(productId);

  return (
    <div>
      <h1>{product.title}</h1>
      <p>{product.description}</p>
      <p>Giá: ${product.price}</p>
    </div>
  );
}
```

### Tạo các trang tĩnh (generateStaticParams)

Mặc định, các trang động được render tại thời điểm request (on-demand). Tuy nhiên, nếu bạn biết trước danh sách các `productId` (ví dụ: có 20 sản phẩm), bạn có thể bảo Next.js **tạo sẵn (pre-render)** tất cả các trang này tại thời điểm build. Điều này giúp trang tải nhanh hơn rất nhiều.

Để làm điều này, export một hàm `async` tên là `generateStaticParams`.

```jsx
// src/app/products/[productId]/page.jsx

// ... (component ProductDetailPage vẫn như trên)

// Hàm này sẽ chạy tại thời điểm build
export async function generateStaticParams() {
  const res = await fetch('https://fakestoreapi.com/products');
  const products = await res.json();

  // Trả về một mảng các object `params`
  // Next.js sẽ lặp qua mảng này và tạo trang cho mỗi `params`
  return products.map((product) => ({
    productId: product.id.toString(), // Phải là chuỗi
  }));
}
```

**Kết quả:** Next.js sẽ tạo ra các file HTML tĩnh như `/products/1.html`, `/products/2.html`,... sẵn sàng để phục vụ ngay lập tức.

## 🧑‍🏫 Bài 2: Các UI đặc biệt: Loading và Error

Next.js cung cấp một cách rất thanh lịch để xử lý trạng thái tải và lỗi bằng cách sử dụng các file đặc biệt, tận dụng **React Suspense**.

### Giao diện tải tức thì (Instant Loading UI)

Khi người dùng điều hướng đến một trang cần thời gian để fetch dữ liệu, Next.js có thể hiển thị ngay lập tức một UI tải tạm thời.

- **Cách làm:** Tạo một file `loading.jsx` trong cùng thư mục với `page.jsx`.
- **Ví dụ:** `src/app/products/[productId]/loading.jsx`

```jsx
// src/app/products/[productId]/loading.jsx
export default function Loading() {
  // Bạn có thể tạo một component skeleton (khung xương) đẹp mắt
  return (
    <div>
      <div className="skeleton h-12 w-1/2 mb-4"></div>
      <div className="skeleton h-4 w-full mb-2"></div>
      <div className="skeleton h-4 w-full mb-2"></div>
      <div className="skeleton h-6 w-1/4 mt-4"></div>
    </div>
  );
}
```

**Luồng hoạt động:**

1. Người dùng click vào link `/products/1`.
2. Next.js hiển thị ngay lập tức `loading.jsx`.
3. Đồng thời, ở phía server, Next.js bắt đầu chạy `page.jsx` để fetch dữ liệu.
4. Khi dữ liệu fetch xong, `loading.jsx` được thay thế bằng nội dung của `page.jsx`.

### Xử lý lỗi với `error.jsx`

Tương tự, bạn có thể tạo một UI để xử lý các lỗi xảy ra trong một route.

- **Cách làm:** Tạo một file `error.jsx` trong cùng thư mục.
- **Lưu ý:** `error.jsx` bắt buộc phải là một **Client Component** (`"use client"`).

```jsx
// src/app/products/[productId]/error.jsx
"use client"; // Bắt buộc

import { useEffect } from 'react';

export default function Error({ error, reset }) {
  useEffect(() => {
    // Ghi lại lỗi vào một dịch vụ log, ví dụ Sentry
    console.error(error);
  }, [error]);

  return (
    <div>
      <h2>Đã có lỗi xảy ra!</h2>
      <button
        onClick={
          // Thử render lại route segment
          () => reset()
        }
      >
        Thử lại
      </button>
    </div>
  );
}
```

## 🧑‍🏫 Bài 3: Data Fetching, Caching và Revalidating

### Cách `fetch` hoạt động trong Next.js

Next.js mở rộng hàm `fetch` gốc, cho phép bạn cấu hình việc caching cho từng request.

### Chiến lược 1: Dữ liệu tĩnh (Mặc định)

Mặc định, Next.js sẽ cache kết quả của `fetch` vô thời hạn. Điều này tương đương với **Static Site Generation (SSG)**.

```jsx
// fetch mặc định, kết quả sẽ được cache
const res = await fetch('https://fakestoreapi.com/products');

// Tương đương với:
// const res = await fetch('...', { cache: 'force-cache' });
```

- **Khi nào dùng:** Dữ liệu hiếm khi thay đổi (bài viết blog, trang giới thiệu).
- **Lợi ích:** Cực kỳ nhanh, giảm tải cho server.

### Chiến lược 2: Dữ liệu động (SSR)

Để buộc `fetch` lấy dữ liệu mới mỗi khi có request, hãy tắt cache. Điều này tương đương với **Server-Side Rendering (SSR)**.

```jsx
const res = await fetch('https://fakestoreapi.com/products', {
  cache: 'no-store',
});
```

- **Khi nào dùng:** Dữ liệu thay đổi liên tục và phải luôn mới nhất (danh sách tin tức, giá cổ phiếu).
- **Nhược điểm:** Chậm hơn vì server phải làm việc cho mỗi request.

### Chiến lược 3: Dữ liệu được xác thực lại (ISR)

Đây là sự kết hợp tốt nhất của hai chiến lược trên. Next.js sẽ phục vụ dữ liệu từ cache, nhưng sau một khoảng thời gian nhất định, nó sẽ kiểm tra lại (revalidate) để lấy dữ liệu mới.

```jsx
const res = await fetch('https://fakestoreapi.com/products', {
  next: { revalidate: 3600 }, // Revalidate sau mỗi 1 giờ (3600 giây)
});
```

- **Luồng hoạt động (với `revalidate: 60`):**
    1. **Request 1:** Dữ liệu được fetch, cache lại, và hiển thị cho người dùng.
    2. **Request 2 (trong vòng 60s):** Dữ liệu cũ từ cache được trả về ngay lập tức.
    3. **Request 3 (sau 60s):** Dữ liệu cũ từ cache vẫn được trả về ngay lập tức. **Đồng thời**, ở phía server, Next.js fetch dữ liệu mới và cập nhật cache.
    4. **Request 4:** Người dùng sẽ thấy dữ liệu đã được làm mới.
- **Khi nào dùng:** Hầu hết các trường hợp! Dữ liệu không cần real-time nhưng vẫn cần được cập nhật định kỳ (danh sách sản phẩm, bình luận).

## 🧑‍🏫 Bài 4: Tối ưu hóa Hình ảnh và Fonts

### Component `<Image>`

Không bao giờ dùng thẻ `<img>` thường trong Next.js. Hãy dùng component `<Image>` từ `next/image`.

- **Tự động tối ưu hóa:** Nén ảnh, chuyển đổi sang định dạng hiện đại (WebP), thay đổi kích thước ảnh phù hợp với thiết bị.
- **Lazy Loading:** Ảnh chỉ được tải khi nó sắp vào trong tầm nhìn của người dùng.
- **Chống Layout Shift:** Tự động giữ chỗ cho ảnh để trang không bị "nhảy" khi ảnh tải xong.

```jsx
import Image from 'next/image';

<Image
  src={product.image} // URL ảnh
  alt={product.title}
  width={500}         // Bắt buộc
  height={500}        // Bắt buộc
  className="object-cover"
/>
```

### `next/font`

Công cụ này giúp bạn dễ dàng sử dụng Google Fonts hoặc font tùy chỉnh mà không làm ảnh hưởng đến hiệu năng.

- **Tự động host font:** Font sẽ được tải từ chính domain của bạn, không cần request ra ngoài.
- **Không gây Layout Shift.**

```jsx
// src/app/layout.jsx
import { Inter } from 'next/font/google';

const inter = Inter({ subsets: ['latin'] });

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  );
}
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Hoàn thiện luồng sản phẩm cho "SimpleStore"

### Mô tả bài toán

Nâng cấp "SimpleStore" để có trang chi tiết sản phẩm động, xử lý trạng thái tải/lỗi mượt mà, và tối ưu hóa hiệu năng bằng các tính năng sẵn có của Next.js.

### Yêu cầu

1. **Tạo trang chi tiết sản phẩm**:
    - Tạo cấu trúc route động: `src/app/products/[productId]/page.jsx`.
    - Trong `page.jsx`, sử dụng `params` để lấy `productId` và fetch dữ liệu cho sản phẩm đó.
    - Hiển thị thông tin chi tiết của sản phẩm (hình ảnh, tên, mô tả, giá).
2. **Link từ trang chủ**:
    - Trên trang chủ, bọc mỗi `ProductCard` trong một component `<Link>` từ `next/link` để nó điều hướng đến trang chi tiết tương ứng. Ví dụ: `<Link href={\`/products/${product.id}\`}>`.
3. **Thêm Loading và Error UI**:
    - Tạo file `src/app/products/[productId]/loading.jsx` với một giao diện skeleton đẹp mắt.
    - Tạo file `src/app/products/[productId]/error.jsx` để xử lý trường hợp không tìm thấy sản phẩm hoặc API lỗi.
4. **Tối ưu hóa Data Fetching**:
    - Trên trang chủ (`/`), sử dụng chiến lược **ISR** cho danh sách sản phẩm. Đặt `revalidate` là 1 giờ (`3600`).
    - Trên trang chi tiết sản phẩm (`/products/[productId]`), sử dụng `generateStaticParams` để Next.js tạo sẵn các trang sản phẩm tại thời điểm build, giúp tải trang gần như tức thì.
5. **Tối ưu hóa hình ảnh**:
    - Thay thế tất cả các thẻ `<img>` trong dự án bằng component `<Image>` của `next/image`. Đảm bảo cung cấp `width` và `height` hợp lệ.

**Mục tiêu**: Kết thúc phần này, ứng dụng "SimpleStore" của bạn sẽ có trải nghiệm người dùng cực kỳ tốt: điều hướng nhanh, có trạng thái tải rõ ràng, xử lý lỗi mượt mà, và được tối ưu hóa hiệu năng từ server đến client.
