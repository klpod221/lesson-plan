---
prev:
  text: '🔄 JavaScript'
  link: '/WEB/Part3'
next:
  text: '🐘 Module 7: Introduction to PHP'
  link: '/PHP/Part1'
---

# 📘 PART 4: FRAMEWORKS & MODERN WEB DEVELOPMENT TOOLS

## 🎯 General Objectives

- Understand the role and benefits of frameworks in web development.
- Get familiar with modern web development tools.
- Learn how to organize and deploy professional web projects.

## 🧑‍🏫 Lesson 1: Introduction to Frontend Frameworks

### What is a Framework and Why Do We Need It?

- A framework is a structure that provides a foundation and tools for building applications.
- Helps speed up development, ensures well-structured code.
- Provides solutions for common web programming problems.
- Supports managing complex and large applications.

### Popular Frontend Frameworks

1. **React** - JavaScript library for building user interfaces.

   - Developed by Facebook.
   - Uses Virtual DOM to optimize performance.
   - Based on component-based architecture.
   - Rich ecosystem with many supporting libraries.

2. **Next.js** - Framework for React.

   - Supports server-side rendering (SSR) and static site generation (SSG).
   - Easy integration with API routes.
   - Optimized for SEO and page load performance.
   - Supports automatic routing and code splitting.

3. **Vue.js** - Progressive JavaScript Framework.

   - Easy to learn and integrate.
   - Good support for both single-page applications (SPA) and incremental integration.
   - Understandable template system.
   - Good performance and small size.

4. **Angular** - Comprehensive platform and framework.

   - Developed by Google.
   - TypeScript-based, providing type checking.
   - Full-featured framework with routing, form handling, HTTP client, etc.
   - Two-way data binding.

5. **Svelte** - Modern framework.

   - Instead of Virtual DOM, it compiles code into optimized JavaScript.
   - Less boilerplate code, easy to read.
   - High performance and small bundle size.

6. **Bootstrap & Tailwind CSS** - CSS frameworks.
   - Bootstrap: Provides many pre-designed UI components.
   - Tailwind CSS: Utility-first CSS framework, highly flexible.

**Framework Comparison:**

| Framework | Learning Curve | Performance | Community | Documentation | Size |
| --------- | -------------- | ----------- | --------- | ------------- | ---- |
| React     | Medium         | High        | Very Large| Good          | Light|
| Next.js   | Easy           | Very High   | Large     | Good          | Light|
| Vue.js    | Easy           | High        | Large     | Very Good     | Very Light|
| Angular   | Hard           | Good        | Large     | Good          | Heavy|
| Svelte    | Easy           | Very High   | Medium    | Good          | Very Light|

## 🧑‍🏫 Lesson 2: Introduction to React.js

### What is React?

- A JavaScript library for building user interfaces.
- Focuses on building UI based on components.
- Uses Virtual DOM to optimize rendering performance.
- You should refer to the official documentation at [reactjs.org](https://reactjs.org/) for the latest information and more detailed instructions.

### Installing and Initializing a React Project

```bash
# Using Create React App
npx create-react-app my-app
cd my-app
npm start

# Using Vite (faster)
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

### JSX - JavaScript XML

```jsx
// JSX is a syntax extension to JavaScript for describing UI
const element = <h1>Hello, world!</h1>;

// JSX with expressions
const name = "John";
const element = <h1>Hello, {name}!</h1>;

// JSX with attributes
const element = <img src={user.avatarUrl} alt="Avatar" />;

// JSX with multiple elements (must have a wrapper root element)
const element = (
  <div>
    <h1>Hello!</h1>
    <p>Welcome to React</p>
  </div>
);

// Or using React Fragment
const element = (
  <>
    <h1>Hello!</h1>
    <p>Welcome to React</p>
  </>
);
```

### Components

```jsx
// Function component (recommended)
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

// Using component
const element = <Welcome name="Sara" />;
```

### Props and State

```jsx
// Props - data passed from parent to child component
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

// State - internal data of component, can change
import { useState } from "react";

function Counter() {
  // Initialize state with useState hook
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
    </div>
  );
}
```

### Component Lifecycle with useEffect

```jsx
import { useState, useEffect } from "react";

