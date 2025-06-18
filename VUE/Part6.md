# 📘 PHẦN 6: NUXT.JS NÂNG CAO - SERVER, AUTHENTICATION VÀ TRIỂN KHAI

- [📘 PHẦN 6: NUXT.JS NÂNG CAO - SERVER, AUTHENTICATION VÀ TRIỂN KHAI](#-phần-6-nuxtjs-nâng-cao---server-authentication-và-triển-khai)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Xây dựng API với Server Routes](#-bài-1-xây-dựng-api-với-server-routes)
    - [Thư mục `server/`](#thư-mục-server)
    - [Tạo API Endpoint](#tạo-api-endpoint)
    - [Gọi API từ phía client](#gọi-api-từ-phía-client)
  - [🧑‍🏫 Bài 2: Middleware - Can thiệp vào quá trình điều hướng](#-bài-2-middleware---can-thiệp-vào-quá-trình-điều-hướng)
    - [Middleware là gì?](#middleware-là-gì)
    - [Các loại Middleware trong Nuxt](#các-loại-middleware-trong-nuxt)
    - [Ví dụ: Middleware bảo vệ Route](#ví-dụ-middleware-bảo-vệ-route)
  - [🧑‍🏫 Bài 3: Giới thiệu về Authentication](#-bài-3-giới-thiệu-về-authentication)
    - [Các phương pháp xác thực](#các-phương-pháp-xác-thực)
    - [Giải pháp cho Nuxt: Sidebase/nuxt-auth](#giải-pháp-cho-nuxt-sidebasenuxt-auth)
    - [Thiết lập cơ bản](#thiết-lập-cơ-bản)
    - [Sử dụng session trong component](#sử-dụng-session-trong-component)
  - [🧑‍🏫 Bài 4: Tối ưu hóa SEO và Metadata](#-bài-4-tối-ưu-hóa-seo-và-metadata)
    - [Tại sao SEO quan trọng?](#tại-sao-seo-quan-trọng)
    - [Sử dụng `useHead`](#sử-dụng-usehead)
    - [Tạo metadata động](#tạo-metadata-động)
  - [🧑‍🏫 Bài 5: Triển khai ứng dụng (Deployment)](#-bài-5-triển-khai-ứng-dụng-deployment)
    - [Các lựa chọn Hosting](#các-lựa-chọn-hosting)
    - [Triển khai lên Vercel](#triển-khai-lên-vercel)
    - [Biến môi trường (Environment Variables)](#biến-môi-trường-environment-variables)
  - [🧪 BÀI TẬP LỚN CUỐI CÙNG: Hoàn thiện "SimpleStore" và đưa lên mạng](#-bài-tập-lớn-cuối-cùng-hoàn-thiện-simplestore-và-đưa-lên-mạng)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Xây dựng các API endpoint của riêng mình ngay bên trong ứng dụng Nuxt.
- Sử dụng middleware để thực thi logic trước khi điều hướng đến một trang, ví dụ như kiểm tra quyền truy cập.
- Tích hợp một giải pháp xác thực người dùng hoàn chỉnh.
- Quản lý metadata của trang (title, description) để tối ưu hóa SEO.
- Triển khai thành công ứng dụng Nuxt lên một nền tảng hosting hiện đại.

---

## 🧑‍🏫 Bài 1: Xây dựng API với Server Routes

### Thư mục `server/`
Nuxt cho phép bạn xây dựng một backend hoàn chỉnh ngay bên trong dự án của mình thông qua thư mục `server/`. Mọi file trong `server/api/` sẽ tự động được ánh xạ thành một API endpoint.

### Tạo API Endpoint
Tạo một file trong `server/api/`. Tên file sẽ quyết định URL.

**Ví dụ: `server/api/hello.js`**
```javascript
// `defineEventHandler` là một hàm tiện ích của Nuxt
export default defineEventHandler((event) => {
  // `event` chứa thông tin về request (headers, params, ...)
  
  // Trả về dữ liệu JSON
  return {
    message: 'Chào bạn từ API của Nuxt!',
  };
});
```
Endpoint này sẽ có thể truy cập được tại `http://localhost:3000/api/hello`.

**Ví dụ với tham số động: `server/api/products/[id].js`**
```javascript
export default defineEventHandler((event) => {
  // Lấy `id` từ params
  const productId = event.context.params.id;

  // Giả lập việc lấy dữ liệu từ database
  if (productId === '1') {
    return { id: 1, name: 'Laptop Pro', price: 30000000 };
  } else {
    // Xử lý trường hợp không tìm thấy
    throw createError({
      statusCode: 404,
      statusMessage: 'Sản phẩm không tồn tại',
    });
  }
});
```

### Gọi API từ phía client
Bạn có thể dùng `useFetch` để gọi chính các API bạn vừa tạo.

```vue
<script setup>
const { data, error } = await useFetch('/api/hello');
</script>
<template>
  <p>{{ data?.message }}</p>
</template>
```

---

## 🧑‍🏫 Bài 2: Middleware - Can thiệp vào quá trình điều hướng

### Middleware là gì?
Là các đoạn code chạy trước khi người dùng được điều hướng đến một trang cụ thể. Chúng rất hữu ích để kiểm tra quyền, chuyển hướng, hoặc sửa đổi request.

### Các loại Middleware trong Nuxt
1.  **Inline Middleware**: Định nghĩa trực tiếp trong trang sử dụng `definePageMeta`.
2.  **Named Middleware**: Định nghĩa trong thư mục `middleware/`, có thể tái sử dụng ở nhiều trang.
3.  **Global Middleware**: Đặt tên file có đuôi `.global.js` trong `middleware/`, sẽ tự động chạy trên mọi route.

### Ví dụ: Middleware bảo vệ Route
1.  **Tạo file `middleware/auth.js`:**
    ```javascript
    // middleware/auth.js
    
    // `to` là route người dùng đang muốn đến
    // `from` là route người dùng đến từ
    export default defineNuxtRouteMiddleware((to, from) => {
      // Giả lập logic kiểm tra đăng nhập
      const isLoggedIn = false; // Thay bằng logic thật
      
      // Nếu người dùng chưa đăng nhập và đang cố vào trang dashboard
      if (!isLoggedIn && to.path === '/dashboard') {
        // Chuyển hướng về trang đăng nhập
        return navigateTo('/login');
      }
    });
    ```
2.  **Áp dụng vào trang:**
    ```vue
    <!-- pages/dashboard.vue -->
    <script setup>
    definePageMeta({
      middleware: 'auth'
      // Hoặc nhiều middleware: middleware: ['auth', 'analytics']
    });
    </script>
    ```

---

## 🧑‍🏫 Bài 3: Giới thiệu về Authentication

### Các phương pháp xác thực
Tương tự như trong hệ sinh thái React, các phương pháp phổ biến là Cookie-based, Token-based (JWT) và OAuth.

### Giải pháp cho Nuxt: Sidebase/nuxt-auth
Đây là một module cộng đồng mạnh mẽ, lấy cảm hứng từ NextAuth.js, giúp việc tích hợp xác thực vào Nuxt trở nên dễ dàng.
*Website: [https://sidebase.io/nuxt-auth/getting-started](https://sidebase.io/nuxt-auth/getting-started)*

### Thiết lập cơ bản
1.  **Cài đặt:** `npm install --save-dev @sidebase/nuxt-auth`
2.  **Cấu hình trong `nuxt.config.ts`:**
    ```typescript
    export default defineNuxtConfig({
      modules: ['@sidebase/nuxt-auth'],
      auth: {
        // Cấu hình các provider (ví dụ: GitHub)
      }
    })
    ```
3.  **Tạo API route để xử lý:** `server/api/auth/[...].ts`
    Đây là nơi `nuxt-auth` sẽ xử lý các request đăng nhập, đăng xuất, lấy session...

### Sử dụng session trong component
Module này cung cấp composable `useAuth` để bạn có thể lấy thông tin người dùng.

```vue
<script setup>
const { status, data: session, signIn, signOut } = useAuth();
// status: 'authenticated', 'unauthenticated', 'loading'
// session: chứa thông tin người dùng
</script>

<template>
  <div>
    <div v-if="status === 'authenticated'">
      <p>Xin chào, {{ session.user.name }}</p>
      <button @click="signOut()">Đăng xuất</button>
    </div>
    <div v-else>
      <p>Bạn chưa đăng nhập.</p>
      <button @click="signIn('github')">Đăng nhập với GitHub</button>
    </div>
  </div>
</template>
```

---

## 🧑‍🏫 Bài 4: Tối ưu hóa SEO và Metadata

### Tại sao SEO quan trọng?
Nuxt render trên server, giúp các công cụ tìm kiếm (Google, Bing) có thể đọc nội dung trang của bạn một cách dễ dàng, cải thiện thứ hạng tìm kiếm. Để làm điều này hiệu quả, bạn cần cung cấp metadata (dữ liệu mô tả) cho mỗi trang.

### Sử dụng `useHead`
Nuxt cung cấp composable `useHead` để bạn có thể quản lý các thẻ trong `<head>` của trang (như `title`, `meta`).

```vue
<!-- pages/about.vue -->
<script setup>
useHead({
  title: 'Giới thiệu | SimpleStore',
  meta: [
    { name: 'description', content: 'Tìm hiểu về cửa hàng của chúng tôi.' }
  ]
})
</script>
```

### Tạo metadata động
Bạn có thể kết hợp `useFetch` và `useHead` để tạo title và description động cho các trang chi tiết.

```vue
<!-- pages/products/[id].vue -->
<script setup>
const route = useRoute();
const { data: product } = await useFetch(`/api/products/${route.params.id}`);

// Cập nhật <head> với dữ liệu từ sản phẩm
if (product.value) {
  useHead({
    title: `${product.value.name} | SimpleStore`,
    meta: [
      { name: 'description', content: product.value.description }
    ]
  });
}
</script>
```

---

## 🧑‍🏫 Bài 5: Triển khai ứng dụng (Deployment)

### Các lựa chọn Hosting
Nuxt có thể được triển khai trên nhiều nền tảng:
-   **Vercel:** Hỗ trợ tốt nhất, tích hợp hoàn hảo.
-   **Netlify:** Một lựa chọn phổ biến khác.
-   **Cloudflare Pages, Render, Heroku...**
-   **Tự host trên server riêng (Node.js).**

### Triển khai lên Vercel
Quy trình tương tự Next.js:
1.  Push code lên GitHub.
2.  Đăng ký tài khoản Vercel và kết nối với GitHub.
3.  Import project từ repository.
4.  Cấu hình biến môi trường.
5.  Nhấn "Deploy".

Vercel sẽ tự động nhận diện đây là một dự án Nuxt và build nó một cách chính xác.

### Biến môi trường (Environment Variables)
-   Trong Nuxt, bạn định nghĩa chúng trong file `.env` ở thư mục gốc.
-   Phân biệt biến chỉ dùng ở server và biến có thể truy cập ở client.
    -   `API_SECRET=...` (Chỉ có ở server)
    -   `NUXT_PUBLIC_API_BASE=...` (Tiền tố `NUXT_PUBLIC_` cho phép truy cập ở client)
-   Truy cập trong code qua `process.env`.

---

## 🧪 BÀI TẬP LỚN CUỐI CÙNG: Hoàn thiện "SimpleStore" và đưa lên mạng

### Mô tả bài toán
Thêm các tính năng cuối cùng vào "SimpleStore" để nó trở thành một ứng dụng full-stack hoàn chỉnh: có API riêng, xác thực người dùng và được tối ưu hóa SEO. Cuối cùng, triển khai ứng dụng.

### Yêu cầu
1.  **Xây dựng API riêng**:
    -   Di chuyển logic lấy dữ liệu từ `fakestoreapi.com` vào trong `server/api/` của bạn. Tạo các endpoint:
        -   `server/api/products/index.js` (lấy danh sách sản phẩm)
        -   `server/api/products/[id].js` (lấy chi tiết sản phẩm)
    -   Trong các trang của bạn, thay đổi `useFetch` để gọi đến các API nội bộ này (ví dụ: `useFetch('/api/products')`).
2.  **Tích hợp Authentication**:
    -   Sử dụng `@sidebase/nuxt-auth` để thêm tính năng đăng nhập bằng GitHub hoặc Google.
    -   Tạo một trang `/profile` chỉ có thể truy cập khi đã đăng nhập. Sử dụng middleware `auth.global.js` hoặc `definePageMeta` để bảo vệ route này.
    -   Cập nhật `AppHeader` để hiển thị trạng thái đăng nhập và nút đăng xuất.
3.  **Tối ưu hóa SEO**:
    -   Trên trang chủ, dùng `useHead` để đặt một title và description mặc định.
    -   Trên trang chi tiết sản phẩm, dùng `useHead` để đặt title và description động dựa trên thông tin của sản phẩm.
4.  **Triển khai lên Vercel**:
    -   Push code của bạn lên một repository mới trên GitHub.
    -   Deploy dự án lên Vercel.
    -   Cấu hình các biến môi trường cho OAuth provider trên Vercel dashboard.
    -   Gửi link ứng dụng đã deploy của bạn để khoe thành quả!

**Mục tiêu cuối cùng**: Bạn đã xây dựng và triển khai thành công một ứng dụng web full-stack mạnh mẽ bằng Vue và Nuxt, với kiến thức từ frontend đến backend, sẵn sàng để chinh phục bất kỳ dự án nào.
