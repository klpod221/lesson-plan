# 📘 PHẦN 5: NHẬP MÔN NUXT.JS - VUE FRAMEWORK

## 🎯 Mục tiêu tổng quát

- Hiểu được Nuxt.js là gì và những lợi ích cốt lõi nó mang lại so với một ứng dụng Vue thông thường (SEO, hiệu năng, trải nghiệm lập trình).
- Làm quen với cấu trúc thư mục đặc biệt của Nuxt và cách nó tự động hóa nhiều công việc.
- Nắm vững cơ chế routing dựa trên file và cách tạo các layout dùng chung.
- Sử dụng composable `useFetch` tích hợp sẵn của Nuxt để lấy dữ liệu một cách hiệu quả trên cả server và client.
- Di chuyển thành công một ứng dụng Vue đã có sang cấu trúc Nuxt.js.

## 🧑‍🏫 Bài 1: Tại sao lại là Nuxt.js?

### Nuxt.js là gì?

Nuxt.js là một framework mã nguồn mở, miễn phí, xây dựng trên nền tảng Vue.js. Nó không thay thế Vue, mà bổ sung các quy ước và công cụ mạnh mẽ để bạn có thể xây dựng các ứng dụng Vue hiện đại, hiệu suất cao và sẵn sàng cho production một cách nhanh chóng.

### Các vấn đề Vue SPA gặp phải và giải pháp của Nuxt

Một ứng dụng Vue SPA (tạo bằng Vite) render ở phía client (CSR) và có các nhược điểm tương tự React SPA:

1. **SEO kém**: Các công cụ tìm kiếm khó đọc nội dung vì ban đầu chỉ nhận được một file HTML gần như trống.
2. **Thời gian tải ban đầu chậm**: Người dùng phải tải và chạy JavaScript trước khi thấy bất kỳ nội dung nào.

Nuxt giải quyết các vấn đề này bằng cách cho phép bạn render ứng dụng trên server trước khi gửi về cho client.

### Các chế độ Rendering

Nuxt.js cực kỳ linh hoạt và hỗ trợ nhiều chiến lược rendering khác nhau:

- **Universal Rendering (SSR - Server-Side Rendering)**: Chế độ mặc định. HTML được tạo ra trên server cho mỗi request. Tốt cho SEO và Time-to-Content.
- **Static Site Generation (SSG)**: Toàn bộ website được render thành các file HTML tĩnh tại thời điểm build. Cực kỳ nhanh và an toàn.
- **Client-Side Rendering (CSR)**: Hoạt động giống như một SPA Vue thông thường (nếu bạn muốn).
- **Hybrid Rendering**: Kết hợp các chế độ trên cho từng route khác nhau.

## 🧑‍🏫 Bài 2: Thiết lập và cấu trúc dự án Nuxt.js

### Khởi tạo dự án

Nuxt cung cấp một công cụ CLI để tạo dự án.

```bash
npx nuxi@latest init simplestore-nuxt
```

Lệnh này sẽ tạo một dự án Nuxt tối giản. Sau đó, di chuyển vào thư mục và cài đặt dependencies:

```bash
cd simplestore-nuxt
npm install
npm run dev
```

### Cấu trúc thư mục "thần kỳ" của Nuxt

Nuxt sử dụng một cấu trúc thư mục dựa trên quy ước. Nếu bạn đặt file vào đúng thư mục, Nuxt sẽ tự động "hiểu" và cấu hình mọi thứ cho bạn.

- `app.vue`: File gốc của ứng dụng. Tương tự `App.vue` trong dự án Vue thông thường. Nó thường chứa component `<NuxtPage />` (tương tự `<router-view>`).
- `pages/`: **Thư mục quan trọng nhất.** Chứa các trang và tự động tạo ra cấu hình Vue Router.
- `components/`: Chứa các component Vue. Các component trong này sẽ được **tự động import**.
- `layouts/`: Chứa các layout dùng chung cho các trang.
- `composables/`: Chứa các composable functions. Các hàm trong này cũng được **tự động import**.
- `server/`: Chứa code chạy trên server, ví dụ như các API route.
- `assets/`: Chứa các tài sản cần được xử lý bởi bundler (CSS, SASS, images...).
- `public/`: Chứa các tài sản tĩnh không cần xử lý (favicon.ico, robots.txt).

## 🧑‍🏫 Bài 3: File-based Routing và Layouts

### Routing dựa trên thư mục `pages/`

Bạn không cần phải tạo file `router/index.js` thủ công nữa! Nuxt sẽ đọc cấu trúc thư mục `pages/` và tự động tạo các route.

1. Đầu tiên, tạo thư mục `pages/` trong project của bạn.
2. Tạo các file `.vue` bên trong:

- `pages/index.vue` -> `http://localhost:3000/`
- `pages/about.vue` -> `http://localhost:3000/about`
- `pages/cart.vue` -> `http://localhost:3000/cart`

Sau đó, trong `app.vue`, bạn chỉ cần thêm component `<NuxtPage />`:

```vue
<!-- app.vue -->
<template>
  <div>
    <!-- Có thể thêm Header và Footer ở đây -->
    <NuxtPage /> <!-- Component trang sẽ được render ở đây -->
  </div>
</template>
```

### Dynamic Routes

Để tạo route động, sử dụng dấu ngoặc vuông `[]` trong tên file hoặc thư mục.