function Example() {
  const [count, setCount] = useState(0);

  // Similar to componentDidMount and componentDidUpdate
  useEffect(() => {
    // Update document title when count changes
    document.title = `You clicked ${count} times`;

    // Return a cleanup function (similar to componentWillUnmount)
    return () => {
      document.title = "React App";
    };
  }, [count]); // Only re-run if count changes

  // useEffect without dependencies array runs after every render
  useEffect(() => {
    console.log("Component rendered");
  });

  // useEffect with empty dependencies array runs only after first render
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

### Event Handling

```jsx
function Button() {
  // Event handler
  const handleClick = (e) => {
    e.preventDefault();
    console.log("Button clicked");
  };

  return <button onClick={handleClick}>Click me</button>;
}

// Passing parameters to event handler
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

### Lists and Keys

```jsx
function NumberList({ numbers }) {
  const listItems = numbers.map((number) => (
    <li key={number.toString()}>{number}</li>
  ));

  return <ul>{listItems}</ul>;
}

// With object array
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
  // Using if condition
  if (isLoggedIn) {
    return <h1>Welcome back!</h1>;
  }
  return <h1>Please sign in.</h1>;
}

// Using ternary operator
function Greeting({ isLoggedIn }) {
  return <h1>{isLoggedIn ? "Welcome back!" : "Please sign in"}</h1>;
}

// Using && operator (short-circuit)
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

### Forms and Inputs

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

## 🧑‍🏫 Lesson 3: State Management in React

### What is State Management?

- Managing the state of an application, especially when the app is large and complex.
- Helps share data between components without passing props through many levels.
- Provides an organized approach to managing global state.

### Context API

```jsx
// 1. Create context
import { createContext, useState, useContext } from "react";

const ThemeContext = createContext();

// 2. Create provider
function ThemeProvider({ children }) {
  const [theme, setTheme] = useState("light");

  const toggleTheme = () => {
    setTheme(theme === "light" ? "dark" : "light");
  };

  // Value passed down to consumer
  const value = { theme, toggleTheme };

  return (
    <ThemeContext.Provider value={value}>{children}</ThemeContext.Provider>
  );
}

// 3. Use custom hook to access context
function useTheme() {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error("useTheme must be used within a ThemeProvider");
  }
  return context;
}

// 4. Use in component
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

// 5. Wrap app in provider
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

- Redux is a popular state management library for JavaScript.
- Provides a global store to hold the application state.
- Based on three main principles:
  1. Single source of truth (store).
  2. State is read-only (changes only via actions).
  3. Changes are made with pure functions (reducers).
- Redux is powerful but can be complex for small applications.

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

// Component using Redux
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

### Redux Toolkit - Modern Approach

- Redux Toolkit is the official toolset for efficient Redux development.
- Provides simpler APIs to create store, reducer, and actions.
- Integrated middleware like Redux Thunk for async logic.
- Helps reduce boilerplate code and easier Redux setup.

```bash
npm install @reduxjs/toolkit react-redux
```

```jsx
import { createSlice, configureStore } from "@reduxjs/toolkit";

// Slice (combines action creators and reducer)
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

// Create store
const store = configureStore({
  reducer: {
    todos: todosSlice.reducer,
  },
});

// Use in component
function TodoApp() {
  const todos = useSelector((state) => state.todos);
  const dispatch = useDispatch();

  const handleAddTodo = (text) => {
    dispatch(addTodo(text));
  };
}
```

## 🧑‍🏫 Lesson 4: Routing in React

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

// Component with params
function UserDetail() {
  // Get params from URL
  const { id } = useParams();
  return <h2>User ID: {id}</h2>;
}

// Programmatic navigation
function Profile() {
  const navigate = useNavigate();

  const handleLogout = () => {
    // Handle logout...
    navigate("/login"); // Redirect to login page
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

// Layout component with Outlet
import { Outlet } from "react-router-dom";

function Layout() {
  return (
    <div>
      <header>
        <nav>{/* navigation links */}</nav>
      </header>

      <main>
        <Outlet /> {/* Child route content will render here */}
      </main>

      <footer>{/* footer content */}</footer>
    </div>
  );
}
```

### Protected Routes

```jsx
import { Navigate } from "react-router-dom";

// Custom component to protect routes
function ProtectedRoute({ children }) {
  const { user } = useAuth(); // Custom hook to check authentication

  if (!user) {
    // Redirect to login if not authenticated
    return <Navigate to="/login" replace />;
  }

  return children;
}

// Use in routes
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

## 🧑‍🏫 Lesson 5: Introduction to Node.js and NPM

### What is Node.js?

- JavaScript runtime environment on the server-side.
- Built on Google Chrome's V8 JavaScript engine.
- Allows running JavaScript outside the browser.
- Event-driven, asynchronous design.
- Suitable for real-time applications and APIs.

### NPM (Node Package Manager)

- The world's largest software registry.
- Tool to install and manage third-party libraries.
- Manages project dependencies.

### Installing Node.js and NPM

- Download from [nodejs.org](https://nodejs.org/).
- Verify installation:

```bash
node -v
npm -v
```

### Basic NPM Usage

```bash
# Initialize new project (create package.json)
npm init

