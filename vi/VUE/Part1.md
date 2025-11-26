# 📘 PHẦN 1: NHẬP MÔN VUE.JS VÀ TƯ DUY REACTIVITY

## 🎯 Mục tiêu tổng quát

- Hiểu được triết lý "tiệm tiến" (progressive) của Vue.js.
- Phân biệt được hai cách viết component chính: Options API (Vue 2) và Composition API (Vue 3).
- Nắm vững cú pháp template và các directives cơ bản để thao tác với DOM.
- Hiểu sâu về khái niệm "reactivity" và cách sử dụng `ref` để tạo ra giao diện động.
- Sử dụng `computed properties` để xử lý các dữ liệu dẫn xuất một cách hiệu quả và có hiệu năng.

## 🧑‍🏫 Bài 1: Giới thiệu Vue và Triết lý thiết kế

### Vue.js là gì?

- Vue (phát âm là /vjuː/, giống như **view**) là một framework JavaScript mã nguồn mở và tiệm tiến, dùng để xây dựng giao diện người dùng (UI).
- **"Tiệm tiến"** có nghĩa là bạn có thể bắt đầu nhỏ, chỉ dùng Vue để quản lý một phần của trang web, rồi sau đó mở rộng dần thành một ứng dụng Single Page Application (SPA) phức tạp nếu cần.
- Vue tập trung vào lớp View (giao diện) và rất dễ để tích hợp với các thư viện hoặc dự án có sẵn.

### Vue 2 (Options API) vs. Vue 3 (Composition API)

Đây là hai cách chính để viết một component trong Vue.

- **Options API (Chủ yếu trong Vue 2):** Tổ chức code theo các "tùy chọn" như `data`, `methods`, `computed`. Rất cấu trúc và dễ cho người mới bắt đầu.
- **Composition API (Chủ yếu trong Vue 3):** Tổ chức code theo **logic chức năng**. Đây là cách tiếp cận hiện đại, linh hoạt và mạnh mẽ hơn, đặc biệt với các component lớn.

**Lộ trình này sẽ tập trung vào Vue 3 và Composition API** vì đây là tương lai của Vue, nhưng sẽ có đề cập đến Options API để bạn có thể làm việc với các dự án cũ.

### Thiết lập môi trường (Vite)

Chúng ta sẽ dùng Vite, công cụ build hiện đại, để tạo dự án Vue.
Mở terminal và chạy lệnh sau:

```bash
npm create vue@latest
```

Làm theo hướng dẫn, đặt tên dự án là `simplestore-vue` và chọn **"No"** cho tất cả các câu hỏi thêm tính năng (như Router, Pinia...) để chúng ta có thể tự tìm hiểu và thêm chúng vào sau.

```bash
cd simplestore-vue
npm install
npm run dev
```

### Cấu trúc một Single-File Component (SFC)

Đây là trái tim của Vue. Một file `.vue` gói gọn cả ba phần của một component:

1. `<template>`: Chứa mã HTML.
2. `<script setup>`: Chứa mã JavaScript (logic), sử dụng Composition API.
3. `<style scoped>`: Chứa mã CSS. Thuộc tính `scoped` đảm bảo CSS này chỉ ảnh hưởng đến component hiện tại.

```vue
<!-- File: src/components/Greeting.vue -->
<template>
  <p class="message">{{ greetingMessage }}</p>
</template>

<script setup>
import { ref } from 'vue';
const greetingMessage = ref('Chào mừng đến với Vue.js!');
</script>

<style scoped>
.message {
  color: #42b883; /* Màu xanh lá đặc trưng của Vue */
  font-weight: bold;
}
</style>
```

## 🧑‍🏫 Bài 2: Cú pháp Template và Reactivity cơ bản

### Hiển thị dữ liệu (Text Interpolation & v-bind)

- **Text Interpolation**: Dùng dấu ngoặc nhọn kép `{{ }}` để hiển thị giá trị của biến.
- **`v-bind`**: Dùng để ràng buộc một thuộc tính HTML (như `id`, `class`, `src`) với một biến. Shorthand: dấu hai chấm `:`.

```vue
<script setup>
const productName = 'Laptop Pro';
const productImage = '/images/laptop.png';
const isDisabled = true;
</script>

<template>
  <h1>{{ productName }}</h1>
  <img :src="productImage" alt="Product Image">
  <button :disabled="isDisabled">Nút bị vô hiệu hóa</button>
</template>
```

### Reactivity: Làm cho dữ liệu "sống" với `ref`

Nếu bạn khai báo một biến thông thường (`let count = 0`), Vue sẽ không biết để cập nhật giao diện khi giá trị của nó thay đổi. Chúng ta cần nói cho Vue biết biến nào cần được "theo dõi".

- **`ref`**: Là một hàm từ Vue, nhận một giá trị và trả về một object "reactive".
- **Quy tắc vàng của `ref`**:
  - Trong `<script setup>`, luôn truy cập giá trị của nó qua `.value`.
  - Trong `<template>`, Vue tự động "mở gói" (unwrap), bạn không cần `.value`.

```vue
<script setup>
import { ref } from 'vue';

// `count` là một object reactive. Giá trị thực nằm trong `count.value`
const count = ref(0);

console.log(count.value); // In ra 0

function increment() {
  // Phải dùng .value để thay đổi giá trị
  count.value++;
}
</script>

<template>
  <!-- Vue tự hiểu và dùng giá trị của count -->
  <p>Số lần click: {{ count }}</p>
  <button @click="increment">Tăng giá trị</button>
</template>
```

## 🧑‍🏫 Bài 3: Directives - Điều khiển DOM

