# 📘 PHẦN 4: ROUTING VÀ LẤY DỮ LIỆU TỪ API

## 🎯 Mục tiêu tổng quát

- Hiểu vai trò của client-side router và cách Vue Router hoạt động.
- Cấu hình và tạo các route cho một ứng dụng đa trang.
- Xây dựng các route động để hiển thị các trang chi tiết (ví dụ: chi tiết sản phẩm).
- Lấy dữ liệu từ API bên ngoài một cách hiệu quả, bao gồm việc xử lý các trạng thái tải và lỗi.
- Đóng gói logic fetch dữ liệu vào một Composable function để dễ dàng tái sử dụng.

## 🧑‍🏫 Bài 1: Giới thiệu Vue Router

### Single Page Application (SPA) và Client-side Routing

Một ứng dụng Vue mặc định là một SPA. Toàn bộ ứng dụng được tải một lần duy nhất, và các "trang" tiếp theo được hiển thị bằng cách thay đổi nội dung trên trang mà không cần tải lại từ server. **Vue Router** là thư viện chính thức của Vue, giúp quản lý việc điều hướng này, đồng bộ URL trên thanh địa chỉ với giao diện đang hiển thị.

### Cài đặt và thiết lập

1. **Cài đặt:**

    ```bash
    npm install vue-router@4
    ```

2. **Tạo và cấu hình router:**
    Tạo một thư mục `src/router` và file `index.js` bên trong.

    ```javascript
    // src/router/index.js
    import { createRouter, createWebHistory } from 'vue-router';
    import HomePage from '../views/HomePage.vue'; // Sẽ tạo file này sau

    // Định nghĩa các route
    const routes = [
      {
        path: '/',
        name: 'Home',
        component: HomePage,
      },
      // ... các route khác sẽ được thêm vào đây
    ];

    // Tạo instance router
    const router = createRouter({
      history: createWebHistory(), // Sử dụng History API của trình duyệt
      routes,
    });

    export default router;
    ```

3. **Tích hợp vào ứng dụng:**
    Trong `src/main.js`, import và bảo Vue sử dụng router.

    ```javascript
    // src/main.js
    import { createApp } from 'vue';
    import App from './App.vue';
    import router from './router'; // 1. Import router
    import { createPinia } from 'pinia';

    const app = createApp(App);
    
    app.use(createPinia());
    app.use(router); // 2. Sử dụng router
    
    app.mount('#app');
    ```

## 🧑‍🏫 Bài 2: Cấu hình và sử dụng Routes

### Định nghĩa Routes

Bạn cần tạo các component tương ứng với mỗi trang. Theo quy ước, các component này thường được đặt trong thư mục `src/views` hoặc `src/pages`.

```javascript
// src/router/index.js
import HomePage from '../views/HomePage.vue';
import AboutPage from '../views/AboutPage.vue';

const routes = [
  { path: '/', name: 'Home', component: HomePage },
  { path: '/about', name: 'About', component: AboutPage },
];
//...
```

### `<router-view>` và `<router-link>`

- **`<router-view>`**: Là một component đặc biệt, đóng vai trò như một "placeholder". Vue Router sẽ render component tương ứng với URL hiện tại vào vị trí của `<router-view>`.
- **`<router-link>`**: Là component để tạo các liên kết điều hướng. Nó sẽ được render thành thẻ `<a>`, nhưng nó ngăn chặn việc tải lại trang.

**Ví dụ trong `App.vue`:**

```vue
<template>
  <div id="app">
    <header>
      <nav>
        <!-- Sử dụng router-link để điều hướng -->
        <router-link to="/">Trang chủ</router-link> |
        <router-link to="/about">Giới thiệu</router-link>
      </nav>
    </header>
    <main>
      <!-- Component của route hiện tại sẽ được render ở đây -->
      <router-view />
    </main>
  </div>
</template>
```

## 🧑‍🏫 Bài 3: Dynamic Routes và truy cập Params

### Route động

Để tạo các trang có URL thay đổi, ví dụ `/products/1`, `/products/2`, chúng ta sử dụng dấu hai chấm `:` trong `path`.

```javascript
// src/router/index.js
import ProductDetailPage from '../views/ProductDetailPage.vue';

const routes = [
  // ... các route khác
  // `:id` là một tham số động
  { path: '/product/:id', name: 'ProductDetail', component: ProductDetailPage },
];
```

### Truy cập tham số Route

Trong component của trang (ví dụ `ProductDetailPage.vue`), bạn có thể truy cập các tham số này thông qua object `$route` hoặc hook `useRoute`.

**Sử dụng hook `useRoute` (khuyến khích trong Composition API):**

```vue
<!-- src/views/ProductDetailPage.vue -->
<script setup>
import { useRoute } from 'vue-router';
import { ref, onMounted } from 'vue';

const route = useRoute();
const productId = ref(null);

onMounted(() => {
  // `route.params` là một object chứa các tham số động
  productId.value = route.params.id;
});
</script>

<template>
  <div>
    <h1>Chi tiết sản phẩm</h1>
    <p>ID của sản phẩm là: {{ productId }}</p>
  </div>
</template>
```

## 🧑‍🏫 Bài 4: Lấy dữ liệu từ API (Data Fetching)

