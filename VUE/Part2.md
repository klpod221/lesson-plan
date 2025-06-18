# 📘 PHẦN 2: COMPONENTS, PROPS, EMITS VÀ VÒNG ĐỜI

- [📘 PHẦN 2: COMPONENTS, PROPS, EMITS VÀ VÒNG ĐỜI](#-phần-2-components-props-emits-và-vòng-đời)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Tư duy Component](#-bài-1-tư-duy-component)
    - [Tại sao cần Components?](#tại-sao-cần-components)
    - [Tạo và sử dụng Component](#tạo-và-sử-dụng-component)
  - [🧑‍🏫 Bài 2: Giao tiếp từ Cha xuống Con (Props)](#-bài-2-giao-tiếp-từ-cha-xuống-con-props)
    - [Props là gì?](#props-là-gì)
    - [Khai báo và sử dụng Props](#khai-báo-và-sử-dụng-props)
    - [Xác thực Props (Validation)](#xác-thực-props-validation)
  - [🧑‍🏫 Bài 3: Giao tiếp từ Con lên Cha (Emits)](#-bài-3-giao-tiếp-từ-con-lên-cha-emits)
    - [Tại sao cần Emits?](#tại-sao-cần-emits)
    - [Khai báo và phát sự kiện](#khai-báo-và-phát-sự-kiện)
  - [🧑‍🏫 Bài 4: Vòng đời của Component (Lifecycle Hooks)](#-bài-4-vòng-đời-của-component-lifecycle-hooks)
    - [Sơ đồ vòng đời](#sơ-đồ-vòng-đời)
    - [Các hooks chính và cách sử dụng](#các-hooks-chính-và-cách-sử-dụng)
  - [🧑‍🏫 Bài 5: So sánh với Vue 2 (Options API)](#-bài-5-so-sánh-với-vue-2-options-api)
    - [Props trong Options API](#props-trong-options-api)
    - [Methods và Emits trong Options API](#methods-và-emits-trong-options-api)
    - [Lifecycle trong Options API](#lifecycle-trong-options-api)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Tái cấu trúc "SimpleStore" thành Components](#-bài-tập-lớn-cuối-phần-tái-cấu-trúc-simplestore-thành-components)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Hiểu và áp dụng tư duy component để chia nhỏ giao diện thành các khối tái sử dụng.
- Nắm vững cách truyền dữ liệu từ component cha xuống con một cách an toàn bằng `props`.
- Biết cách component con có thể giao tiếp ngược lại với cha thông qua việc phát sự kiện (`emits`).
- Hiểu sâu sắc về vòng đời của một component và cách sử dụng các lifecycle hooks để thực thi logic tại các thời điểm quan trọng.
- Phân biệt được cách khai báo props, emits và lifecycle hooks giữa Vue 3 (Composition API) và Vue 2 (Options API).

---

## 🧑‍🏫 Bài 1: Tư duy Component

### Tại sao cần Components?
Khi ứng dụng phức tạp, việc viết toàn bộ code vào một file duy nhất (`App.vue`) trở nên hỗn loạn và khó bảo trì. Components cho phép chúng ta chia nhỏ giao diện thành các khối độc lập, có thể tái sử dụng.

**Ví dụ phân rã giao diện "SimpleStore":**
```
App.vue
├── Header.vue (chứa tiêu đề, logo, icon giỏ hàng)
└── ProductList.vue
    ├── ProductCard.vue
    ├── ProductCard.vue
    └── ...
```

### Tạo và sử dụng Component
1.  **Tạo file:** Tạo một file `.vue` mới trong thư mục `src/components`.
2.  **Viết code:** Viết logic, template, style cho component đó.
3.  **Import và đăng ký:** Import component vào file cha và sử dụng nó trong `<template>` như một thẻ HTML thông thường.

**Ví dụ:**
```vue
<!-- File: src/components/AppHeader.vue -->
<template>
  <header class="main-header">
    <h1>SimpleStore</h1>
  </header>
</template>
<style scoped> .main-header { background-color: #f0f0f0; padding: 1rem; } </style>
```

```vue
<!-- File: src/App.vue -->
<script setup>
// 1. Import component
import AppHeader from './components/AppHeader.vue';
</script>

<template>
  <!-- 2. Sử dụng component -->
  <AppHeader />
  <main>
    <!-- Nội dung chính của trang -->
  </main>
</template>
```

---

## 🧑‍🏫 Bài 2: Giao tiếp từ Cha xuống Con (Props)

### Props là gì?
Props (viết tắt của properties) là cách duy nhất để component cha truyền dữ liệu xuống cho component con. Dữ liệu này là "chỉ đọc" (one-way data flow) - component con không được phép thay đổi trực tiếp props mà nó nhận được.

Sơ đồ luồng dữ liệu:
`[ Component Cha (dữ liệu state) ] ----(truyền props)----> [ Component Con (nhận và hiển thị) ]`

### Khai báo và sử dụng Props
Trong Vue 3 với `<script setup>`, chúng ta sử dụng macro `defineProps`.

**Component Con (`ProductCard.vue`):**
```vue
<script setup>
// Khai báo các props mà component này chấp nhận
const props = defineProps(['productName', 'price']);
</script>

<template>
  <div class="card">
    <h3>{{ props.productName }}</h3>
    <p>Giá: {{ props.price.toLocaleString() }} VNĐ</p>
  </div>
</template>
```

**Component Cha (`App.vue`):**
```vue
<script setup>
import ProductCard from './components/ProductCard.vue';
</script>
<template>
  <!-- Truyền dữ liệu vào props bằng v-bind hoặc shorthand : -->
  <ProductCard productName="Laptop Pro" :price="30000000" />
  <ProductCard productName="Smartphone X" :price="15000000" />
</template>
```

### Xác thực Props (Validation)
Để code an toàn hơn, bạn nên định nghĩa props dưới dạng object để có thể xác thực kiểu dữ liệu, giá trị mặc định, hoặc yêu cầu bắt buộc.

```vue
// ProductCard.vue
<script setup>
defineProps({
  productName: {
    type: String,
    required: true // Bắt buộc phải có prop này
  },
  price: {
    type: Number,
    default: 0 // Giá trị mặc định nếu không được truyền
  },
  inStock: Boolean // Chỉ cần ghi kiểu dữ liệu
});
</script>
```

---

## 🧑‍🏫 Bài 3: Giao tiếp từ Con lên Cha (Emits)

### Tại sao cần Emits?
Vì component con không được thay đổi props, nó cần một cách để "thông báo" cho cha rằng người dùng đã thực hiện một hành động (ví dụ: click vào một nút). `emit` chính là cơ chế đó.

Sơ đồ luồng sự kiện:
`[ Component Cha ] <----(lắng nghe sự kiện)---- [ Component Con (phát sự kiện) ]`

### Khai báo và phát sự kiện
Trong `<script setup>`, chúng ta sử dụng macro `defineEmits`.

**Component Con (`ProductCard.vue`):**
```vue
<script setup>
const props = defineProps(['product']);
// 1. Khai báo các sự kiện mà component này có thể phát ra
const emit = defineEmits(['addToCart']);

function handleAddToCart() {
  // 2. Phát ra sự kiện 'addToCart' và gửi kèm dữ liệu là `props.product`
  emit('addToCart', props.product);
}
</script>

<template>
  <!-- ... -->
  <button @click="handleAddToCart">Thêm vào giỏ</button>
</template>
```

**Component Cha (`App.vue`):**
```vue
<script setup>
// ...
function onProductAddedToCart(productData) {
  alert(`Đã thêm "${productData.name}" vào giỏ hàng!`);
  // Tại đây bạn sẽ cập nhật state của giỏ hàng
}
</script>
<template>
  <!-- 3. Lắng nghe sự kiện bằng @tên-sự-kiện -->
  <ProductCard :product="someProduct" @addToCart="onProductAddedToCart" />
</template>
```

---

## 🧑‍🏫 Bài 4: Vòng đời của Component (Lifecycle Hooks)

Vòng đời của component là các giai đoạn mà nó trải qua từ lúc được tạo ra cho đến lúc bị hủy. Vue cho phép chúng ta "chen" code vào các giai đoạn này.

### Sơ đồ vòng đời
```
[ Tạo Component ] -> onBeforeMount -> [ Gắn vào DOM ] -> onMounted
       ^                                                        |
       | (khi dữ liệu thay đổi)                                 |
       V                                                        V
[ DOM cập nhật ] <- onUpdated <- [ Trước khi DOM cập nhật ] <- onBeforeUpdate
       |
       | (khi component bị gỡ)
       V
[ Đã hủy ] <- onUnmounted <- [ Trước khi hủy ] <- onBeforeUnmount
```

### Các hooks chính và cách sử dụng
-   **`onMounted`**: Chạy sau khi component đã được gắn vào DOM. Đây là nơi lý tưởng để:
    -   Thực hiện các thao tác DOM (ví dụ: focus một input).
    -   Gọi API để lấy dữ liệu ban đầu.
    -   Thiết lập các thư viện bên thứ ba.
-   **`onUpdated`**: Chạy sau khi dữ liệu thay đổi và DOM đã được cập nhật.
-   **`onBeforeUnmount`**: Chạy ngay trước khi component bị hủy. Đây là nơi để "dọn dẹp":
    -   Hủy các bộ đếm thời gian (`clearInterval`).
    -   Gỡ bỏ các event listener thủ công.

```vue
<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const timer = ref(0);
let intervalId = null;

// Chạy sau khi component được gắn vào DOM
onMounted(() => {
  console.log('Component đã được mounted!');
  intervalId = setInterval(() => {
    timer.value++;
  }, 1000);
});

// Chạy trước khi component bị hủy
onBeforeUnmount(() => {
  console.log('Dọn dẹp trước khi unmount...');
  clearInterval(intervalId); // Quan trọng để tránh memory leak
});
</script>
<template>
  <p>Bộ đếm: {{ timer }}</p>
</template>
```

---

## 🧑‍🏫 Bài 5: So sánh với Vue 2 (Options API)

Để bạn có thể đọc hiểu các dự án cũ, đây là cách các khái niệm trên được thể hiện trong Vue 2:

### Props trong Options API
`props` được khai báo như một key trong object.
```javascript
export default {
  props: {
    productName: String,
    price: Number
  }
}
```

### Methods và Emits trong Options API
Các hàm xử lý sự kiện được đặt trong key `methods`. Để phát sự kiện, dùng `this.$emit()`.
```javascript
export default {
  methods: {
    handleAddToCart() {
      this.$emit('addTo-cart', this.product); // Tên sự kiện thường là kebab-case
    }
  }
}
```

### Lifecycle trong Options API
Các hooks là các key trực tiếp trong object.
```javascript
export default {
  mounted() {
    console.log('Component mounted!');
  },
  beforeDestroy() { // Tên cũ của beforeUnmount
    console.log('Component will be destroyed.');
  }
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Tái cấu trúc "SimpleStore" thành Components

### Mô tả bài toán
Nâng cấp trang "SimpleStore" đã tạo ở Phần 1 bằng cách chia nhỏ giao diện thành các component có thể tái sử dụng và thiết lập luồng giao tiếp giữa chúng.

### Yêu cầu
1.  **Tái cấu trúc**:
    -   Tạo hai component mới:
        -   `src/components/AppHeader.vue`: Hiển thị tiêu đề của trang và thông tin giỏ hàng.
        -   `src/components/ProductCard.vue`: Hiển thị thông tin của một sản phẩm.
    -   Di chuyển logic và template liên quan từ `App.vue` vào các component tương ứng.
2.  **Quản lý State và Props**:
    -   Component `App.vue` sẽ là "nguồn chân lý", quản lý state của `products` và `cart` (một mảng chứa các sản phẩm trong giỏ).
    -   `App.vue` dùng `v-for` để render `ProductCard` và truyền dữ liệu của từng sản phẩm vào qua `props`.
    -   `App.vue` truyền số lượng sản phẩm trong giỏ hàng (`cart.length`) vào `AppHeader` qua `props`.
3.  **Xử lý sự kiện với Emits**:
    -   Trong `ProductCard.vue`, khi người dùng click nút "Thêm vào giỏ", component sẽ `emit` một sự kiện `addToCart` cùng với dữ liệu của sản phẩm đó.
    -   `App.vue` sẽ lắng nghe sự kiện này. Khi nhận được, nó sẽ cập nhật mảng `cart` của mình.
4.  **Sử dụng Vòng đời**:
    -   Trong `App.vue`, sử dụng hook `onMounted`. Bên trong nó, giả lập việc gọi API bằng cách dùng `setTimeout` để gán dữ liệu cho mảng `products` sau 1 giây.
    -   Trong lúc chờ, bạn có thể dùng `v-if` để hiển thị một thông báo "Đang tải sản phẩm...".

**Mục tiêu:** Kết thúc phần này, ứng dụng của bạn sẽ có một cấu trúc component rõ ràng, chuẩn "best practice". Dữ liệu sẽ chảy từ cha xuống con qua props, và các hành động của người dùng sẽ được thông báo từ con lên cha qua emits, tạo ra một ứng dụng có tổ chức và dễ bảo trì.
