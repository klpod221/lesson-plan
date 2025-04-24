# 📘 PHẦN 4: FRAMEWORK & CÔNG CỤ PHÁT TRIỂN WEB HIỆN ĐẠI

- [📘 PHẦN 4: FRAMEWORK \& CÔNG CỤ PHÁT TRIỂN WEB HIỆN ĐẠI](#-phần-4-framework--công-cụ-phát-triển-web-hiện-đại)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu về Frontend Framework](#-bài-1-giới-thiệu-về-frontend-framework)
    - [Framework là gì và tại sao cần framework?](#framework-là-gì-và-tại-sao-cần-framework)
    - [Các frontend framework phổ biến](#các-frontend-framework-phổ-biến)
  - [🧑‍🏫 Bài 2: Giới thiệu về React.js](#-bài-2-giới-thiệu-về-reactjs)
    - [React là gì?](#react-là-gì)
    - [Cài đặt và khởi tạo dự án React](#cài-đặt-và-khởi-tạo-dự-án-react)
    - [JSX - JavaScript XML](#jsx---javascript-xml)
    - [Components](#components)
    - [Props và State](#props-và-state)
    - [Vòng đời component với useEffect](#vòng-đời-component-với-useeffect)
    - [Xử lý sự kiện](#xử-lý-sự-kiện)
    - [Danh sách và key](#danh-sách-và-key)
    - [Conditional Rendering](#conditional-rendering)
    - [Form và input](#form-và-input)
  - [🧑‍🏫 Bài 3: State Management trong React](#-bài-3-state-management-trong-react)
    - [State Management là gì?](#state-management-là-gì)
    - [Context API](#context-api)
    - [Redux - State Management Library](#redux---state-management-library)
    - [Redux Toolkit - Cách tiếp cận hiện đại](#redux-toolkit---cách-tiếp-cận-hiện-đại)
  - [🧑‍🏫 Bài 4: Routing trong React](#-bài-4-routing-trong-react)
    - [React Router](#react-router)
    - [Nested Routes](#nested-routes)
    - [Protected Routes](#protected-routes)
  - [🧑‍🏫 Bài 5: Giới thiệu về Node.js và NPM](#-bài-5-giới-thiệu-về-nodejs-và-npm)
    - [Node.js là gì?](#nodejs-là-gì)
    - [NPM (Node Package Manager)](#npm-node-package-manager)
    - [Cài đặt Node.js và NPM](#cài-đặt-nodejs-và-npm)
    - [Sử dụng NPM cơ bản](#sử-dụng-npm-cơ-bản)
    - [package.json file](#packagejson-file)
    - [Chạy scripts](#chạy-scripts)
  - [🧑‍🏫 Bài 6: Công cụ build và bundler](#-bài-6-công-cụ-build-và-bundler)
    - [Bundlers là gì?](#bundlers-là-gì)
    - [Webpack](#webpack)
    - [Vite](#vite)
    - [Babel](#babel)
    - [ESLint và Prettier](#eslint-và-prettier)
  - [🧑‍🏫 Bài 7: Backend APIs với Express.js](#-bài-7-backend-apis-với-expressjs)
    - [Express.js là gì?](#expressjs-là-gì)
    - [Cài đặt và thiết lập Express](#cài-đặt-và-thiết-lập-express)
    - [Routing](#routing)
    - [Middleware](#middleware)
    - [Kết nối với Database (MongoDB)](#kết-nối-với-database-mongodb)
  - [🧑‍🏫 Bài 8: REST API và RESTful Services](#-bài-8-rest-api-và-restful-services)
    - [REST (Representational State Transfer) là gì?](#rest-representational-state-transfer-là-gì)
    - [Các nguyên tắc của REST](#các-nguyên-tắc-của-rest)
    - [HTTP Methods trong REST](#http-methods-trong-rest)
    - [RESTful API Conventions](#restful-api-conventions)
    - [Status Codes trong REST API](#status-codes-trong-rest-api)
    - [API Documentation với Swagger/OpenAPI](#api-documentation-với-swaggeropenapi)
    - [API Versioning](#api-versioning)
    - [API Authentication](#api-authentication)
    - [CORS (Cross-Origin Resource Sharing)](#cors-cross-origin-resource-sharing)
    - [Rate Limiting](#rate-limiting)
  - [🧑‍🏫 Bài 9: Deployment và CI/CD cơ bản](#-bài-9-deployment-và-cicd-cơ-bản)
    - [Các nền tảng hosting phổ biến](#các-nền-tảng-hosting-phổ-biến)
    - [Triển khai lên Vercel](#triển-khai-lên-vercel)
    - [Triển khai lên Netlify](#triển-khai-lên-netlify)
    - [Cấu hình Continuous Integration/Continuous Deployment (CI/CD)](#cấu-hình-continuous-integrationcontinuous-deployment-cicd)
      - [GitHub Actions](#github-actions)
    - [Netlify CI/CD](#netlify-cicd)
    - [Docker cơ bản cho deployment](#docker-cơ-bản-cho-deployment)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng Ứng dụng Full-Stack với React và Express](#-bài-tập-lớn-cuối-phần-xây-dựng-ứng-dụng-full-stack-với-react-và-express)
    - [Đề bài](#đề-bài)
    - [Yêu cầu](#yêu-cầu)
    - [Gợi ý cấu trúc dự án](#gợi-ý-cấu-trúc-dự-án)
    - [Đánh giá](#đánh-giá)

## 🎯 Mục tiêu tổng quát

- Hiểu được vai trò và lợi ích của các framework trong phát triển web
- Làm quen với các công cụ phát triển web hiện đại
- Biết cách tổ chức và triển khai dự án web chuyên nghiệp

---

## 🧑‍🏫 Bài 1: Giới thiệu về Frontend Framework

### Framework là gì và tại sao cần framework?

- Framework là một bộ khung làm việc cung cấp cấu trúc và công cụ để xây dựng ứng dụng
- Giúp tăng tốc độ phát triển, đảm bảo code có cấu trúc tốt
- Cung cấp giải pháp cho các vấn đề phổ biến trong lập trình web
- Hỗ trợ quản lý các ứng dụng phức tạp và lớn

### Các frontend framework phổ biến

1. **React** - Thư viện JavaScript để xây dựng giao diện người dùng

   - Phát triển bởi Facebook
   - Sử dụng Virtual DOM để tối ưu hiệu suất
   - Dựa trên component-based architecture
   - Hệ sinh thái phong phú với nhiều thư viện hỗ trợ

2. **Next.js** - Framework cho React

   - Hỗ trợ server-side rendering (SSR) và static site generation (SSG)
   - Tích hợp dễ dàng với API routes
   - Tối ưu hóa SEO và hiệu suất tải trang
   - Hỗ trợ routing và code splitting tự động

3. **Vue.js** - Framework JavaScript tiến bộ

   - Dễ học và tích hợp
   - Hỗ trợ tốt cả ứng dụng một trang (SPA) và tích hợp từng phần
   - Có template system dễ hiểu
   - Performance tốt và kích thước nhỏ

4. **Angular** - Platform và framework toàn diện

   - Phát triển bởi Google
   - TypeScript-based, cung cấp type checking
   - Full-featured framework với routing, form handling, HTTP client,...
   - Hai-way data binding

5. **Svelte** - Framework hiện đại

   - Thay vì Virtual DOM, biên dịch code thành JavaScript tối ưu
   - Ít boilerplate code, dễ đọc
   - Performance cao và bundle size nhỏ

6. **Bootstrap & Tailwind CSS** - CSS frameworks
   - Bootstrap: Cung cấp nhiều component UI đã được thiết kế sẵn
   - Tailwind CSS: Utility-first CSS framework, linh hoạt cao

**So sánh các framework:**

| Framework | Học        | Hiệu suất | Cộng đồng  | Tài liệu | Trọng lượng |
| --------- | ---------- | --------- | ---------- | -------- | ----------- |
| React     | Trung bình | Cao       | Rất lớn    | Tốt      | Nhẹ         |
| Next.js   | Dễ         | Rất cao   | Lớn        | Tốt      | Nhẹ         |
| Vue.js    | Dễ         | Cao       | Lớn        | Rất tốt  | Rất nhẹ     |
| Angular   | Khó        | Tốt       | Lớn        | Tốt      | Nặng        |
| Svelte    | Dễ         | Rất cao   | Trung bình | Tốt      | Rất nhẹ     |

---

## 🧑‍🏫 Bài 2: Giới thiệu về React.js

### React là gì?

- Thư viện JavaScript để xây dựng giao diện người dùng
- Tập trung vào việc xây dựng UI dựa trên component
- Sử dụng Virtual DOM để tối ưu hiệu suất render
- Bạn nên tham khảo tài liệu chính thức tại [reactjs.org](https://reactjs.org/) để được cập nhật thông tin mới nhất và hướng dẫn chi tiết hơn

### Cài đặt và khởi tạo dự án React

```bash
# Sử dụng Create React App
npx create-react-app my-app
cd my-app
npm start

# Sử dụng Vite (nhanh hơn)
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

### JSX - JavaScript XML

```jsx
// JSX là cú pháp mở rộng của JavaScript để mô tả UI
const element = <h1>Hello, world!</h1>;

// JSX với biểu thức
const name = "John";
const element = <h1>Hello, {name}!</h1>;

// JSX với thuộc tính
const element = <img src={user.avatarUrl} alt="Avatar" />;

// JSX với nhiều phần tử (cần có phần tử gốc bao bọc)
const element = (
  <div>
    <h1>Hello!</h1>
    <p>Welcome to React</p>
  </div>
);

// Hoặc sử dụng React Fragment
const element = (
  <>
    <h1>Hello!</h1>
    <p>Welcome to React</p>
  </>
);
```

### Components

```jsx
// Function component (khuyến nghị)
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

// Arrow function component
const Welcome = (props) => <h1>Hello, {props.name}</h1>;

// Class component
class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}

// Sử dụng component
const element = <Welcome name="Sara" />;
```

### Props và State

```jsx
// Props - dữ liệu truyền từ component cha xuống con
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

// Destructuring props
function Welcome({ name, age }) {
  return (
    <div>
      <h1>Hello, {name}</h1>
      <p>You are {age} years old</p>
    </div>
  );
}

// Default props
Welcome.defaultProps = {
  name: "Guest",
  age: 0,
};

// State - dữ liệu nội bộ của component, có thể thay đổi
import { useState } from "react";

function Counter() {
  // Khởi tạo state với useState hook
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
    </div>
  );
}
```

### Vòng đời component với useEffect

```jsx
import { useState, useEffect } from "react";

function Example() {
  const [count, setCount] = useState(0);

  // Tương tự componentDidMount và componentDidUpdate
  useEffect(() => {
    // Cập nhật document title khi count thay đổi
    document.title = `You clicked ${count} times`;

    // Return một function cleanup (tương tự componentWillUnmount)
    return () => {
      document.title = "React App";
    };
  }, [count]); // Chỉ chạy lại khi count thay đổi

  // useEffect không có dependencies array sẽ chạy sau mỗi lần render
  useEffect(() => {
    console.log("Component rendered");
  });

  // useEffect với empty dependencies array chỉ chạy sau lần render đầu tiên
  useEffect(() => {
    console.log("Component mounted");
    return () => {
      console.log("Component will unmount");
    };
  }, []);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
    </div>
  );
}
```

### Xử lý sự kiện

```jsx
function Button() {
  // Event handler
  const handleClick = (e) => {
    e.preventDefault();
    console.log("Button clicked");
  };

  return <button onClick={handleClick}>Click me</button>;
}

// Truyền tham số cho event handler
function Products() {
  const handleProductClick = (productId, e) => {
    console.log(`Product ${productId} clicked`);
  };

  return (
    <div>
      <button onClick={(e) => handleProductClick(1, e)}>Product 1</button>
      <button onClick={(e) => handleProductClick(2, e)}>Product 2</button>
    </div>
  );
}
```

### Danh sách và key

```jsx
function NumberList({ numbers }) {
  const listItems = numbers.map((number) => (
    <li key={number.toString()}>{number}</li>
  ));

  return <ul>{listItems}</ul>;
}

// Với object array
function UserList({ users }) {
  return (
    <ul>
      {users.map((user) => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

### Conditional Rendering

```jsx
function Greeting({ isLoggedIn }) {
  // Dùng điều kiện if
  if (isLoggedIn) {
    return <h1>Welcome back!</h1>;
  }
  return <h1>Please sign in.</h1>;
}

// Dùng toán tử ba ngôi
function Greeting({ isLoggedIn }) {
  return <h1>{isLoggedIn ? "Welcome back!" : "Please sign in"}</h1>;
}

// Dùng toán tử && (short-circuit)
function Mailbox({ unreadMessages }) {
  return (
    <div>
      <h1>Hello!</h1>
      {unreadMessages.length > 0 && (
        <h2>You have {unreadMessages.length} unread messages.</h2>
      )}
    </div>
  );
}
```

### Form và input

```jsx
import { useState } from "react";

function SimpleForm() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log({ name, email });
  };

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label>
          Name:
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
        </label>
      </div>
      <div>
        <label>
          Email:
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
        </label>
      </div>
      <button type="submit">Submit</button>
    </form>
  );
}
```

---

## 🧑‍🏫 Bài 3: State Management trong React

### State Management là gì?

- Quản lý trạng thái của ứng dụng, đặc biệt là khi ứng dụng lớn và phức tạp
- Giúp chia sẻ dữ liệu giữa các component mà không cần truyền props qua nhiều cấp
- Cung cấp cách tiếp cận có tổ chức để quản lý trạng thái toàn cục

### Context API

```jsx
// 1. Tạo context
import { createContext, useState, useContext } from "react";

const ThemeContext = createContext();

// 2. Tạo provider
function ThemeProvider({ children }) {
  const [theme, setTheme] = useState("light");

  const toggleTheme = () => {
    setTheme(theme === "light" ? "dark" : "light");
  };

  // Value truyền xuống cho consumer
  const value = { theme, toggleTheme };

  return (
    <ThemeContext.Provider value={value}>{children}</ThemeContext.Provider>
  );
}

// 3. Sử dụng custom hook để truy cập context
function useTheme() {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error("useTheme must be used within a ThemeProvider");
  }
  return context;
}

// 4. Sử dụng trong component
function ThemedButton() {
  const { theme, toggleTheme } = useTheme();

  return (
    <button
      onClick={toggleTheme}
      style={{
        backgroundColor: theme === "light" ? "#fff" : "#333",
        color: theme === "light" ? "#333" : "#fff",
      }}
    >
      Toggle Theme
    </button>
  );
}

// 5. Bọc ứng dụng trong provider
function App() {
  return (
    <ThemeProvider>
      <ThemedButton />
      <OtherComponents />
    </ThemeProvider>
  );
}
```

### Redux - State Management Library

- Redux là một thư viện quản lý trạng thái phổ biến cho JavaScript
- Cung cấp một store toàn cục để lưu trữ trạng thái của ứng dụng
- Dựa trên ba nguyên tắc chính:
  1. Tất cả trạng thái ứng dụng được lưu trữ trong một store duy nhất
  2. Trạng thái chỉ có thể thay đổi thông qua actions
  3. Các state changes được thực hiện bằng cách sử dụng pure functions gọi là reducers
- Redux rất mạnh mẽ nhưng có thể phức tạp cho các ứng dụng nhỏ

```bash
npm install redux react-redux
```

```jsx
// 1. Actions
const ADD_TODO = "ADD_TODO";
const TOGGLE_TODO = "TOGGLE_TODO";

function addTodo(text) {
  return { type: ADD_TODO, text };
}

function toggleTodo(id) {
  return { type: TOGGLE_TODO, id };
}

// 2. Reducer
const initialState = {
  todos: [],
};

function todoReducer(state = initialState, action) {
  switch (action.type) {
    case ADD_TODO:
      return {
        ...state,
        todos: [
          ...state.todos,
          {
            id: Date.now(),
            text: action.text,
            completed: false,
          },
        ],
      };
    case TOGGLE_TODO:
      return {
        ...state,
        todos: state.todos.map((todo) =>
          todo.id === action.id ? { ...todo, completed: !todo.completed } : todo
        ),
      };
    default:
      return state;
  }
}

// 3. Store
import { createStore } from "redux";
const store = createStore(todoReducer);

// 4. React-Redux
import { Provider, useSelector, useDispatch } from "react-redux";

// Provider component
function App() {
  return (
    <Provider store={store}>
      <TodoApp />
    </Provider>
  );
}

// Component sử dụng Redux
function TodoApp() {
  const todos = useSelector((state) => state.todos);
  const dispatch = useDispatch();

  const handleAddTodo = (text) => {
    dispatch(addTodo(text));
  };

  const handleToggle = (id) => {
    dispatch(toggleTodo(id));
  };

  // Render UI...
}
```

### Redux Toolkit - Cách tiếp cận hiện đại

- Redux Toolkit là bộ công cụ chính thức để phát triển ứng dụng Redux
- Cung cấp các API đơn giản hơn để tạo store, reducer và actions
- Tích hợp sẵn các middleware như Redux Thunk cho xử lý bất đồng bộ
- Giúp giảm boilerplate code và dễ dàng hơn trong việc thiết lập Redux

```bash
npm install @reduxjs/toolkit react-redux
```

```jsx
import { createSlice, configureStore } from "@reduxjs/toolkit";

// Slice (kết hợp action creators và reducer)
const todosSlice = createSlice({
  name: "todos",
  initialState: [],
  reducers: {
    addTodo: (state, action) => {
      state.push({
        id: Date.now(),
        text: action.payload,
        completed: false,
      });
    },
    toggleTodo: (state, action) => {
      const todo = state.find((todo) => todo.id === action.payload);
      if (todo) {
        todo.completed = !todo.completed;
      }
    },
  },
});

// Export actions
export const { addTodo, toggleTodo } = todosSlice.actions;

// Tạo store
const store = configureStore({
  reducer: {
    todos: todosSlice.reducer,
  },
});

// Sử dụng trong component
function TodoApp() {
  const todos = useSelector((state) => state.todos);
  const dispatch = useDispatch();

  const handleAddTodo = (text) => {
    dispatch(addTodo(text));
  };
}
```

---

## 🧑‍🏫 Bài 4: Routing trong React

### React Router

```jsx
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Link,
  useParams,
  useNavigate,
} from "react-router-dom";

function App() {
  return (
    <Router>
      <div>
        <nav>
          <ul>
            <li>
              <Link to="/">Home</Link>
            </li>
            <li>
              <Link to="/about">About</Link>
            </li>
            <li>
              <Link to="/users">Users</Link>
            </li>
          </ul>
        </nav>

        <Routes>
          <Route path="/about" element={<About />} />
          <Route path="/users" element={<Users />} />
          <Route path="/user/:id" element={<UserDetail />} />
          <Route path="/" element={<Home />} />
          <Route path="*" element={<NotFound />} />
        </Routes>
      </div>
    </Router>
  );
}

// Component với params
function UserDetail() {
  // Lấy params từ URL
  const { id } = useParams();
  return <h2>User ID: {id}</h2>;
}

// Chuyển hướng lập trình
function Profile() {
  const navigate = useNavigate();

  const handleLogout = () => {
    // Xử lý logout...
    navigate("/login"); // Chuyển hướng đến trang login
  };

  return (
    <div>
      <h2>User Profile</h2>
      <button onClick={handleLogout}>Logout</button>
    </div>
  );
}
```

### Nested Routes

```jsx
function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          <Route path="about" element={<About />} />
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="products" element={<Products />}>
            <Route index element={<ProductList />} />
            <Route path=":id" element={<ProductDetail />} />
          </Route>
          <Route path="*" element={<NotFound />} />
        </Route>
      </Routes>
    </Router>
  );
}

// Layout component với Outlet
import { Outlet } from "react-router-dom";

function Layout() {
  return (
    <div>
      <header>
        <nav>{/* navigation links */}</nav>
      </header>

      <main>
        <Outlet /> {/* Nội dung của route con sẽ hiển thị ở đây */}
      </main>

      <footer>{/* footer content */}</footer>
    </div>
  );
}
```

### Protected Routes

```jsx
import { Navigate } from "react-router-dom";

// Custom component để bảo vệ route
function ProtectedRoute({ children }) {
  const { user } = useAuth(); // Custom hook để kiểm tra authentication

  if (!user) {
    // Chuyển hướng đến login nếu chưa đăng nhập
    return <Navigate to="/login" replace />;
  }

  return children;
}

// Sử dụng trong routes
function App() {
  return (
    <Router>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/public" element={<PublicPage />} />
        <Route
          path="/dashboard"
          element={
            <ProtectedRoute>
              <Dashboard />
            </ProtectedRoute>
          }
        />
        <Route
          path="/profile"
          element={
            <ProtectedRoute>
              <Profile />
            </ProtectedRoute>
          }
        />
      </Routes>
    </Router>
  );
}
```

---

## 🧑‍🏫 Bài 5: Giới thiệu về Node.js và NPM

### Node.js là gì?

- Môi trường runtime JavaScript ở phía máy chủ
- Xây dựng trên V8 JavaScript engine của Google Chrome
- Cho phép chạy JavaScript ngoài trình duyệt
- Thiết kế hướng sự kiện, không đồng bộ (asynchronous)
- Phù hợp cho ứng dụng thời gian thực và API

### NPM (Node Package Manager)

- Hệ thống quản lý package lớn nhất thế giới cho JavaScript
- Công cụ để cài đặt và quản lý thư viện từ bên thứ ba
- Quản lý dependencies của dự án

### Cài đặt Node.js và NPM

- Tải từ [nodejs.org](https://nodejs.org/)
- Kiểm tra cài đặt:

```bash
node -v
npm -v
```

### Sử dụng NPM cơ bản

```bash
# Khởi tạo dự án mới (tạo package.json)
npm init

# Khởi tạo nhanh với các giá trị mặc định
npm init -y

# Cài đặt package
npm install package-name

# Cài đặt package và thêm vào dependencies
npm install package-name --save

# Cài đặt package và thêm vào devDependencies
npm install package-name --save-dev

# Cài đặt package toàn cục
npm install -g package-name

# Cài đặt tất cả dependencies đã khai báo trong package.json
npm install

# Gỡ cài đặt package
npm uninstall package-name

# Cập nhật packages
npm update
```

### package.json file

```json
{
  "name": "my-app",
  "version": "1.0.0",
  "description": "My awesome app",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "test": "jest",
    "build": "webpack"
  },
  "keywords": ["app", "nodejs"],
  "author": "Your Name",
  "license": "MIT",
  "dependencies": {
    "express": "^4.17.1",
    "react": "^17.0.2"
  },
  "devDependencies": {
    "nodemon": "^2.0.7",
    "jest": "^27.0.6",
    "webpack": "^5.44.0"
  }
}
```

### Chạy scripts

```bash
# Chạy script được định nghĩa trong package.json
npm run script-name

# Chạy script start
npm start

# Chạy script test
npm test
```

---

## 🧑‍🏫 Bài 6: Công cụ build và bundler

### Bundlers là gì?

- Công cụ đóng gói tất cả code JavaScript, CSS và assets thành các bundle
- Cho phép chia code thành các module nhỏ, dễ quản lý
- Tối ưu hóa kích thước bundle và hiệu suất tải trang

### Webpack

- Bundler phổ biến nhất cho JavaScript
- Tính năng:
  - Code splitting (chia nhỏ bundle)
  - Lazy loading (tải code theo nhu cầu)
  - Hỗ trợ nhiều loại assets qua loaders
  - Tối ưu hóa bundle với plugins

```js
// webpack.config.js cơ bản
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  entry: "./src/index.js",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "bundle.js",
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env", "@babel/preset-react"],
          },
        },
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /\.(png|svg|jpg|gif)$/,
        use: ["file-loader"],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./public/index.html",
    }),
  ],
  devServer: {
    contentBase: "./dist",
    port: 3000,
  },
};
```

### Vite

- Build tool hiện đại, nhanh cho modern web
- Sử dụng ES modules để dev server khởi động nhanh
- Sử dụng Rollup khi build production

```bash
# Tạo dự án mới với Vite
npm create vite@latest my-app -- --template react

# Khởi động dev server
npm run dev

# Build production
npm run build
```

### Babel

- JavaScript compiler
- Biến đổi code JavaScript hiện đại thành phiên bản tương thích với các trình duyệt cũ
- Hỗ trợ JSX, TypeScript và các tính năng ES next

```js
// babel.config.js
module.exports = {
  presets: ["@babel/preset-env", "@babel/preset-react"],
  plugins: ["@babel/plugin-proposal-class-properties"],
};
```

### ESLint và Prettier

- ESLint: Công cụ để tìm và sửa lỗi trong JavaScript
- Prettier: Code formatter, đảm bảo code style nhất quán

```js
// .eslintrc.js
module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true
  },
  extends: [
    'eslint:recommended',
    'plugin:react/recommended'
  ],
  parserOptions: {
    ecmaFeatures: {
      jsx: true
    },
    ecmaVersion: 12,
    sourceType: 'module'
  },
  plugins: [
    'react'
  ],
  rules: {
    // Custom rules
  }
};

// .prettierrc
{
  "semi": true,
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "trailingComma": "es5"
}
```

---

## 🧑‍🏫 Bài 7: Backend APIs với Express.js

### Express.js là gì?

- Framework web nhẹ, linh hoạt cho Node.js
- Cung cấp các tính năng mạnh mẽ để xây dựng web và API
- Middleware system để xử lý requests và responses

### Cài đặt và thiết lập Express

```bash
npm install express nodemon
```

> nodemon là công cụ giúp tự động khởi động lại server khi có thay đổi trong code

```json
// package.json
{
  "name": "my-express-app",
  "version": "1.0.0",
  "description": "My Express app",
  "main": "app.js",
  "scripts": {
    "start": "node app.js",
    "dev": "nodemon app.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  },
  "devDependencies": {
    "nodemon": "^2.0.7"
  },
  "author": "",
  "license": "ISC"
}
```

```js
// app.js
const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware để parse JSON requests
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Route đơn giản
app.get("/", (req, res) => {
  res.send("Hello World!");
});

// Khởi động server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

```bash
# Chạy ứng dụng trong chế độ phát triển
npm run dev
```

### Routing

```js
// Basic routes
app.get("/users", (req, res) => {
  // Xử lý GET request cho /users
  res.json({ users: ["User1", "User2", "User3"] });
});

app.post("/users", (req, res) => {
  // Xử lý POST request cho /users
  console.log(req.body); // Dữ liệu từ client
  res.status(201).send("User created");
});

app.put("/users/:id", (req, res) => {
  // Lấy params từ URL
  const userId = req.params.id;
  // Xử lý PUT request cho /users/:id
  res.send(`Updating user ${userId}`);
});

app.delete("/users/:id", (req, res) => {
  // Xử lý DELETE request
  res.send(`Deleting user ${req.params.id}`);
});

// Route với query parameters
app.get("/products", (req, res) => {
  // Truy cập query params: /products?category=electronics&sort=price
  const category = req.query.category;
  const sort = req.query.sort;
  res.send(`Products in ${category}, sorted by ${sort}`);
});

// Router modules
const userRoutes = express.Router();

userRoutes.get("/", (req, res) => {
  res.send("Get all users");
});

userRoutes.get("/:id", (req, res) => {
  res.send(`Get user ${req.params.id}`);
});

// Mount router trên /api/users path
app.use("/api/users", userRoutes);
```

### Middleware

```js
// Custom middleware
function logger(req, res, next) {
  console.log(`${req.method} ${req.url} - ${new Date()}`);
  next(); // Chuyển request đến middleware tiếp theo
}

// Middleware áp dụng cho tất cả routes
app.use(logger);

// Middleware áp dụng cho một route cụ thể
app.get("/admin", authenticateAdmin, (req, res) => {
  res.send("Admin Dashboard");
});

// Authentication middleware
function authenticateUser(req, res, next) {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(401).json({ error: "No token provided" });
  }

  try {
    // Verify token logic
    const user = verifyToken(authHeader);
    req.user = user; // Add user to request
    next();
  } catch (error) {
    res.status(403).json({ error: "Invalid token" });
  }
}

// Protected route
app.get("/profile", authenticateUser, (req, res) => {
  res.json({ user: req.user });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send("Something broke!");
});
```

### Kết nối với Database (MongoDB)

- Bạn có thể truy cập [MongoDB](https://www.mongodb.com/) để tạo tài khoản và tạo database trên cloud hoặc cài đặt MongoDB trên máy tính của bạn.

```bash
npm install mongoose
```

```js
const mongoose = require("mongoose");

// Kết nối MongoDB
mongoose
  .connect("mongodb://localhost/mydatabase", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.error("Could not connect to MongoDB", err);
  });

// Định nghĩa Schema
const userSchema = new mongoose.Schema({
  name: String,
  email: { type: String, unique: true },
  password: String,
  createdAt: { type: Date, default: Date.now },
});

// Tạo Model
const User = mongoose.model("User", userSchema);

// CRUD operations
async function createUser(userData) {
  const user = new User(userData);
  return await user.save();
}

async function findUser(id) {
  return await User.findById(id);
}

async function updateUser(id, update) {
  return await User.findByIdAndUpdate(id, update, { new: true });
}

async function deleteUser(id) {
  return await User.findByIdAndDelete(id);
}

// API routes với database
app.post("/api/users", async (req, res) => {
  try {
    const user = await createUser(req.body);
    res.status(201).json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.get("/api/users/:id", async (req, res) => {
  try {
    const user = await findUser(req.params.id);
    if (!user) return res.status(404).json({ error: "User not found" });
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

---

## 🧑‍🏫 Bài 8: REST API và RESTful Services

### REST (Representational State Transfer) là gì?

- Kiến trúc phần mềm cho web services
- Sử dụng HTTP methods để thao tác với resources
- Stateless: server không lưu trạng thái của client
- Uniform interface: giao diện nhất quán giữa các components

### Các nguyên tắc của REST

1. **Client-Server**: Tách biệt client và server
2. **Stateless**: Mỗi request phải chứa đủ thông tin, server không lưu session
3. **Cacheable**: Responses có thể được cache
4. **Uniform Interface**: Interface đơn giản, nhất quán
5. **Layered System**: Kiến trúc phân lớp, client không biết server kết nối trực tiếp hay qua trung gian
6. **Code on Demand**: Server có thể mở rộng chức năng của client bằng cách gửi code (tùy chọn)

### HTTP Methods trong REST

| Method | CRUD           | Mô tả                             |
| ------ | -------------- | --------------------------------- |
| GET    | Read           | Lấy resource từ server            |
| POST   | Create         | Tạo resource mới                  |
| PUT    | Update/Replace | Cập nhật toàn bộ resource hiện có |
| PATCH  | Update/Modify  | Cập nhật một phần resource        |
| DELETE | Delete         | Xóa resource                      |

### RESTful API Conventions

```text
# Lấy danh sách users
GET /api/users

# Lấy thông tin một user cụ thể
GET /api/users/:id

# Tạo user mới
POST /api/users

# Cập nhật toàn bộ thông tin user
PUT /api/users/:id

# Cập nhật một phần thông tin user
PATCH /api/users/:id

# Xóa user
DELETE /api/users/:id

# Lấy các bài posts của user
GET /api/users/:id/posts

# Lấy các comments của post
GET /api/posts/:id/comments
```

### Status Codes trong REST API

- Bạn có thể tham khảo toàn bộ HTTP status codes tại [đây](https://devtools.klpod221.com/web/http-status)

```text

- **2xx Success**

  - 200 OK: Request thành công
  - 201 Created: Resource được tạo thành công
  - 204 No Content: Request thành công nhưng không có nội dung trả về

- **3xx Redirection**

  - 301 Moved Permanently: Resource đã chuyển sang URL khác
  - 304 Not Modified: Resource không thay đổi từ lần request gần nhất

- **4xx Client Error**

  - 400 Bad Request: Lỗi cú pháp, request không hợp lệ
  - 401 Unauthorized: Client cần xác thực
  - 403 Forbidden: Client không có quyền truy cập
  - 404 Not Found: Resource không tồn tại
  - 422 Unprocessable Entity: Request đúng cú pháp nhưng không thể xử lý

- **5xx Server Error**
  - 500 Internal Server Error: Lỗi trong quá trình xử lý request
  - 502 Bad Gateway: Server nhận response không hợp lệ từ upstream server
  - 503 Service Unavailable: Server tạm thời không khả dụng
```

### API Documentation với Swagger/OpenAPI

```javascript
// Sử dụng swagger-jsdoc và swagger-ui-express để tạo docs
const express = require("express");
const swaggerJsdoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");

const app = express();

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "My API",
      version: "1.0.0",
      description: "A simple Express API",
    },
    servers: [
      {
        url: "http://localhost:3000/api",
      },
    ],
  },
  apis: ["./routes/*.js"], // files containing annotations
};

const specs = swaggerJsdoc(options);
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(specs));

// Route với Swagger annotation
/**
 * @swagger
 * /users:
 *   get:
 *     summary: Returns a list of users
 *     description: Retrieve a list of users from the database
 *     responses:
 *       200:
 *         description: A list of users
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                         example: 1
 *                       name:
 *                         type: string
 *                         example: John Doe
 */
app.get("/users", (req, res) => {
  // Implementation
});
```

### API Versioning

```javascript
// URL-based versioning
app.use("/api/v1", v1Router);
app.use("/api/v2", v2Router);

// Header-based versioning
app.use(
  "/api",
  (req, res, next) => {
    const version = req.headers["accept-version"] || "1";
    req.apiVersion = version;
    next();
  },
  apiRouter
);
```

### API Authentication

```javascript
// JWT Authentication
const jwt = require("jsonwebtoken");

// Generate token
function generateToken(user) {
  return jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
    expiresIn: "30d",
  });
}

// Login endpoint
app.post("/api/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });

    if (user && (await user.matchPassword(password))) {
      res.json({
        _id: user._id,
        name: user.name,
        email: user.email,
        token: generateToken(user),
      });
    } else {
      res.status(401).json({
        status: "fail",
        message: "Invalid email or password",
      });
    }
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: error.message,
    });
  }
});

// Protect routes
const protect = async (req, res, next) => {
  let token;

  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith("Bearer")
  ) {
    try {
      // Get token from header
      token = req.headers.authorization.split(" ")[1];

      // Verify token
      const decoded = jwt.verify(token, process.env.JWT_SECRET);

      // Get user from the token
      req.user = await User.findById(decoded.id).select("-password");

      next();
    } catch (error) {
      res.status(401).json({
        status: "fail",
        message: "Not authorized, token failed",
      });
    }
  }

  if (!token) {
    res.status(401).json({
      status: "fail",
      message: "Not authorized, no token",
    });
  }
};

// Using protect middleware
app.get("/api/profile", protect, (req, res) => {
  res.json(req.user);
});
```

### CORS (Cross-Origin Resource Sharing)

- CORS là một cơ chế bảo mật cho phép hoặc từ chối các yêu cầu từ các nguồn khác nhau
- Giúp bảo vệ ứng dụng web khỏi các cuộc tấn công Cross-Site Request Forgery (CSRF)

```javascript
const cors = require("cors");

// Enable CORS for all routes
app.use(cors());

// Enable CORS for specific origin
app.use(
  cors({
    origin: "https://myapp.com",
  })
);

// Configure CORS options
app.use(
  cors({
    origin: ["https://myapp.com", "https://admin.myapp.com"],
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
    credentials: true,
    maxAge: 86400, // Preflight results cached for 24 hours
  })
);
```

### Rate Limiting

- Giới hạn số lượng yêu cầu từ một địa chỉ IP trong một khoảng thời gian nhất định
- Giúp bảo vệ ứng dụng khỏi các cuộc tấn công DDoS và brute-force

```javascript
const rateLimit = require("express-rate-limit");

// Apply rate limiting to all requests
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per window
  standardHeaders: true, // Return rate limit info in RateLimit-* headers
  message: {
    status: "fail",
    message: "Too many requests, please try again later.",
  },
});

app.use("/api", limiter);

// Apply stricter rate limiting to login attempts
const loginLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 5, // Limit to 5 login attempts per hour
  message: {
    status: "fail",
    message: "Too many login attempts, please try again after an hour",
  },
});

app.use("/api/login", loginLimiter);
```

---

## 🧑‍🏫 Bài 9: Deployment và CI/CD cơ bản

### Các nền tảng hosting phổ biến

1. **Vercel** - Tốt nhất cho Next.js và các SPA

   - Zero-config deployment
   - Preview deployments cho mỗi pull request
   - CDN toàn cầu

2. **Netlify** - Tốt cho static sites và Jamstack

   - Tích hợp CI/CD
   - Serverless functions
   - Form handling

3. **Heroku** - PaaS đơn giản, hỗ trợ nhiều ngôn ngữ

   - Dễ sử dụng
   - Add-ons cho databases và services
   - Free tier cho thử nghiệm (đã ngừng)

4. **AWS (Amazon Web Services)** - Đầy đủ tính năng, phức tạp hơn

   - Nhiều dịch vụ: EC2, S3, Lambda, Amplify...
   - Tính năng mở rộng và linh hoạt cao
   - Theo mô hình trả phí theo sử dụng

5. **Firebase** - Nền tảng phát triển của Google
   - Realtime Database
   - Authentication
   - Hosting
   - Functions (serverless)

### Triển khai lên Vercel

- Tham khảo tài liệu [Vercel](https://vercel.com/docs)

```bash
# Cài đặt Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
vercel

# Deploy với cấu hình production
vercel --prod
```

### Triển khai lên Netlify

- Tham khảo tài liệu [Netlify](https://docs.netlify.com/)

```bash
# Cài đặt Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Khởi tạo site mới
netlify init

# Deploy production build
netlify deploy --prod
```

### Cấu hình Continuous Integration/Continuous Deployment (CI/CD)

#### GitHub Actions

```yaml
# .github/workflows/node.js.yml
name: Node.js CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [14.x, 16.x]

    steps:
      - uses: actions/checkout@v2
      - name: Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v2
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm ci
      - run: npm run build --if-present
      - run: npm test

  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'

    steps:
      - uses: actions/checkout@v2
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
          vercel-args: "--prod"
```

### Netlify CI/CD

1. Liên kết repository GitHub/GitLab/Bitbucket với Netlify
2. Cấu hình build command (vd: `npm run build`)
3. Cấu hình publish directory (vd: `build` hoặc `dist`)
4. Tự động deploy khi push lên branch main

### Docker cơ bản cho deployment

```dockerfile
# Dockerfile
FROM node:14-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
```

```bash
# Build Docker image
docker build -t my-app .

# Run Docker container
docker run -p 3000:3000 my-app
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng Ứng dụng Full-Stack với React và Express

### Đề bài

Xây dựng một ứng dụng Blog đơn giản với React ở frontend và Express ở backend.

### Yêu cầu

1. **Backend (Express.js):**

   - API endpoints cho CRUD operations (Create, Read, Update, Delete) với bài viết
   - Authentication với JWT (JSON Web Tokens)
   - Lưu trữ dữ liệu (có thể sử dụng MongoDB hoặc SQLite)
   - Middleware xử lý lỗi và validation

2. **Frontend (React):**

   - Sử dụng React Router cho navigation
   - State management (Context API hoặc Redux)
   - Form handling với validation
   - Authentication UI (đăng nhập, đăng ký)
   - Responsive design

3. **Tính năng ứng dụng:**

   - Người dùng có thể đăng ký và đăng nhập
   - Người dùng đã xác thực có thể tạo, sửa, xóa bài viết
   - Tất cả người dùng có thể xem danh sách bài viết và chi tiết bài viết
   - Tìm kiếm và lọc bài viết

4. **Deployment:**
   - Backend: Vercel, Heroku hoặc Render
   - Frontend: Vercel hoặc Netlify
   - Cấu hình API calls giữa frontend và backend

### Gợi ý cấu trúc dự án

```text
blog-app/
├── client/                 # Frontend React
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── context/
│   │   ├── hooks/
│   │   ├── pages/
│   │   ├── services/
│   │   ├── App.js
│   │   └── index.js
│   └── package.json
│
├── server/                 # Backend Express
│   ├── controllers/
│   ├── middleware/
│   ├── models/
│   ├── routes/
│   ├── config.js
│   ├── server.js
│   └── package.json
│
└── README.md
```

### Đánh giá

- Tính năng đầy đủ và hoạt động chính xác
- Code cấu trúc, sạch, có comments
- Xử lý lỗi và validation đầy đủ
- UI/UX thân thiện người dùng
- Responsive trên nhiều thiết bị
- Deployment thành công

---

[⬅️ Trở lại: WEB/Part3.md](../WEB/Part3.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: PHP/Part1.md](../PHP/Part1.md)