# Quick init with defaults
npm init -y

# Install package
npm install package-name

# Install package and save to dependencies
npm install package-name --save

# Install package and save to devDependencies
npm install package-name --save-dev

# Install package globally
npm install -g package-name

# Install all dependencies from package.json
npm install

# Uninstall package
npm uninstall package-name

# Update packages
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

### Running Scripts

```bash
# Run script defined in package.json
npm run script-name

# Run start script
npm start

# Run test script
npm test
```

## 🧑‍🏫 Lesson 6: Build Tools and Bundlers

### What are Bundlers?

- Tools that bundle all JavaScript, CSS, and assets into bundles.
- Allows splitting code into smaller, manageable modules.
- Optimizes bundle size and page load performance.

### Webpack

- Most popular bundler for JavaScript.
- Features:
  - Code splitting.
  - Lazy loading.
  - Supports various assets via loaders.
  - Bundle optimization with plugins.

```js
// Basic webpack.config.js
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

- Modern build tool, fast for modern web.
- Uses ES modules for fast dev server startup.
- Uses Rollup for production build.

```bash
# Create new project with Vite
npm create vite@latest my-app -- --template react

# Start dev server
npm run dev

# Build production
npm run build
```

### Babel

- JavaScript compiler.
- Transforms modern JavaScript code into a backward-compatible version for older browsers.
- Supports JSX, TypeScript, and ES next features.

```js
// babel.config.js
module.exports = {
  presets: ["@babel/preset-env", "@babel/preset-react"],
  plugins: ["@babel/plugin-proposal-class-properties"],
};
```

### ESLint and Prettier

- ESLint: Tool for finding and fixing problems in JavaScript.
- Prettier: Code formatter, ensuring consistent code style.

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

## 🧑‍🏫 Lesson 7: Backend APIs with Express.js

### What is Express.js?

- Lightweight, flexible web framework for Node.js.
- Provides robust features for building web and API applications.
- Middleware system for handling requests and responses.

### Installation and Setup

```bash
npm install express nodemon
```

> nodemon is a tool that helps automatically restart the server when code changes.

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

// Middleware to parse JSON requests
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Simple route
app.get("/", (req, res) => {
  res.send("Hello World!");
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

```bash
# Run app in dev mode
npm run dev
```

### Routing

```js
// Basic routes
app.get("/users", (req, res) => {
  // Handle GET request for /users
  res.json({ users: ["User1", "User2", "User3"] });
});

app.post("/users", (req, res) => {
  // Handle POST request for /users
  console.log(req.body); // Data from client
  res.status(201).send("User created");
});

app.put("/users/:id", (req, res) => {
  // Get params from URL
  const userId = req.params.id;
  // Handle PUT request for /users/:id
  res.send(`Updating user ${userId}`);
});

app.delete("/users/:id", (req, res) => {
  // Handle DELETE request
  res.send(`Deleting user ${req.params.id}`);
});

