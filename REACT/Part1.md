# 📘 PART 1: REACT FUNDAMENTALS

## 🎯 General Objectives

- Understand basic React concepts, why it was created and its role in modern web development.
- Master JSX syntax for describing user interfaces.
- Know how to create and use Components to build modular interfaces.
- Understand and use `props` to pass data from parent component to child component.

## 🧑‍🏫 Lesson 1: React Introduction and Environment

### What is React?

- React is an open-source JavaScript library for building user interfaces (UI).
- Developed by Facebook.
- React operates based on the concept of **Components** - independent and reusable building blocks.
- React uses the **Virtual DOM** to optimize UI updates and rendering, making applications fast and efficient.

Basic operation diagram:

```text
[ Data (State/Props) ] ----> [ React Component ] ----> [ UI (Interface) ]
```

### Environment Setup (Vite)

We will use Vite, a modern build tool, to quickly create a React project.

Open the terminal and run the following command:

```bash
# Using npm
npm create vite@latest simple-store -- --template react

# Or using yarn
# yarn create vite simple-store --template react

# Navigate to project directory
cd simple-store

# Install dependencies
npm install

# Run development server
npm run dev
```

Access `http://localhost:5173` (or other port displayed in terminal) to view your application.

## 🧑‍🏫 Lesson 2: JSX - JavaScript XML

### JSX Syntax

JSX is a syntax extension for JavaScript that allows you to write HTML-like code directly in JavaScript files.

```jsx
// src/App.jsx

// Instead of writing:
// return React.createElement('h1', {className: 'greeting'}, 'Hello, world!');

// We write with JSX:
function App() {
  return <h1>Hello, world!</h1>;
}

export default App;
```

**Notes:**

- `class` in HTML is written as `className` in JSX.
- All tags must be closed (`<br>` must become `<br />`).
- Component can only return a single root element. Use Fragment (`<>...</>`) if needed.

### Embedding JavaScript Expressions in JSX

You can embed any JavaScript expression in JSX by placing it in curly braces `{}`.

```jsx
// src/App.jsx

function App() {
  const name = "React Developer";
  const product = {
    title: "Laptop Pro",
    price: 25000000
  };

  return (
    <>
      <h1>Hello, {name}!</h1>
      <p>Product: {product.title}</p>
      <p>Price: {product.price.toLocaleString()} VND</p>
      <p>Current Year: {new Date().getFullYear()}</p>
    </>
  );
}

export default App;
```

## 🧑‍🏫 Lesson 3: Components and Props

### Function Components

Components are independent JavaScript functions that accept `props` as input and return React elements describing what should appear on screen.

```jsx
// src/components/Greeting.jsx
function Greeting() {
  return <h2>Welcome to our store!</h2>;
}

export default Greeting;
```

### Props (Properties)

Props (short for properties) is the way to pass data from parent component to child component. Props are read-only objects.

Props flow diagram:

```text
[ App Component (data) ] ----(props)----> [ ProductCard Component ]
```

**Example:**

```jsx
// src/components/ProductCard.jsx
function ProductCard(props) {
  // props is an object: { name: "iPhone 15", price: 22000000 }
  return (
    <div className="product-card">
      <h3>{props.name}</h3>
      <p>Price: {props.price.toLocaleString()} VND</p>
    </div>
  );
}
export default ProductCard;

// src/App.jsx
import ProductCard from './components/ProductCard';

function App() {
  return (
    <div>
      <h1>Featured Products</h1>
      <ProductCard name="iPhone 15 Pro" price={30000000} />
      <ProductCard name="Macbook Air M2" price={28000000} />
    </div>
  );
}
export default App;
```

### Organizing Components

Create a component tree to manage the interface.

```text
App
├── Header.jsx
└── ProductList.jsx
    ├── ProductCard.jsx
    ├── ProductCard.jsx
    └── ...
```

## 🧪 FINAL PROJECT: Build static interface for "SimpleStore" page

### Problem Description

Create a web page displaying a list of products. Product data will be temporarily stored in a JavaScript array. The interface is completely static with no interaction.

### Requirements

1. **Directory Structure:**
    - Create `src/components` directory.
    - Inside, create component files: `Header.jsx`, `ProductList.jsx`, `ProductCard.jsx`.
2. **Data:**
    - In `src/App.jsx`, create a `products` array containing information for at least 4 products. Each product is an object with `id`, `name`, `price`, and `imageUrl`.
3. **Component `ProductCard.jsx`:**
    - Receive `name`, `price`, `imageUrl` via `props`.
    - Display product information in a `div` tag with simple styling.
4. **Component `ProductList.jsx`:**
    - Receive `products` array via `props`.
    - Use `.map()` function to iterate through `products` array and render a list of `ProductCard`s.
5. **Component `Header.jsx`:**
    - Display page title, for example: "Welcome to SimpleStore".
6. **Component `App.jsx`:**
    - Is the root component, import and arrange `Header` and `ProductList`.
    - Pass `products` array to `ProductList`.

**Goal:** At the end of this part, you will have a product list page built entirely with React components and static data.
