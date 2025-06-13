# 📘 PHẦN 7: NEXT.JS NÂNG CAO - SERVER ACTIONS, AUTHENTICATION VÀ TRIỂN KHAI

- [📘 PHẦN 7: NEXT.JS NÂNG CAO - SERVER ACTIONS, AUTHENTICATION VÀ TRIỂN KHAI](#-phần-7-nextjs-nâng-cao---server-actions-authentication-và-triển-khai)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Server Actions - Xử lý Form kiểu mới](#-bài-1-server-actions---xử-lý-form-kiểu-mới)
    - [Vấn đề của việc xử lý form truyền thống](#vấn-đề-của-việc-xử-lý-form-truyền-thống)
    - [Server Actions là gì?](#server-actions-là-gì)
    - [Cách tạo và sử dụng Server Action](#cách-tạo-và-sử-dụng-server-action)
    - [Quản lý trạng thái chờ (Pending State)](#quản-lý-trạng-thái-chờ-pending-state)
  - [🧑‍🏫 Bài 2: Các kỹ thuật nâng cao với Server Actions](#-bài-2-các-kỹ-thuật-nâng-cao-với-server-actions)
    - [Revalidating Data với `revalidatePath`](#revalidating-data-với-revalidatepath)
    - [Redirecting với `redirect`](#redirecting-với-redirect)
    - [Sử dụng trong Client Components](#sử-dụng-trong-client-components)
  - [🧑‍🏫 Bài 3: Giới thiệu về Authentication trong Next.js](#-bài-3-giới-thiệu-về-authentication-trong-nextjs)
    - [Các phương pháp xác thực](#các-phương-pháp-xác-thực)
    - [Giới thiệu NextAuth.js (Auth.js)](#giới-thiệu-nextauthjs-authjs)
    - [Thiết lập cơ bản với NextAuth.js](#thiết-lập-cơ-bản-với-nextauthjs)
    - [Bảo vệ Route và lấy Session](#bảo-vệ-route-và-lấy-session)
  - [🧑‍🏫 Bài 4: Middleware](#-bài-4-middleware)
    - [Middleware là gì?](#middleware-là-gì)
    - [Các trường hợp sử dụng](#các-trường-hợp-sử-dụng)
    - [Ví dụ: Middleware để bảo vệ Route](#ví-dụ-middleware-để-bảo-vệ-route)
  - [🧑‍🏫 Bài 5: Triển khai ứng dụng (Deployment)](#-bài-5-triển-khai-ứng-dụng-deployment)
    - [Giới thiệu Vercel](#giới-thiệu-vercel)
    - [Các bước triển khai](#các-bước-triển-khai)
    - [Biến môi trường (Environment Variables)](#biến-môi-trường-environment-variables)
  - [🧪 BÀI TẬP LỚN CUỐI CÙNG: Hoàn thiện "SimpleStore" và triển khai](#-bài-tập-lớn-cuối-cùng-hoàn-thiện-simplestore-và-triển-khai)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Sử dụng Server Actions để xử lý các tác vụ đột biến dữ liệu (mutations) một cách hiệu quả và an toàn.
- Hiểu và áp dụng các kỹ thuật `revalidatePath` và `redirect` để cập nhật giao diện sau khi action hoàn thành.
- Tích hợp một giải pháp xác thực (authentication) hoàn chỉnh vào ứng dụng Next.js.
- Sử dụng Middleware để thực thi logic trên mỗi request, ví dụ như bảo vệ các trang yêu cầu đăng nhập.
- Triển khai thành công ứng dụng Next.js lên một nền tảng hosting như Vercel.

---

## 🧑‍🏫 Bài 1: Server Actions - Xử lý Form kiểu mới

### Vấn đề của việc xử lý form truyền thống
Trong React SPA, để submit một form, bạn thường phải:
1.  Tạo state để quản lý các trường input (`useState`).
2.  Viết hàm `handleSubmit` trong một Client Component.
3.  Tạo một API route riêng (ví dụ: `POST /api/form`) để nhận dữ liệu từ client.
4.  Gửi request `fetch` từ client đến API route đó.
=> Quá nhiều bước và boilerplate.

### Server Actions là gì?
Là các hàm `async` mà bạn có thể định nghĩa và thực thi **trực tiếp trên server** để đáp lại tương tác của người dùng (như submit form) mà không cần tạo API route thủ công. Đây là một trong những tính năng đột phá nhất của App Router.

Sơ đồ so sánh:
```
// Kiểu cũ
Client Form --(fetch)--> API Route --(logic)--> Database

// Kiểu mới (Server Action)
Client Form --(RPC call)--> Server Action Function --(logic)--> Database
```

### Cách tạo và sử dụng Server Action
Bạn có thể định nghĩa một Server Action bằng cách thêm chỉ thị `"use server";` vào đầu hàm hoặc đầu file.

```jsx
// src/app/actions.js
"use server"; // Toàn bộ file này là Server Actions

export async function createItem(formData) {
  // Lấy dữ liệu từ form
  const itemName = formData.get('item');

  // Logic xử lý, ví dụ: lưu vào database
  console.log('Item mới:', itemName);

  // ... (sẽ học revalidate và redirect ở bài sau)
}
```

```jsx
// src/app/page.jsx (Server Component)
import { createItem } from './actions';

export default function HomePage() {
  return (
    <form action={createItem}>
      <input type="text" name="item" placeholder="Tên sản phẩm" />
      <button type="submit">Thêm</button>
    </form>
  );
}
```
Khi form được submit, hàm `createItem` sẽ được gọi tự động trên server.

### Quản lý trạng thái chờ (Pending State)
Để cung cấp phản hồi cho người dùng khi action đang chạy (ví dụ: vô hiệu hóa nút submit), hãy sử dụng hook `useFormStatus` từ `react-dom`.

**Lưu ý:** Vì `useFormStatus` là một Hook, component sử dụng nó phải là một Client Component.

```jsx
// src/components/SubmitButton.jsx
"use client";

import { useFormStatus } from 'react-dom';

export function SubmitButton() {
  const { pending } = useFormStatus();

  return (
    <button type="submit" disabled={pending}>
      {pending ? 'Đang thêm...' : 'Thêm'}
    </button>
  );
}
```

```jsx
// src/app/page.jsx
import { createItem } from './actions';
import { SubmitButton } from '../components/SubmitButton';

export default function HomePage() {
  return (
    <form action={createItem}>
      <input type="text" name="item" />
      <SubmitButton />
    </form>
  );
}
```
---

## 🧑‍🏫 Bài 2: Các kỹ thuật nâng cao với Server Actions

### Revalidating Data với `revalidatePath`
Sau khi một action thay đổi dữ liệu (ví dụ: thêm sản phẩm mới), bạn cần bảo Next.js làm mới lại dữ liệu trên các trang liên quan.

```jsx
// src/app/actions.js
"use server";
import { revalidatePath } from 'next/cache';

export async function createProduct(formData) {
  // ... logic thêm sản phẩm vào database ...

  // Bảo Next.js làm mới cache cho trang chủ và trang sản phẩm
  revalidatePath('/');
  revalidatePath('/products');
}
```

### Redirecting với `redirect`
Sau khi action thành công, bạn thường muốn điều hướng người dùng đến một trang khác (ví dụ: trang chi tiết của sản phẩm vừa tạo).

```jsx
// src/app/actions.js
"use server";
import { redirect } from 'next/navigation';

export async function createProduct(formData) {
  // ... logic thêm sản phẩm và lấy ID của nó ...
  const newProductId = '123';

  // Điều hướng người dùng
  redirect(`/products/${newProductId}`);
}
```

### Sử dụng trong Client Components
Bạn có thể gọi Server Actions từ Client Components bằng cách sử dụng `useTransition`.

```jsx
// src/components/ProductForm.jsx
"use client";
import { useTransition } from 'react';
import { createProduct } from '../app/actions';

export function ProductForm() {
  let [isPending, startTransition] = useTransition();

  const handleSubmit = async (formData) => {
    startTransition(async () => {
      await createProduct(formData);
    });
  };

  return (
    <form action={handleSubmit}>
      {/* ... inputs ... */}
      <button type="submit" disabled={isPending}>
        {isPending ? 'Đang lưu...' : 'Lưu sản phẩm'}
      </button>
    </form>
  );
}
```

---

## 🧑‍🏫 Bài 3: Giới thiệu về Authentication trong Next.js

### Các phương pháp xác thực
- **Cookie-based**: Phương pháp truyền thống, server tạo session và gửi một cookie về cho client.
- **Token-based (JWT)**: Phổ biến trong SPA, server cấp một token cho client, client gửi kèm token trong mỗi request.
- **Third-party providers (OAuth)**: Đăng nhập thông qua Google, Facebook, GitHub...

### Giới thiệu NextAuth.js (Auth.js)
`Auth.js` là giải pháp mã nguồn mở, hoàn chỉnh và phổ biến nhất để thêm tính năng xác thực vào ứng dụng Next.js. Nó hỗ trợ tất cả các phương pháp trên.

### Thiết lập cơ bản với NextAuth.js
1.  **Cài đặt:** `npm install next-auth`
2.  **Tạo API Route:** Tạo file `src/app/api/auth/[...nextauth]/route.js`

```javascript
// src/app/api/auth/[...nextauth]/route.js
import NextAuth from 'next-auth';
import GitHubProvider from 'next-auth/providers/github';

export const authOptions = {
  providers: [
    GitHubProvider({
      clientId: process.env.GITHUB_ID,
      clientSecret: process.env.GITHUB_SECRET,
    }),
    // ...thêm các provider khác như Google, Credentials
  ],
};

const handler = NextAuth(authOptions);

export { handler as GET, handler as POST };
```
3.  **Bọc ứng dụng bằng SessionProvider:** Tương tự như Context Provider.

### Bảo vệ Route và lấy Session
- **Trong Server Components:**
```jsx
import { getServerSession } from 'next-auth/next';
import { authOptions } from '../api/auth/[...nextauth]/route';

export default async function ProfilePage() {
  const session = await getServerSession(authOptions);

  if (!session) {
    redirect('/api/auth/signin');
  }

  return <h1>Xin chào, {session.user.name}</h1>;
}
```
- **Trong Client Components:**
```jsx
"use client";
import { useSession } from 'next-auth/react';

export default function UserInfo() {
  const { data: session, status } = useSession();

  if (status === "loading") return <p>Loading...</p>;

  if (session) {
    return <p>Signed in as {session.user.email}</p>;
  }
  return <a href="/api/auth/signin">Sign in</a>;
}
```
---

## 🧑‍🏫 Bài 4: Middleware

### Middleware là gì?
Là một hàm chạy **trước khi** một request được hoàn thành. Nó cho phép bạn thực thi code dựa trên request đến. Middleware chạy ở "Edge", gần với người dùng, nên rất nhanh.

### Các trường hợp sử dụng
-   Xác thực: Kiểm tra xem người dùng đã đăng nhập chưa trước khi cho phép truy cập một trang.
-   A/B Testing: Chuyển hướng một phần người dùng sang một phiên bản trang khác.
-   Localization: Chuyển hướng người dùng dựa trên vị trí địa lý.

### Ví dụ: Middleware để bảo vệ Route
Tạo file `src/middleware.js` ở thư mục gốc (cùng cấp với `src`).

```javascript
// src/middleware.js
export { default } from 'next-auth/middleware';

// Cấu hình matcher để chỉ áp dụng middleware cho các route nhất định
export const config = {
  matcher: ['/dashboard/:path*', '/profile'],
};
```
Với cấu hình này, bất kỳ ai cố gắng truy cập vào `/dashboard` hoặc `/profile` mà chưa đăng nhập sẽ tự động bị chuyển hướng đến trang đăng nhập.

---

## 🧑‍🏫 Bài 5: Triển khai ứng dụng (Deployment)

### Giới thiệu Vercel
Vercel là công ty tạo ra Next.js. Nền tảng hosting của họ được tối ưu hóa hoàn hảo cho Next.js và là cách dễ nhất để triển khai ứng dụng của bạn.

### Các bước triển khai
1.  **Push code lên GitHub/GitLab/Bitbucket.**
2.  **Tạo tài khoản Vercel:** Truy cập [vercel.com](https://vercel.com) và đăng ký bằng tài khoản GitHub của bạn.
3.  **Import dự án:**
    -   Trong dashboard Vercel, chọn "Add New... -> Project".
    -   Chọn repository GitHub của dự án của bạn và nhấn "Import".
4.  **Cấu hình biến môi trường:**
    -   Trong phần cài đặt dự án trên Vercel, vào mục "Environment Variables".
    -   Thêm các biến môi trường của bạn (ví dụ: `GITHUB_ID`, `GITHUB_SECRET`, `DATABASE_URL`...).
5.  **Deploy:** Nhấn nút "Deploy". Vercel sẽ tự động build và triển khai ứng dụng của bạn. Mỗi lần bạn push code lên branch chính, Vercel sẽ tự động deploy lại.

### Biến môi trường (Environment Variables)
-   Tạo file `.env.local` ở thư mục gốc của dự án để lưu các biến môi trường khi phát triển ở local.
-   Thêm file này vào `.gitignore` để không push các thông tin nhạy cảm lên Git.
-   Trong code, truy cập chúng qua `process.env.YOUR_VARIABLE_NAME`.

---

## 🧪 BÀI TẬP LỚN CUỐI CÙNG: Hoàn thiện "SimpleStore" và triển khai

### Mô tả bài toán
Thêm các tính năng cuối cùng vào "SimpleStore" để nó trở thành một ứng dụng thương mại điện tử hoàn chỉnh: cho phép người dùng "thanh toán" (giả lập) và thêm xác thực. Cuối cùng, đưa ứng dụng lên mạng.

### Yêu cầu
1.  **Form thanh toán với Server Actions**:
    -   Trên trang giỏ hàng (`/cart`), tạo một form thanh toán đơn giản với các trường: Tên, Địa chỉ, Email.
    -   Tạo một Server Action `placeOrder(formData)` trong `src/app/actions.js`.
    -   Khi form được submit, action này sẽ:
        -   Lấy thông tin từ `formData`.
        -   Giả lập việc lưu đơn hàng vào database (có thể chỉ `console.log` thông tin đơn hàng).
        -   Sử dụng `revalidatePath` để làm mới các trang liên quan (nếu cần).
        -   Sử dụng `redirect` để điều hướng người dùng đến một trang "Thank You" (`/order/success`).
    -   Tạo component `SubmitButton` với `useFormStatus` để hiển thị trạng thái chờ khi đang xử lý đơn hàng.
2.  **Tích hợp Authentication**:
    -   Tích hợp `NextAuth.js` vào dự án.
    -   Cấu hình ít nhất một provider (ví dụ: GitHub hoặc Google).
    -   Tạo trang profile (`/profile`) chỉ có thể truy cập được khi đã đăng nhập. Trang này hiển thị thông tin của người dùng.
    -   Sử dụng Middleware để bảo vệ trang profile.
    -   Trên `Header`, hiển thị nút "Đăng nhập" nếu người dùng chưa đăng nhập, và hiển thị tên/avatar cùng nút "Đăng xuất" nếu đã đăng nhập.
3.  **Quản lý biến môi trường**:
    -   Tạo file `.env.local` và lưu các keys của OAuth provider vào đó.
    -   Đảm bảo `.env.local` có trong `.gitignore`.
4.  **Triển khai lên Vercel**:
    -   Push code của bạn lên một repository mới trên GitHub.
    -   Deploy dự án lên Vercel.
    -   Cấu hình các biến môi trường trên Vercel dashboard.
    -   Kiểm tra xem ứng dụng có hoạt động đúng trên URL công khai mà Vercel cung cấp không.

**Mục tiêu cuối cùng**: Bạn đã xây dựng và triển khai thành công một ứng dụng web full-stack, hiện đại, bảo mật và hiệu suất cao bằng React và Next.js. Bạn đã sẵn sàng để xây dựng các dự án thực tế phức tạp!