### Sử dụng `fetch` trong hook `onMounted`

`onMounted` là nơi lý tưởng để thực hiện các cuộc gọi API lấy dữ liệu ban đầu cho một trang, vì nó đảm bảo component đã được gắn vào DOM.

```vue
<!-- src/views/HomePage.vue -->
<script setup>
import { ref, onMounted } from 'vue';
const products = ref([]);

onMounted(async () => {
  const response = await fetch('https://fakestoreapi.com/products');
  products.value = await response.json();
});
</script>

<template>
  <div>
    <h2>Danh sách sản phẩm</h2>
    <ul>
      <li v-for="product in products" :key="product.id">{{ product.title }}</li>
    </ul>
  </div>
</template>
```

### Xử lý trạng thái Loading và Error

Một trải nghiệm người dùng tốt đòi hỏi phải xử lý các trạng thái này.

```vue
<script setup>
import { ref, onMounted } from 'vue';

const products = ref([]);
const loading = ref(true);
const error = ref(null);

onMounted(async () => {
  try {
    const response = await fetch('https://fakestoreapi.com/products');
    if (!response.ok) throw new Error('Không thể tải dữ liệu');
    products.value = await response.json();
  } catch (err) {
    error.value = err.message;
  } finally {
    loading.value = false;
  }
});
</script>

<template>
  <div v-if="loading">Đang tải...</div>
  <div v-else-if="error" class="error">Lỗi: {{ error }}</div>
  <div v-else>
    <!-- Render danh sách sản phẩm -->
  </div>
</template>
```

### Tạo Composable Function `useFetch` để tái sử dụng

Logic fetch dữ liệu (bao gồm loading, error) thường được lặp lại ở nhiều nơi. Chúng ta có thể trích xuất nó ra một "Composable function" (tương tự Custom Hook trong React).

**Tạo file `src/composables/useFetch.js`:**

```javascript
// src/composables/useFetch.js
import { ref, watchEffect } from 'vue';

export function useFetch(url) {
  const data = ref(null);
  const loading = ref(true);
  const error = ref(null);

  // watchEffect sẽ chạy lại khi `url` (reactive) thay đổi
  watchEffect(async () => {
    loading.value = true;
    error.value = null;
    try {
      const response = await fetch(url.value); // Giả sử url là một ref/computed
      if (!response.ok) throw new Error('Lỗi mạng');
      data.value = await response.json();
    } catch (e) {
      error.value = e.message;
    } finally {
      loading.value = false;
    }
  });

  return { data, loading, error };
}
```

**Sử dụng trong component:**

```vue
<script setup>
import { useFetch } from '../composables/useFetch';
import { ref } from 'vue';

const apiUrl = ref('https://fakestoreapi.com/products');
const { data: products, loading, error } = useFetch(apiUrl);
</script>
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: "SimpleStore" với nhiều trang và dữ liệu động

### Mô tả bài toán

Chuyển đổi ứng dụng "SimpleStore" thành một SPA đa trang thực thụ. Dữ liệu sản phẩm sẽ không còn được hardcode mà sẽ được lấy từ API công khai.

### Yêu cầu

1. **Cấu trúc lại thư mục**:
    - Tạo thư mục `src/views`.
    - Chuyển các component trang hiện có (`HomePage`, `ShoppingCart`...) vào thư mục này.
2. **Thiết lập Vue Router**:
    - Cài đặt và cấu hình Vue Router.
    - Tạo ít nhất 3 route:
        - `/`: `HomePage.vue` - Hiển thị danh sách tất cả sản phẩm.
        - `/product/:id`: `ProductDetailPage.vue` - Hiển thị chi tiết một sản phẩm.
        - `/cart`: `CartPage.vue` (chính là `ShoppingCart.vue` cũ).
    - Cập nhật `App.vue` để chứa `<router-view>` và các `<router-link>` trong header để điều hướng.
3. **Lấy dữ liệu động**:
    - Trong `HomePage.vue`, sử dụng `onMounted` và `fetch` để lấy danh sách sản phẩm từ `https://fakestoreapi.com/products`.
    - Hiển thị trạng thái "Đang tải..." trong khi chờ API trả về.
4. **Trang chi tiết sản phẩm**:
    - Trong `HomePage.vue`, mỗi `ProductCard` phải là một `<router-link>` dẫn đến trang chi tiết của sản phẩm đó.
    - Trong `ProductDetailPage.vue`, sử dụng hook `useRoute` để lấy `id` của sản phẩm từ URL.
    - Gọi API `https://fakestoreapi.com/products/:id` để lấy thông tin chi tiết của sản phẩm đó và hiển thị ra.
5. **(Nâng cao) Tái sử dụng logic**:
    - Tạo một composable `useFetch.js` như ví dụ trên.
    - Sử dụng `useFetch` trong cả `HomePage.vue` và `ProductDetailPage.vue` để làm cho code gọn gàng hơn.

**Mục tiêu:** Kết thúc phần này, bạn sẽ có một ứng dụng Vue SPA hoàn chỉnh, có thể điều hướng giữa các trang, lấy dữ liệu từ một nguồn bên ngoài, và có cấu trúc code tốt thông qua việc tái sử dụng logic.