- `pages/products/[id].vue` -> sẽ khớp với `/products/1`, `/products/abc`, ...
- Trong component này, bạn có thể truy cập `id` bằng composable `useRoute()`:

    ```vue
    <script setup>
    const route = useRoute();
    const productId = route.params.id;
    </script>
    ```

### Layouts lồng nhau

Layouts cho phép bạn có một giao diện chung cho một nhóm các trang.

1. **Tạo file layout:** `layouts/default.vue`

    ```vue
    <!-- layouts/default.vue -->
    <template>
      <div>
        <AppHeader />
        <main>
          <slot /> <!-- Trang con sẽ được render vào đây -->
        </main>
        <AppFooter />
      </div>
    </template>
    ```

    `default.vue` sẽ tự động được áp dụng cho tất cả các trang.

2. **Tạo layout tùy chỉnh:** `layouts/dashboard.vue`

    ```vue
    <!-- layouts/dashboard.vue -->
    <template>
      <div class="dashboard-layout">
        <DashboardSidebar />
        <slot />
      </div>
    </template>
    ```

    Để sử dụng layout này, trong một trang cụ thể, bạn dùng `<NuxtLayout>` component hoặc macro `definePageMeta`:

    ```vue
    <!-- pages/admin/index.vue -->
    <script setup>
    definePageMeta({
      layout: 'dashboard'
    });
    </script>
    ```

## 🧑‍🏫 Bài 4: Auto-imports và Data Fetching với `useFetch`

### Tự động import (Auto-imports)

Đây là một trong những tính năng giúp tăng tốc độ phát triển nhất của Nuxt.

- Mọi component trong `components/` đều có thể được sử dụng trong các trang và component khác mà **không cần import thủ công**.
- Mọi composable trong `composables/` cũng được tự động import.
- Các hàm tiện ích của Nuxt (như `useFetch`, `useRoute`, `useState`) cũng có sẵn ở mọi nơi.

### Composable `useFetch` của Nuxt

Nuxt cung cấp một composable `useFetch` được tối ưu hóa, mạnh mẽ hơn `fetch` thông thường.

- **Chạy trên cả server và client**: Khi người dùng truy cập trang lần đầu, `useFetch` chạy trên server để render HTML. Khi người dùng điều hướng trên client, nó chạy trên client.
- **Xử lý trạng thái**: Tự động quản lý các state `pending` (loading), `error`, `data`.
- **Ngăn chặn request trùng lặp**: Có cơ chế cache thông minh.

**Ví dụ:**

```vue
<!-- pages/index.vue -->
<script setup>
const { data: products, pending, error } = await useFetch('https://fakestoreapi.com/products');
// `await` ở top-level của <script setup> được hỗ trợ trong Nuxt
// Nó sẽ "block" việc render phía server cho đến khi data fetch xong
</script>

<template>
  <div>
    <h1>Sản phẩm</h1>
    <div v-if="pending">Đang tải...</div>
    <div v-else-if="error">Lỗi: {{ error.message }}</div>
    <ul v-else>
      <li v-for="product in products" :key="product.id">
        {{ product.title }}
      </li>
    </ul>
  </div>
</template>
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Di chuyển "SimpleStore" sang Nuxt.js

### Mô tả bài toán

Xây dựng lại dự án "SimpleStore" từ đầu bằng Nuxt.js, tận dụng các tính năng tự động hóa và tối ưu hóa của framework.

### Yêu cầu

1. **Thiết lập dự án**: Tạo một dự án Nuxt mới tên là `simplestore-nuxt`.
2. **Di chuyển Components**:
    - Copy các component Vue cũ (`ProductCard.vue`, `AppHeader.vue`...) vào thư mục `components/` của dự án mới.
    - Nhờ có auto-import, bạn có thể xóa tất cả các câu lệnh `import` component trong các file.
3. **Xây dựng Routing và Layout**:
    - Xóa file `app.vue` nếu bạn muốn dùng layout.
    - Tạo một layout mặc định trong `layouts/default.vue`, đặt `AppHeader` và `AppFooter` (nếu có) vào đó, và một `<slot />` ở giữa.
    - Tạo các file trang trong thư mục `pages/`:
        - `pages/index.vue`: Trang chủ.
        - `pages/cart.vue`: Trang giỏ hàng.
        - `pages/products/[id].vue`: Trang chi tiết sản phẩm.
4. **Lấy dữ liệu kiểu Nuxt**:
    - Trong `pages/index.vue`, sử dụng `useFetch` để lấy và hiển thị danh sách sản phẩm.
    - Trong `pages/products/[id].vue`, sử dụng `useRoute` để lấy `id` và sau đó dùng `useFetch` để lấy dữ liệu chi tiết cho sản phẩm đó.
5. **Quản lý State với Pinia**:
    - Nuxt tích hợp sẵn với Pinia. Cài đặt module: `npm install @pinia/nuxt`.
    - Thêm `@pinia/nuxt` vào `modules` trong file `nuxt.config.ts`.
    - Tạo store của bạn trong thư mục `stores/`. Ví dụ: `stores/cart.js`. Store này sẽ được tự động đăng ký.
    - Sử dụng `useCartStore` trong các component mà không cần import thủ công.

**Mục tiêu**: Kết thúc phần này, bạn sẽ có một phiên bản "SimpleStore" chạy trên Nuxt.js, được hưởng lợi từ Server-Side Rendering (tốt cho SEO), code gọn gàng hơn nhờ auto-imports, và logic fetch dữ liệu mạnh mẽ hơn.
