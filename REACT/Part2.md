# 📘 PART 2: STATE AND INTERACTIVITY

## 🎯 General Objectives

- Understand the `state` concept and its role in creating dynamic components.
- Use the `useState` Hook to manage component state.
- Handle user events like clicks and input.
- Use conditional rendering to show or hide UI elements.
- Master rendering lists and the importance of `key`.

## 🧑‍🏫 Lesson 1: State and `useState` Hook

### What is State?

- **State** is a component's private data that can change over time (usually due to user interaction).
- When **state** changes, React will automatically **re-render** that component to update the interface.
- **Props** are for passing data from parent to child, while **State** is for managing a component's internal data.

State operation diagram:

```text
[ User interaction (e.g., click) ]
    |
    V
[ Call setState() function ]
    |
    V
[ State changes ]
    |
    V
[ React re-renders Component ]
    |
    V
[ Interface is updated ]
```

### Introducing `useState` Hook

`useState` is a **Hook** that allows you to add state to function components.

```jsx
import { useState } from 'react';

function Counter() {
  // Declare a state variable named `count`
  // `setCount` is a function to update the value of `count`
  const [count, setCount] = useState(0); // 0 is the initial value

  return (
    <div>
      <p>You clicked {count} times</p>
      {/* Will learn in next lesson */}
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}
```

### Updating State

- **Never** change state directly: `count = count + 1;` (WRONG)
- **Always** use the setter function provided by `useState`: `setCount(count + 1);` (CORRECT)
- When updating state based on old value, use callback form to ensure accuracy:

  ```jsx
  setCount(prevCount => prevCount + 1);
  ```

## 🧑‍🏫 Lesson 2: Handling Events

### Events in React

- Event names in React are written in `camelCase`, for example: `onClick`, `onChange`.
- You pass a function to the event handler, instead of a string.

```jsx
function AlertButton() {
  function handleClick() {
    alert('You clicked the button!');
  }

  return (
    <button onClick={handleClick}>
      Click here
    </button>
  );
}
```

### Passing Event Handlers via Props

You can pass event handlers from parent  component to child component.

Event flow diagram:

```text
[ Parent Component (defines onAction function) ] --(props: onAction)--> [ Child Component (Button) ]
                ^                                                               |
                |----------------(When clicked, calls props.onAction())---------|
```

```jsx
// Child: Button.jsx
function Button({ onCustomClick, children }) {
  return (
    <button onClick={onCustomClick}>
      {children}
    </button>
  );
}

// Parent: App.jsx
import Button from './Button';

function App() {
  function handlePlayClick() {
    alert('Playing video!');
  }
  function handleUploadClick() {
    alert('Uploading!');
  }
  return (
    <div>
      <Button onCustomClick={handlePlayClick}>Play Video</Button>
      <Button onCustomClick={handleUploadClick}>Upload</Button>
    </div>
  );
}
```

## 🧑‍🏫 Lesson 3: Conditional Rendering and Lists

### Conditional Rendering

You can use JavaScript conditional expressions to decide which UI part will be rendered.

```jsx
function UserGreeting({ isLoggedIn }) {
  // Method 1: Using if/else
  if (isLoggedIn) {
    return <h1>Welcome back!</h1>;
  }
  return <h1>Please log in.</h1>;

  // Method 2: Using ternary operator (commonly used in JSX)
  return (
    <div>
      {isLoggedIn ? <p>You are logged in</p> : <p>You are not logged in</p>}
    </div>
  );

  // Method 3: Using && operator (render only if condition is true)
  return (
    <div>
      {isLoggedIn && <p>Your cart</p>}
    </div>
  );
}
```

### Rendering Lists and the `key` Attribute

Use the `.map()` function to transform a data array into an array of React elements.

- **`key`** is a special attribute you need to provide when creating a list of elements.
- `key` helps React identify which elements have changed, been added, or removed.
- `key` must be a **unique** string or number within its sibling list. Usually use the data's `id`.

```jsx
function ProductList({ products }) {
  const listItems = products.map(product =>
    <li key={product.id}>
      {product.name}
    </li>
  );

  return <ul>{listItems}</ul>;
}
```

**Note:** Don't use array index as `key` if the list can change order, add, or remove items.

## 🧑‍🏫 Lesson 4: Basic Form Handling

### Controlled Components

In HTML, form tags like `<input>`, `<textarea>` manage their own state. In React, we can make the React component the "single source of truth" by using state. An input element whose value is controlled by React is called a "controlled component".

```jsx
import { useState } from 'react';

function NameForm() {
  const [name, setName] = useState('');

  function handleChange(event) {
    setName(event.target.value);
  }

  function handleSubmit(event) {
    event.preventDefault(); // Prevent browser reload
    alert('Name submitted: '.concat(name));
  }

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Name:
        <input type="text" value={name} onChange={handleChange} />
      </label>
      <input type="submit" value="Submit" />
    </form>
  );
}
```

## 🧪 FINAL PROJECT: Add cart and interaction to "SimpleStore"

### Problem Description

Upgrade the "SimpleStore" page created in Part 1. Add functionality allowing users to "Add to cart" and view the total number of products in cart.

### Requirements

1. **Component `Header.jsx`:**
    - Use `useState` to manage number of products in cart (`cartCount`).
    - Display `cartCount` in top right corner of header. Example: `Cart (0)`.
2. **Component `App.jsx`:**
    - Manage cart state, can be an array of products in cart: `const [cart, setCart] = useState([]);`
    - Write a `handleAddToCart(product)` function to handle adding product to cart. This function will be passed down to `ProductList` and `ProductCard`.
        - Logic inside: `setCart(prevCart => [...prevCart, product]);`
3. **Component `ProductCard.jsx`:**
    - Receive `onAddToCart` function from `props`.
    - Add an "Add to Cart" button.
    - When clicking this button, call `onAddToCart` function and pass that card's product information.
4. **Connecting components:**
    - `App` component will pass `handleAddToCart` function down to `ProductList`.
    - `ProductList` will pass that function further down to each `ProductCard`.
    - When a product is added to cart (state `cart` in `App` changes), `App` will calculate total quantity and pass down to `Header` to update display.
        - Diagram: `App (state: cart) --(props: cart.length)--> Header`
        - Diagram: `App (function: handleAddToCart) --props--> ProductList --props--> ProductCard`

**Goal:** At the end of this part, your application will be interactive. Users can click buttons and see the interface (cart quantity) updated immediately.