// Route with query parameters
app.get("/products", (req, res) => {
  // Access query params: /products?category=electronics&sort=price
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

// Mount router on /api/users path
app.use("/api/users", userRoutes);
```

### Middleware

```js
// Custom middleware
function logger(req, res, next) {
  console.log(`${req.method} ${req.url} - ${new Date()}`);
  next(); // Pass request to next middleware
}

// Apply middleware to all routes
app.use(logger);

// Apply middleware to a specific route
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

### Connecting to Database (MongoDB)

- You can visit [MongoDB](https://www.mongodb.com/) to create an account and create a cloud database or install MongoDB locally.

```bash
npm install mongoose
```

```js
const mongoose = require("mongoose");

// Connect MongoDB
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

// Define Schema
const userSchema = new mongoose.Schema({
  name: String,
  email: { type: String, unique: true },
  password: String,
  createdAt: { type: Date, default: Date.now },
});

// Create Model
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

// API routes with database
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

## 🧑‍🏫 Lesson 8: REST API and RESTful Services

### What is REST (Representational State Transfer)?

- Architectural style for web services.
- Uses HTTP methods to manipulate resources.
- Stateless: server does not store client state.
- Uniform interface: consistent interface between components.

### REST Principles

1. **Client-Server**: Separation of client and server.
2. **Stateless**: Each request must contain sufficient info, server doesn't save session.
3. **Cacheable**: Responses can be cached.
4. **Uniform Interface**: Simple, consistent interface.
5. **Layered System**: Layered architecture, client doesn't know if connected directly or via intermediary.
6. **Code on Demand**: Server can extend client functionality by sending code (optional).

### HTTP Methods in REST

| Method | CRUD | Description |
| ------ | -------------- | --------------------------------- |
| GET | Read | Retrieve resource from server |
| POST | Create | Create new resource |
| PUT | Update/Replace | Update entire existing resource |
| PATCH | Update/Modify | Update part of resource |
| DELETE | Delete | Delete resource |

### RESTful API Conventions

```text
# Get list of users
GET /api/users

# Get specific user info
GET /api/users/:id

# Create new user
POST /api/users

# Update entire user info
PUT /api/users/:id

# Update partial user info
PATCH /api/users/:id

# Delete user
DELETE /api/users/:id

# Get posts of user
GET /api/users/:id/posts

# Get comments of post
GET /api/posts/:id/comments
```

### Status Codes in REST API

- You can refer to full HTTP status codes [here](https://devtools.klpod221.com/web/http-status)

```text

- **2xx Success**

  - 200 OK: Request successful
  - 201 Created: Resource created successfully
  - 204 No Content: Request successful but no content returned

- **3xx Redirection**

  - 301 Moved Permanently: Resource moved to new URL
  - 304 Not Modified: Resource unchanged since last request

- **4xx Client Error**

  - 400 Bad Request: Syntax error, invalid request
  - 401 Unauthorized: Client needs authentication
  - 403 Forbidden: Client does not have access rights
  - 404 Not Found: Resource not found
  - 422 Unprocessable Entity: Request well-formed but cannot be processed

- **5xx Server Error**
  - 500 Internal Server Error: Error during request processing
  - 502 Bad Gateway: Server received invalid response from upstream server
  - 503 Service Unavailable: Server temporarily unavailable
```

### API Documentation with Swagger/OpenAPI

```javascript
// Using swagger-jsdoc and swagger-ui-express to create docs
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

// Route with Swagger annotation
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

- CORS is a security mechanism that allows or denies requests from different origins.
- Helps protect web applications from Cross-Site Request Forgery (CSRF) attacks.

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

- Limit the number of requests from an IP address within a certain time frame.
- Helps protect the application from DDoS and brute-force attacks.

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

## 🧑‍🏫 Lesson 9: Deployment and Basic CI/CD

### Popular Hosting Platforms

1. **Vercel** - Best for Next.js and SPAs.

   - Zero-config deployment.
   - Preview deployments for each pull request.
   - Global CDN.

2. **Netlify** - Good for static sites and Jamstack.

   - Integrated CI/CD.
   - Serverless functions.
   - Form handling.

3. **Heroku** - Simple PaaS, supports many languages.

   - Easy to use.
   - Add-ons for databases and services.
   - Free tier for testing (discontinued).

4. **AWS (Amazon Web Services)** - Full-featured, more complex.

   - Many services: EC2, S3, Lambda, Amplify...
   - High scalability and flexibility.
   - Pay-as-you-go model.

5. **Firebase** - Google's development platform.
   - Realtime Database.
   - Authentication.
   - Hosting.
   - Functions (serverless).

### Deploying to Vercel

- Refer to [Vercel](https://vercel.com/docs) documentation.

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
vercel

# Deploy with production config
vercel --prod
```

### Deploying to Netlify

- Refer to [Netlify](https://docs.netlify.com/) documentation.

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Init new site
netlify init

# Deploy production build
netlify deploy --prod
```

### Configuring Continuous Integration/Continuous Deployment (CI/CD)

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

1. Link GitHub/GitLab/Bitbucket repository with Netlify.
2. Configure build command (e.g., `npm run build`).
3. Configure publish directory (e.g., `build` or `dist`).
4. Automatically deploy when pushing to main branch.

### Basic Docker for Deployment

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

## 🧪 FINAL PROJECT: Building a Full-Stack App with React and Express

### Assignment

Build a simple Blog application with React on the frontend and Express on the backend.

### Requirements

1. **Backend (Express.js):**

   - API endpoints for CRUD operations (Create, Read, Update, Delete) for posts.
   - Authentication with JWT (JSON Web Tokens).
   - Data storage (can use MongoDB or SQLite).
   - Middleware for error handling and validation.

2. **Frontend (React):**

   - Use React Router for navigation.
   - State management (Context API or Redux).
   - Form handling with validation.
   - Authentication UI (login, register).
   - Responsive design.

3. **App Features:**

   - Users can register and login.
   - Authenticated users can create, edit, delete posts.
   - All users can view list of posts and post details.
   - Search and filter posts.

4. **Deployment:**
   - Backend: Vercel, Heroku, or Render.
   - Frontend: Vercel or Netlify.
   - Configure API calls between frontend and backend.

### Suggested Project Structure

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

### Evaluation

- Features are complete and work correctly.
- Code is structured, clean, and commented.
- Full error handling and validation.
- User-friendly UI/UX.
- Responsive on multiple devices.
- Successful deployment.