Directives là các thuộc tính đặc biệt có tiền tố `v-` dùng để áp dụng các hành vi động cho DOM.

### Render có điều kiện: `v-if`, `v-else`, `v-show`

- `v-if`, `v-else-if`, `v-else`: Thêm hoặc xóa hẳn phần tử khỏi DOM. Dùng khi điều kiện ít thay đổi.
- `v-show`: Luôn giữ phần tử trong DOM, chỉ thay đổi thuộc tính `display: none`. Dùng khi cần bật/tắt thường xuyên.

```vue
<script setup>
import { ref } from 'vue';
const loggedIn = ref(false);
</script>
<template>
  <div v-if="loggedIn">Chào mừng trở lại!</div>
  <div v-else>Vui lòng đăng nhập.</div>

  <div v-show="loggedIn">Thông tin tài khoản</div>
</template>
```

### Render danh sách: `v-for`

Dùng để lặp qua một mảng và render một phần tử cho mỗi item.

- **Bắt buộc phải có `:key`**: `key` phải là một giá trị duy nhất (string hoặc number) cho mỗi item. Vue dùng `key` để theo dõi và tối ưu hóa việc render danh sách.

```vue
<script setup>
const products = ref([
  { id: 'p1', name: 'Laptop' },
  { id: 'p2', name: 'Phone' },
  { id: 'p3', name: 'Tablet' }
]);
</script>
<template>
  <ul>
    <li v-for="product in products" :key="product.id">
      {{ product.name }}
    </li>
  </ul>
</template>
```

## 🧑‍🏫 Bài 4: Xử lý tương tác và Dữ liệu dẫn xuất

### Xử lý sự kiện: `v-on`

- Dùng để lắng nghe các sự kiện DOM. Shorthand: ký tự `@`.
- Ví dụ: `v-on:click` trở thành `@click`, `v-on:submit` thành `@submit`.

```vue
<script setup>
function showAlert() {
  alert('Form đã được gửi!');
}
</script>
<template>
  <!-- .prevent là một event modifier, tương đương event.preventDefault() -->
  <form @submit.prevent="showAlert">
    <button type="submit">Gửi</button>
  </form>
</template>
```

### Computed Properties: Dữ liệu thông minh

`computed` được dùng để khai báo một giá trị được tính toán từ các biến reactive khác.

- **Ưu điểm lớn nhất: Caching.** Một `computed property` sẽ chỉ tính toán lại khi một trong các `ref` phụ thuộc của nó thay đổi. Nếu không, nó sẽ trả về kết quả đã được cache.

**Ví dụ:**

```vue
<script setup>
import { ref, computed } from 'vue';

const products = ref([
  { id: 'p1', name: 'Laptop', price: 1200, inStock: true },
  { id: 'p2', name: 'Phone', price: 800, inStock: false },
  { id: 'p3', name: 'Tablet', price: 500, inStock: true },
]);

// Computed property này sẽ tự động cập nhật khi mảng products thay đổi
const inStockProducts = computed(() => {
  return products.value.filter(p => p.inStock);
});
</script>

<template>
  <h2>Sản phẩm còn hàng ({{ inStockProducts.length }})</h2>
  <ul>
    <li v-for="product in inStockProducts" :key="product.id">
      {{ product.name }}
    </li>
  </ul>
</template>
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng giao diện động cho "SimpleStore"

### Mô tả bài toán

Tạo một trang web hiển thị danh sách các sản phẩm có tính tương tác cơ bản, sử dụng các kiến thức đã học về reactivity, directives, và computed properties.

### Yêu cầu

1. **Thiết lập dữ liệu**:
    - Trong `src/App.vue`, tạo một biến `products` bằng `ref`. Biến này chứa một mảng các object sản phẩm. Mỗi object cần có: `id`, `name`, `price`, `imageUrl`, và `stock` (số lượng tồn kho, là một số).
2. **Hiển thị danh sách**:
    - Sử dụng `v-for` để render danh sách các sản phẩm. Mỗi sản phẩm là một "card".
    - Sử dụng `v-bind` (hoặc `:`) để hiển thị hình ảnh, và `{{ }}` để hiển thị tên và giá.
3. **Hiển thị trạng thái kho**:
    - Sử dụng `v-if` và `v-else` để hiển thị một huy hiệu (badge):
        - "Còn hàng" (màu xanh) nếu `product.stock > 0`.
        - "Hết hàng" (màu đỏ) nếu `product.stock === 0`.
4. **Thêm nút tương tác**:
    - Thêm một nút "Thêm vào giỏ" cho mỗi sản phẩm.
    - Tạo một biến `cartItemCount = ref(0)`.
    - Sử dụng `v-on` (hoặc `@`) để khi click vào nút, gọi một hàm `addToCart()`. Hàm này sẽ tăng `cartItemCount` lên 1.
5. **Dữ liệu dẫn xuất**:
    - Tạo một `computed property` tên là `totalStock` để tính tổng số lượng tồn kho của tất cả các sản phẩm.
    - Hiển thị thông tin này ở đầu trang, ví dụ: `<h2>Tổng số sản phẩm trong kho: {{ totalStock }}</h2>`.
6. **Styling**:
    - Sử dụng `<style scoped>` để làm cho các card sản phẩm và huy hiệu trông đẹp mắt.

**Mục tiêu:** Kết thúc phần này, bạn sẽ có một ứng dụng nhỏ nhưng đầy đủ các tính năng cơ bản của Vue: hiển thị dữ liệu động, điều khiển DOM, xử lý sự kiện và tính toán dữ liệu dẫn xuất một cách hiệu quả.
