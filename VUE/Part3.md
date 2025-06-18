# 📘 PHẦN 3: CÁC PHƯƠNG PHÁP QUẢN LÝ TRẠNG THÁI (VUEX & PINIA)

- [📘 PHẦN 3: CÁC PHƯƠNG PHÁP QUẢN LÝ TRẠNG THÁI (VUEX \& PINIA)](#-phần-3-các-phương-pháp-quản-lý-trạng-thái-vuex--pinia)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Vấn đề của việc quản lý trạng thái](#-bài-1-vấn-đề-của-việc-quản-lý-trạng-thái)
    - [Prop Drilling và Event Bubbling](#prop-drilling-và-event-bubbling)
  - [🧑‍🏫 Bài 2: Vuex - Người tiền nhiệm mạnh mẽ](#-bài-2-vuex---người-tiền-nhiệm-mạnh-mẽ)
    - [Vuex là gì?](#vuex-là-gì)
    - [Bốn khái niệm cốt lõi: State, Getters, Mutations, Actions](#bốn-khái-niệm-cốt-lõi-state-getters-mutations-actions)
    - [Ví dụ: Xây dựng Store với Vuex](#ví-dụ-xây-dựng-store-với-vuex)
    - [Sử dụng Vuex Store trong Components](#sử-dụng-vuex-store-trong-components)
  - [🧑‍🏫 Bài 3: Pinia - Giải pháp hiện đại](#-bài-3-pinia---giải-pháp-hiện-đại)
    - [Pinia là gì và tại sao nó ra đời?](#pinia-là-gì-và-tại-sao-nó-ra-đời)
    - [So sánh Pinia và Vuex](#so-sánh-pinia-và-vuex)
    - [Ví dụ: Xây dựng Store với Pinia](#ví-dụ-xây-dựng-store-với-pinia)
    - [Sử dụng Pinia Store trong Components](#sử-dụng-pinia-store-trong-components)
  - [🧑‍🏫 Bài 4: Slots - Tạo Component Layout linh hoạt](#-bài-4-slots---tạo-component-layout-linh-hoạt)
    - [Slots cơ bản, Named Slots, và Scoped Slots](#slots-cơ-bản-named-slots-và-scoped-slots)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Quản lý giỏ hàng "SimpleStore" bằng Pinia](#-bài-tập-lớn-cuối-phần-quản-lý-giỏ-hàng-simplestore-bằng-pinia)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)
    - [(Tùy chọn) Thử thách thêm](#tùy-chọn-thử-thách-thêm)

## 🎯 Mục tiêu tổng quát

- Hiểu rõ các vấn đề phát sinh khi quản lý trạng thái trong ứng dụng lớn.
- Nắm vững các khái niệm cốt lõi của **Vuex**: State, Getters, Mutations, và Actions.
- Nắm vững các khái niệm cốt lõi của **Pinia**: State, Getters, và Actions.
- Phân biệt được sự khác biệt về triết lý và cú pháp giữa Vuex và Pinia, và biết khi nào nên chọn thư viện nào.
- Xây dựng một store tập trung để quản lý trạng thái giỏ hàng bằng Pinia (giải pháp được khuyến khích cho dự án mới).
- Sử dụng `slots` để tạo ra các component layout linh hoạt.

---

## 🧑‍🏫 Bài 1: Vấn đề của việc quản lý trạng thái

### Prop Drilling và Event Bubbling
Khi ứng dụng lớn dần, việc truyền state và sự kiện qua nhiều cấp component trở nên rất cồng kềnh, khó bảo trì và dễ gây lỗi. Vấn đề này được giải quyết bằng các thư viện quản lý trạng thái tập trung, tạo ra một "kho" (store) toàn cục mà bất kỳ component nào cũng có thể truy cập.

---

## 🧑‍🏫 Bài 2: Vuex - Người tiền nhiệm mạnh mẽ

### Vuex là gì?
Vuex là thư viện quản lý trạng thái chính thức cho Vue 2. Nó hoạt động dựa trên một **store duy nhất** (single source of truth) và một luồng dữ liệu nghiêm ngặt.

### Bốn khái niệm cốt lõi: State, Getters, Mutations, Actions

1.  **State**: Tương tự như `data`. Là nơi chứa dữ liệu của toàn bộ ứng dụng.
2.  **Getters**: Tương tự như `computed`. Dùng để dẫn xuất dữ liệu từ state.
3.  **Mutations**: **Cách duy nhất** để thay đổi `state` một cách đồng bộ. Đây là một điểm khác biệt lớn so với Pinia. Mỗi mutation là một hàm nhận `state` làm tham số.
4.  **Actions**: Tương tự như `methods`. Dùng để thực thi logic nghiệp vụ, đặc biệt là các thao tác **bất đồng bộ** (như gọi API). Actions không trực tiếp thay đổi state, thay vào đó, chúng `commit` các mutations.

**Luồng dữ liệu trong Vuex:**
`Component --(dispatch)--> Action --(commit)--> Mutation --(thay đổi)--> State --(render)--> Component`

### Ví dụ: Xây dựng Store với Vuex
Tạo file `src/store/index.js`

```javascript
// src/store/index.js (Cú pháp Vuex 4 cho Vue 3)
import { createStore } from 'vuex';

export default createStore({
  // 1. STATE
  state: {
    cart: {
      items: [],
    },
  },

  // 2. GETTERS
  getters: {
    cartItemCount(state) {
      return state.cart.items.length;
    },
  },

  // 3. MUTATIONS (phải là đồng bộ)
  mutations: {
    ADD_ITEM_TO_CART(state, product) {
      state.cart.items.push(product);
    },
  },

  // 4. ACTIONS (có thể là bất đồng bộ)
  actions: {
    // context object chứa { commit, state, getters, dispatch }
    addProductToCart(context, product) {
      // Có thể thực hiện logic phức tạp hoặc gọi API ở đây
      // Sau đó commit mutation để thay đổi state
      context.commit('ADD_ITEM_TO_CART', product);
    },
  },
});
```

### Sử dụng Vuex Store trong Components
Trong `<script setup>`, bạn có thể sử dụng hook `useStore`.

```vue
<script setup>
import { useStore } from 'vuex';
import { computed } from 'vue';

const props = defineProps(['product']);
const store = useStore(); // Lấy store

// Lấy state và getter (nên dùng computed để giữ reactivity)
const itemCount = computed(() => store.getters.cartItemCount);

// Gọi action
function handleAddToCart() {
  store.dispatch('addProductToCart', props.product);
}
</script>

<template>
  <div>Sản phẩm trong giỏ: {{ itemCount }}</div>
  <button @click="handleAddToCart">Thêm vào giỏ</button>
</template>
```

---

## 🧑‍🏫 Bài 3: Pinia - Giải pháp hiện đại

### Pinia là gì và tại sao nó ra đời?
Pinia là thư viện quản lý trạng thái chính thức mới cho Vue, được thiết kế để đơn giản và trực quan hơn Vuex. Nó loại bỏ khái niệm `mutations` và cho phép bạn tổ chức store thành nhiều module nhỏ (thay vì một store khổng lồ).

### So sánh Pinia và Vuex
| Tính năng | Vuex | Pinia |
| --- | --- | --- |
| **Mutations** | **Bắt buộc**. Cách duy nhất để thay đổi state. | **Không có**. Actions có thể thay đổi state trực tiếp. |
| **Actions** | Gọi qua `dispatch('actionName')`. | Gọi như một phương thức bình thường: `store.actionName()`. |
| **Modules** | Hỗ trợ, nhưng cú pháp phức tạp. | **Mặc định**. Mỗi store là một module. |
| **TypeScript** | Hỗ trợ cơ bản. | Hỗ trợ tuyệt vời, tự động suy luận kiểu. |
| **Tổng quan** | Nghiêm ngặt, cấu trúc rõ ràng. | Linh hoạt, đơn giản, ít boilerplate. |

**Khuyến nghị:**
-   Sử dụng **Pinia** cho tất cả các dự án Vue 3 mới.
-   Học **Vuex** để có thể làm việc và bảo trì các dự án Vue 2 hoặc các dự án Vue 3 cũ hơn.

### Ví dụ: Xây dựng Store với Pinia
Tạo file `src/stores/cart.js`

```javascript
// src/stores/cart.js
import { defineStore } from 'pinia';

export const useCartStore = defineStore('cart', {
  // 1. STATE
  state: () => ({
    items: [],
  }),

  // 2. GETTERS
  getters: {
    itemCount: (state) => state.items.length,
  },

  // 3. ACTIONS (thay đổi state trực tiếp)
  actions: {
    addItem(product) {
      this.items.push(product); // Đơn giản hơn nhiều!
    },
  },
});
```

### Sử dụng Pinia Store trong Components

```vue
<script setup>
import { useCartStore } from '../stores/cart';

const props = defineProps(['product']);
const cartStore = useCartStore(); // Lấy store

function handleAddToCart() {
  cartStore.addItem(props.product); // Gọi action trực tiếp
}
</script>

<template>
  <!-- Truy cập state/getter trực tiếp từ store instance -->
  <div>Sản phẩm trong giỏ: {{ cartStore.itemCount }}</div>
  <button @click="handleAddToCart">Thêm vào giỏ</button>
</template>
```

---

## 🧑‍🏫 Bài 4: Slots - Tạo Component Layout linh hoạt

Slots là một cơ chế cho phép bạn truyền các khối template từ component cha vào các "khe" được định nghĩa sẵn trong component con, giúp component con trở nên cực kỳ linh hoạt và tái sử dụng được.

### Slots cơ bản, Named Slots, và Scoped Slots
- **Slots cơ bản (`<slot>`):** Một khe duy nhất để chèn nội dung.
- **Named Slots (`<slot name="header">`):** Nhiều khe được đặt tên để chèn nội dung vào các vị trí cụ thể.
- **Scoped Slots:** Cho phép component con truyền dữ liệu *ngược lại* cho nội dung của slot ở component cha.

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Quản lý giỏ hàng "SimpleStore" bằng Pinia

### Mô tả bài toán
Tái cấu trúc lại toàn bộ logic quản lý giỏ hàng của "SimpleStore", chuyển nó từ state cục bộ trong `App.vue` sang một store tập trung bằng **Pinia**, vì đây là giải pháp hiện đại được khuyến khích.

### Yêu cầu
1.  **Cài đặt Pinia**: Cài đặt (`npm install pinia`) và thiết lập Pinia cho dự án trong `src/main.js`.
2.  **Tạo Cart Store**:
    -   Tạo file `src/stores/cart.js`.
    -   Định nghĩa một store `useCartStore` với các phần sau:
        -   **State**: `items` (mảng rỗng).
        -   **Getters**: `itemCount` (tính độ dài mảng `items`) và `totalPrice` (tính tổng giá trị giỏ hàng).
        -   **Actions**: `addItem(product)` (nếu sản phẩm đã có thì tăng quantity, nếu không thì thêm mới) và `removeItem(productId)`.
3.  **Tái cấu trúc Components**:
    -   **`AppHeader.vue`**: Sử dụng `useCartStore` để lấy và hiển thị `itemCount`.
    -   **`ProductCard.vue`**: Xóa `emit`. Thay vào đó, khi click nút "Thêm vào giỏ", gọi trực tiếp action `cartStore.addItem()`.
    -   **`App.vue`**: Xóa toàn bộ state và logic liên quan đến giỏ hàng.
4.  **Tạo component Layout**:
    -   Tạo một component `src/components/BaseLayout.vue` sử dụng **named slots** (`#header`, `#default`, `#footer`).
    -   Trong `App.vue`, sử dụng `BaseLayout` để cấu trúc trang, đặt `AppHeader` vào slot `header`.
5.  **Tạo trang giỏ hàng (mô phỏng)**:
    -   Tạo một component mới `src/components/ShoppingCart.vue`.
    -   Component này sẽ sử dụng `useCartStore` để hiển thị danh sách sản phẩm trong giỏ, tổng tiền, và các nút để gọi action `removeItem`.
    -   Sử dụng `ShoppingCart.vue` trong `App.vue`.

### (Tùy chọn) Thử thách thêm
-   Sau khi hoàn thành bài tập với Pinia, hãy thử tạo một nhánh git mới và làm lại bài tập tương tự nhưng sử dụng **Vuex**. Điều này sẽ giúp bạn củng cố sự khác biệt giữa hai thư viện.

**Mục tiêu:** Kết thúc phần này, bạn không chỉ xây dựng được một hệ thống quản lý trạng thái mạnh mẽ, mà còn hiểu rõ hai công cụ phổ biến nhất trong hệ sinh thái Vue, sẵn sàng để lựa chọn giải pháp phù hợp cho các dự án trong tương lai.
