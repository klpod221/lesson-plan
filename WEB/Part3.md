---
prev:
  text: '🎨 CSS - Web Styling'
  link: '/WEB/Part2'
next:
  text: '⚙️ Frameworks & Tools'
  link: '/WEB/Part4'
---

# 📘 PART 3: JAVASCRIPT - WEB PROGRAMMING

## 🎯 General Objectives

- Understand JavaScript and its role in web development.
- Master the syntax and basic structures of JavaScript.
- Know how to manipulate the DOM to create dynamic web pages.
- Handle events, call APIs, and process data.

## 🧑‍🏫 Lesson 1: Introduction to JavaScript

### What is JavaScript?

- It is a client-side scripting language.
- It is embedded into HTML pages to create interactivity.
- It can change HTML content, attributes, CSS, and react to events.
- Currently, it is also used server-side (Node.js) and in mobile apps (React Native).

### How to Add JavaScript to HTML

1. **Inline JavaScript**: Using attributes like `onclick`, `onload`, ... (not recommended).

   ```html
   <button onclick="alert('Hello!')">Click here</button>
   ```

2. **Internal JavaScript**: Using the `<script>` tag inside the HTML page.

   ```html
   <button onclick="sayHello()">Click here</button>
   <script>
     function sayHello() {
       alert("Hello World!");
     }
   </script>
   ```

3. **External JavaScript**: Creating a separate JS file and linking it to HTML.

   ```html
   <script src="script.js"></script>
   ```

### Where to Place JavaScript

```html
<!DOCTYPE html>
<html>
  <head>
    <!-- JavaScript in head -->
    <script src="head-script.js"></script>
  </head>
  <body>
    <!-- Page content -->

    <!-- JavaScript at end of body (recommended) -->
    <script src="body-script.js"></script>
  </body>
</html>
```

| Placement | Pros | Cons |
| ---------------------- | ----------------------------------------------------------------------- | ----------------------------------------------- |
| JavaScript in head | Loads before content displays, can be used immediately | Can block page rendering, no immediate interaction |
| JavaScript at end of body | Loads after content displays, doesn't block rendering, immediate interaction | Cannot be used before DOM is ready |

- **Recommendation**: Place JavaScript at the end of the body to avoid slowing down page loading and ensure the DOM is ready before code execution.
- **Note**:
  - If you need to use JavaScript in the head, you can use the `DOMContentLoaded` event to ensure the DOM is ready.
  - If using `async` or `defer` in the `<script>` tag, the JavaScript code will be loaded asynchronously and won't block page loading.

    ```html
    <!-- Loads asynchronously, executes immediately when done -->
    <script src="script.js" async></script>
    ```

    ```html
    <!-- Loads synchronously, executes after DOM is ready -->
    <script src="script.js" defer></script>
    ```

### Output in JavaScript

```javascript
// Display popup alert
alert("Hello World!");

// Write to console
console.log("Hello World!");

// Write to HTML page
document.write("<p>Hello World!</p>");

// Fill into an HTML element
document.getElementById("demo").innerHTML = "Hello World!";
```

### Running JavaScript without a Browser (via Node.js)

- **Node.js** is a JavaScript runtime environment outside the browser, allowing you to run JavaScript on a server or personal computer (you will learn Node.js in more detail later).
- Install Node.js from the official site: [nodejs.org](https://nodejs.org/)
- After installation, you can run JavaScript code from the command line using the `node` command:

```bash
node script.js
```

- You can use VSCode to debug JavaScript code as follows [reference](https://code.visualstudio.com/docs/nodejs/working-with-javascript):

  - Open the JavaScript file in VSCode.
  - Press `F5` or go to the menu `Run > Start Debugging`.
  - Select the `Node.js` environment.
  - Set breakpoints and monitor variables during execution.

- **Note**:
  - Node.js does not support the DOM, so you cannot use methods like `document.getElementById()` or `alert()`.
  - You can use modules like `fs` to manipulate the file system, or `http` to create an HTTP server.

## 🧑‍🏫 Lesson 2: Syntax and Variables in JavaScript

### Variable Declaration

```javascript
// Declare variable with var (function-scoped)
var name = "John";

// Declare variable with let (block-scoped, ES6)
let age = 30;

// Declare constant with const (cannot change value, ES6)
const PI = 3.14159;

// Declare multiple variables
let firstName = "John",
  lastName = "Doe",
  fullName = firstName + " " + lastName;
```

- Prefer `let` and `const` over `var` to avoid variable scope issues.
- `const` is used for variables whose values do not change, but if it is an object or array, the internal content can be modified.

```javascript
const person = {
  name: "John",
  age: 30,
};

person.age = 31; // Allowed
person = {}; // Error: Assignment to constant variable
```

### Data Types

```javascript
// Number
let count = 10;
let price = 99.99;

// String
let text = "Hello World";
let quote = 'JavaScript is "fun"';

// Boolean
let isActive = true;
let isComplete = false;

// Null and Undefined
let empty = null;
let notDefined; // undefined

// Object
let person = {
  firstName: "John",
  lastName: "Doe",
  age: 30,
};

// Array
let colors = ["Red", "Green", "Blue"];

// Check data type
console.log(typeof count); // "number"
console.log(typeof text); // "string"
console.log(typeof isActive); // "boolean"
console.log(typeof person); // "object"
console.log(typeof colors); // "object" (array is a type of object)
```

### Floating Point

- JavaScript uses floating-point numbers to represent real numbers, equivalent to the IEEE 754 standard. This can lead to some precision issues when performing arithmetic with real numbers. Let's look at the following example:

```javascript
// Real numbers
let a = 0.1;
let b = 0.2;
let sum = a + b; // 0.30000000000000004
console.log(sum); // 0.30000000000000004

// Comparing real numbers
console.log(sum === 0.3); // false
```

- This also happens with other programming languages that use floating-point numbers like Python, Java, C++, etc. So why is that?
  - JavaScript stores real numbers in binary format, and some real numbers cannot be represented exactly in binary.
  - To avoid this problem, you can use rounding methods or external libraries like `decimal.js` to handle floating-point arithmetic.

```javascript
// Rounding number
let roundedSum = Math.round((a + b) * 100) / 100; // 0.3
console.log(roundedSum); // 0.3
```

### Operators and Expressions

```javascript
// Arithmetic operators
let x = 10,
  y = 5;
let sum = x + y; // 15
let diff = x - y; // 5
let product = x * y; // 50
let quotient = x / y; // 2
let remainder = x % y; // 0
let power = x ** y; // 100000 (ES6)

// Assignment operators
let a = 10;
a += 5; // a = a + 5 = 15
a -= 3; // a = a - 3 = 12
a *= 2; // a = a * 2 = 24
a /= 4; // a = a / 4 = 6
a %= 4; // a = a % 4 = 2

// Increment/Decrement operators
let i = 5;
i++; // i = 6 (post-increment)
++i; // i = 7 (pre-increment)
i--; // i = 6 (post-decrement)
--i; // i = 5 (pre-decrement)

// String operators
let greeting = "Hello";
let name = "World";
let message = greeting + " " + name; // "Hello World"

// Template literals (ES6)
let templateMessage = `${greeting} ${name}!`; // "Hello World!"
let multiline = `Line 1
Line 2
Line 3`;
```

### Variable Scope

```javascript
// Global scope
let globalVar = "I am global";

function exampleFunction() {
  // Function scope
  var functionVar = "I am function-scoped";

  if (true) {
    // Block scope
    let blockVar = "I am block-scoped";
    var notReallyBlockVar = "I am still function-scoped";

    console.log(globalVar); // Accessible
    console.log(functionVar); // Accessible
    console.log(blockVar); // Accessible
    console.log(notReallyBlockVar); // Accessible
  }

  console.log(globalVar); // Accessible
  console.log(functionVar); // Accessible
  // console.log(blockVar);      // Error: blockVar is not defined
  console.log(notReallyBlockVar); // Accessible
}

console.log(globalVar); // Accessible
// console.log(functionVar);     // Error: functionVar is not defined
// console.log(blockVar);        // Error: blockVar is not defined
// console.log(notReallyBlockVar); // Error: notReallyBlockVar is not defined
```

## 🧑‍🏫 Lesson 3: Control Structures

### Conditional Statements

```javascript
// if
let age = 18;
if (age >= 18) {
  console.log("You are eligible to vote");
}

// if-else
if (age >= 18) {
  console.log("You are eligible to vote");
} else {
  console.log("You are not eligible to vote");
}

// if-else if-else
let score = 75;
if (score >= 90) {
  console.log("Excellent");
} else if (score >= 80) {
  console.log("Good");
} else if (score >= 70) {
  console.log("Fair");
} else if (score >= 60) {
  console.log("Average");
} else {
  console.log("Poor");
}

// Ternary operator
let status = age >= 18 ? "Adult" : "Minor";

// Switch case
let day = 3;
let dayName;

switch (day) {
  case 1:
    dayName = "Sunday";
    break;
  case 2:
    dayName = "Monday";
    break;
  case 3:
    dayName = "Tuesday";
    break;
  case 4:
    dayName = "Wednesday";
    break;
  case 5:
    dayName = "Thursday";
    break;
  case 6:
    dayName = "Friday";
    break;
  case 7:
    dayName = "Saturday";
    break;
  default:
    dayName = "Invalid day";
}
console.log(dayName); // "Tuesday"
```

### Loops

```javascript
// for
for (let i = 0; i < 5; i++) {
  console.log(i); // 0, 1, 2, 3, 4
}

// for...in (iterate object properties)
const person = { name: "John", age: 30, job: "Developer" };
for (let key in person) {
  console.log(`${key}: ${person[key]}`);
}

// for...of (iterate array/collection elements, ES6)
const colors = ["red", "green", "blue"];
for (let color of colors) {
  console.log(color);
}

// while
let i = 0;
while (i < 5) {
  console.log(i);
  i++;
}

// do...while
let j = 0;
do {
  console.log(j);
  j++;
} while (j < 5);

// break and continue
for (let i = 0; i < 10; i++) {
  if (i === 5) {
    break; // Exit loop when i = 5
  }
  console.log(i); // 0, 1, 2, 3, 4
}

for (let i = 0; i < 10; i++) {
  if (i === 5) {
    continue; // Skip iteration when i = 5
  }
  console.log(i); // 0, 1, 2, 3, 4, 6, 7, 8, 9
}
```

## 🧑‍🏫 Lesson 4: Functions in JavaScript

### Function Definition

```javascript
// Function declaration
function greet(name) {
  return `Hello, ${name}!`;
}

// Function expression
const sayHello = function (name) {
  return `Hello, ${name}!`;
};

// Arrow function (ES6)
const welcome = (name) => {
  return `Welcome, ${name}!`;
};

// Concise Arrow function
const shortWelcome = (name) => `Welcome, ${name}!`;

// Function calls
console.log(greet("John")); // "Hello, John!"
console.log(sayHello("Jane")); // "Hello, Jane!"
console.log(welcome("Bob")); // "Welcome, Bob!"
console.log(shortWelcome("Alice")); // "Welcome, Alice!"
```

- Differences between function declaration, function expression, and arrow function:
  - **Function declaration**: Can be called before declaration (hoisting).
  - **Function expression**: Cannot be called before declaration.
  - **Arrow function**: Does not have its own `this`, `arguments`, cannot be used as a constructor.

```javascript
// Hoisting
console.log(hoistedFunction()); // "Hoisted!"
function hoistedFunction() {
  return "Hoisted!";
}
// console.log(notHoistedFunction()); // Error: notHoistedFunction is not a function
const notHoistedFunction = function () {
  return "Not hoisted!";
};
// Arrow function no 'this'
const arrowFunction = () => {
  console.log(this); // undefined in strict mode, window in non-strict mode
};
const obj = {
  name: "John",
  greet: function () {
    console.log(this.name); // "John"
  },
  arrowGreet: () => {
    console.log(this.name); // undefined
  },
};
};
obj.greet(); // "John"

obj.arrowGreet(); // undefined
```

### Function Parameters

```javascript
// Default parameters (ES6)
function greet(name = "Guest") {
  return `Hello, ${name}!`;
}
console.log(greet()); // "Hello, Guest!"
console.log(greet("John")); // "Hello, John!"

// Rest parameters (ES6)
function sum(...numbers) {
  return numbers.reduce((total, num) => total + num, 0);
}
console.log(sum(1, 2)); // 3
console.log(sum(1, 2, 3, 4, 5)); // 15

// Arguments object (old way)
function oldSum() {
  let total = 0;
  for (let i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}
```

### Scope and Closure

```javascript
// Lexical scope
let globalVar = "global";

function outer() {
  let outerVar = "outer";

  function inner() {
    let innerVar = "inner";
    console.log(globalVar); // Access global variable
    console.log(outerVar); // Access outer variable
    console.log(innerVar); // Access inner variable
  }

  inner();
}

// Closure - function remembers the environment in which it was created
function createCounter() {
  let count = 0;

  return function () {
    count++;
    return count;
  };
}

const counter = createCounter();
console.log(counter()); // 1
console.log(counter()); // 2
console.log(counter()); // 3
```

### Higher-order functions

```javascript
// Function taking another function as parameter
function doOperation(a, b, operationFn) {
  return operationFn(a, b);
}

function add(a, b) {
  return a + b;
}

function multiply(a, b) {
  return a * b;
}

console.log(doOperation(5, 3, add)); // 8
console.log(doOperation(5, 3, multiply)); // 15

// Function returning another function
function createMultiplier(factor) {
  return function (number) {
    return number * factor;
  };
}

const double = createMultiplier(2);
const triple = createMultiplier(3);

console.log(double(5)); // 10
console.log(triple(5)); // 15
```

## 🧑‍🏫 Lesson 5: Objects and Arrays

### Object

```javascript
// Create object with object literal
const person = {
  firstName: "John",
  lastName: "Doe",
  age: 30,
  hobbies: ["reading", "music", "sports"],
  address: {
    street: "123 Main St",
    city: "New York",
    country: "USA",
  },
  fullName: function () {
    return this.firstName + " " + this.lastName;
  },
};

// Access properties
console.log(person.firstName); // "John"
console.log(person["lastName"]); // "Doe"
console.log(person.address.city); // "New York"
console.log(person.fullName()); // "John Doe"

// Add/Edit properties
person.email = "john.doe@example.com";
person.age = 31;

// Delete property
delete person.age;

// Check if property exists
console.log("email" in person); // true
console.log(person.hasOwnProperty("age")); // false

// Object methods
console.log(Object.keys(person)); // ["firstName", "lastName", "hobbies", "address", "fullName", "email"]
console.log(Object.values(person)); // [Array of values]
console.log(Object.entries(person)); // [Array of key-value pairs]

// Object destructuring (ES6)
const {
  firstName,
  lastName,
  address: { city },
} = person;
console.log(firstName); // "John"
console.log(city); // "New York"
```

### Array

```javascript
// Create array
const fruits = ["Apple", "Banana", "Orange"];
const mixed = [1, "hello", true, { name: "John" }, [1, 2, 3]];
const newArray = new Array(1, 2, 3);

// Access elements
console.log(fruits[0]); // "Apple"
console.log(mixed[3].name); // "John"

// Modify element
fruits[1] = "Grape";

// Array properties
console.log(fruits.length); // 3

// Array methods
fruits.push("Mango"); // Add to end
const last = fruits.pop(); // Remove and return last element
const first = fruits.shift(); // Remove and return first element
fruits.unshift("Strawberry"); // Add to beginning

const newFruits = fruits.concat(["Kiwi", "Pineapple"]); // Concatenate arrays
const sliced = fruits.slice(1, 3); // Extract from index 1 to 2
fruits.splice(1, 1, "Peach", "Lemon"); // Remove 1 element at index 1, add 2 new elements

// Search
console.log(fruits.indexOf("Apple")); // Find first index, return -1 if not found
console.log(fruits.includes("Mango")); // true/false

// Sort
fruits.sort(); // Sort alphabetically
fruits.reverse(); // Reverse array

// Iterate array with higher-order functions
const numbers = [1, 2, 3, 4, 5];

// forEach: execute action on each element
numbers.forEach((num) => console.log(num * 2));

// map: create new array from original
const doubled = numbers.map((num) => num * 2);

// filter: filter elements by condition
const evenNumbers = numbers.filter((num) => num % 2 === 0);

// reduce: calculate accumulated value
const sum = numbers.reduce((total, num) => total + num, 0);

// find: find first element satisfying condition
const foundNumber = numbers.find((num) => num > 3);

// every: check if all elements satisfy condition
const allPositive = numbers.every((num) => num > 0);

// some: check if at least one element satisfies condition
const hasEven = numbers.some((num) => num % 2 === 0);

// Array destructuring (ES6)
const [first, second, ...rest] = [1, 2, 3, 4, 5];
console.log(first); // 1
console.log(second); // 2
console.log(rest); // [3, 4, 5]
```

## 🧑‍🏫 Lesson 6: DOM - Document Object Model

### What is the DOM?

- DOM (Document Object Model) is an API for HTML and XML.
- Represents the web page as a tree structure of nodes.
- Allows JavaScript to access and manipulate content, structure, and style of the webpage.

### Accessing DOM Elements

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Document Object Model</title>
  </head>
  <body>
    <header id="header">
      <h1>DOM Example</h1>
    </header>
    <div class="container">
      <p class="text">Hello World!</p>
      <button class="primary">Click me</button>
    </div>
  </body>
</html>
```

```javascript
// Access by ID
const header = document.getElementById("header");

// Access by class name (returns HTMLCollection)
const containers = document.getElementsByClassName("container");

// Access by tag name (returns HTMLCollection)
const paragraphs = document.getElementsByTagName("p");

// Access by CSS selector (returns first element)
const firstButton = document.querySelector("button");

// Access by CSS selector (returns NodeList)
const allButtons = document.querySelectorAll("button.primary");

// Access child nodes
const children = header.children; // Direct element children (HTMLCollection)
const childNodes = header.childNodes; // NodeList (includes text nodes)
const firstChild = header.firstChild; // First node (can be text node)
const firstElement = header.firstElementChild; // First Element

// Access parent node
const parent = header.parentNode;
const parentElement = header.parentElement;

// Access sibling nodes
const nextSibling = header.nextSibling;
const nextElement = header.nextElementSibling;
const prevSibling = header.previousSibling;
const prevElement = header.previousElementSibling;
```

### Modifying DOM Content

```javascript
// Change content
element.textContent = "New Content"; // Changes text only
element.innerHTML = "<strong>New</strong> HTML Content"; // Parses and changes HTML

// Change attributes
element.setAttribute("id", "newId");
element.id = "newId"; // Direct property access
const attrValue = element.getAttribute("data-value");
element.removeAttribute("title");

// Change style
element.style.color = "red";
element.style.backgroundColor = "lightblue";
element.style.fontSize = "16px";

// Add/Remove class
element.classList.add("active");
element.classList.remove("hidden");
element.classList.toggle("selected"); // Adds if missing, removes if present
element.classList.contains("active"); // Check if class exists
```

### Creating and Adding/Removing Elements

```javascript
// Create new element
const newDiv = document.createElement("div");
const textNode = document.createTextNode("New Content");

// Add content to element
newDiv.textContent = "Add Content";
newDiv.appendChild(textNode);

// Add to DOM
parentElement.appendChild(newDiv); // Add to end
parentElement.insertBefore(newDiv, referenceElement); // Add before reference element

// New insertion methods (ES6)
parentElement.append(newDiv, textNode); // Add multiple nodes to end
parentElement.prepend(newDiv); // Add to start
referenceElement.before(newDiv); // Add before element
referenceElement.after(newDiv); // Add after element
element.replaceWith(newDiv); // Replace element

// Remove element
parentElement.removeChild(childElement); // Old way
element.remove(); // New way (ES6)

// Clone element
const clone = element.cloneNode(true); // true: clone entire subtree, false: clone node only
```

## 🧑‍🏫 Lesson 7: Events and Event Handling

### What is an Event?

- An Event is an action or occurrence that happens in the browser, such as a mouse click, key press, page load, etc.
- JavaScript allows us to handle these events to create interactivity.
- Events can be triggered by the user (like clicks, input) or by the browser (like load, resize).

### Registering Events

```javascript
// Method 1: HTML Attribute (not recommended)
<button onclick="handleClick()">Click me</button>;

// Method 2: DOM property
button.onclick = function () {
  console.log("Button clicked");
};

// Method 3: addEventListener (recommended)
button.addEventListener("click", function (event) {
  console.log("Button clicked", event);
});

// Using arrow function
button.addEventListener("click", (event) => {
  console.log("Button clicked", event);
});

// Removing event listener
function handleClick(event) {
  console.log("Button clicked");
}
button.addEventListener("click", handleClick);
button.removeEventListener("click", handleClick);
```

### Common Event Types

```javascript
// Mouse events
element.addEventListener("click", handler); // Mouse click
element.addEventListener("dblclick", handler); // Double-click
element.addEventListener("mousedown", handler); // Mouse button pressed
element.addEventListener("mouseup", handler); // Mouse button released
element.addEventListener("mousemove", handler); // Mouse moved
element.addEventListener("mouseover", handler); // Mouse moved onto element
element.addEventListener("mouseout", handler); // Mouse moved out of element

// Keyboard events
element.addEventListener("keydown", handler); // Key pressed
element.addEventListener("keyup", handler); // Key released
element.addEventListener("keypress", handler); // Key pressed (character keys only)

// Form events
form.addEventListener("submit", handler); // Form submitted
input.addEventListener("change", handler); // Value changed and lost focus
input.addEventListener("input", handler); // Value changed (realtime)
input.addEventListener("focus", handler); // Element focused
input.addEventListener("blur", handler); // Element lost focus

// Document/Window events
window.addEventListener("load", handler); // Page and resources loaded
document.addEventListener("DOMContentLoaded", handler); // DOM ready
window.addEventListener("resize", handler); // Window resized
window.addEventListener("scroll", handler); // Page scrolled
```

### Event Object

```javascript
element.addEventListener("click", function (event) {
  // General info
  console.log(event.type); // Event type (e.g., "click")
  console.log(event.target); // Element that triggered event
  console.log(event.currentTarget); // Element handling the event
  console.log(event.timeStamp); // Time event occurred

  // Mouse event
  console.log(event.clientX, event.clientY); // Mouse pos (viewport)
  console.log(event.pageX, event.pageY); // Mouse pos (document)
  console.log(event.button); // Mouse button (0: left, 1: middle, 2: right)

  // Keyboard event
  console.log(event.key); // Key pressed
  console.log(event.keyCode); // ASCII code (deprecated)
  console.log(event.code); // Physical key code (e.g., "KeyA")
  console.log(event.ctrlKey); // Ctrl key pressed?
  console.log(event.shiftKey); // Shift key pressed?
  console.log(event.altKey); // Alt key pressed?

  // Stop default behavior
  event.preventDefault();

  // Stop event propagation (bubbling)
  event.stopPropagation();
});
```

### Event Propagation

```javascript
// Bubbling (default): event propagates from target up to ancestors
// Capturing: event propagates from ancestors down to target

// useCapture parameter (3rd boolean argument)
parent.addEventListener("click", parentHandler, true); // Capturing phase
child.addEventListener("click", childHandler, false); // Bubbling phase (default)

function handleEvent(event) {
  console.log(`${event.currentTarget.tagName} was clicked`);
  console.log(`Event phase: ${event.eventPhase}`);
  // 1: Capturing, 2: Target, 3: Bubbling
}
```

### Event Delegation

```javascript
// Using event propagation to handle multiple child elements with one handler
document
  .getElementById("parent-list")
  .addEventListener("click", function (event) {
    if (event.target.tagName === "LI") {
      console.log("List item clicked:", event.target.textContent);
    }
  });
```

## 🧑‍🏫 Lesson 8: Asynchronous JavaScript

### Introduction to Asynchronous JavaScript

- Asynchronous JavaScript is a crucial part of JavaScript programming, allowing asynchronous tasks to run without blocking the main application thread. This is very useful when working with APIs, loading data from servers, or performing time-consuming tasks.
- There are several ways to handle asynchrony in JavaScript, including:
  - Callbacks
  - Promises
  - Async/Await
- These methods help manage asynchronous tasks more easily and avoid "callback hell".
- When working asynchronously, you need to pay attention to issues like:
  - Error handling
  - Execution order
  - State management
  - Performance optimization

### Callback

```javascript
// Callback function
function fetchData(callback) {
  setTimeout(() => {
    const data = { name: "John", age: 30 };
    callback(null, data); // null is error (no error)
  }, 1000);
}

fetchData((error, data) => {
  if (error) {
    console.error("Error:", error);
  } else {
    console.log("Data:", data);
  }
});

// Callback Hell
fetchUserData((error, user) => {
  if (error) {
    console.error(error);
  } else {
    fetchUserPosts(user.id, (error, posts) => {
      if (error) {
        console.error(error);
      } else {
        fetchPostComments(posts[0].id, (error, comments) => {
          if (error) {
            console.error(error);
          } else {
            console.log(comments);
          }
        });
      }
    });
  }
});
```

### Promises

```javascript
// Create Promise
function fetchData() {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const success = true;
      if (success) {
        resolve({ name: "John", age: 30 });
      } else {
        reject(new Error("Failed to fetch data"));
      }
    }, 1000);
  });
}

// Use Promise
fetchData()
  .then((data) => {
    console.log("Data:", data);
    return processData(data); // Return another promise to chain
  })
  .then((processedData) => {
    console.log("Processed:", processedData);
  })
  .catch((error) => {
    console.error("Error:", error);
  })
  .finally(() => {
    console.log("Operation completed");
  });

// Promise.all - wait for all promises to complete
Promise.all([fetchUsers(), fetchPosts(), fetchComments()])
  .then(([users, posts, comments]) => {
    console.log(users, posts, comments);
  })
  .catch((error) => {
    console.error(error);
  });

// Promise.race - wait for the first promise to complete
Promise.race([fetchData1(), fetchData2()])
  .then((result) => {
    console.log("First result:", result);
  })
  .catch((error) => {
    console.error("First error:", error);
  });

// Promise.allSettled - wait for all promises to settle (ES2020)
Promise.allSettled([fetchData1(), fetchData2()]).then((results) => {
  results.forEach((result) => {
    if (result.status === "fulfilled") {
      console.log("Success:", result.value);
    } else {
      console.log("Error:", result.reason);
    }
  });
});
```

### Async/Await (ES8)

```javascript
// Async function always returns a promise
async function fetchUserData() {
  try {
    // Await pauses execution until promise is resolved
    const user = await fetchUser();
    const posts = await fetchPosts(user.id);
    const comments = await fetchComments(posts[0].id);

    return { user, posts, comments };
  } catch (error) {
    console.error("Error:", error);
    throw error; // Rethrow to handle outside if needed
  } finally {
    console.log("Operation completed");
  }
}

// Call async function
fetchUserData()
  .then((data) => console.log("All data:", data))
  .catch((error) => console.error("Error in main:", error));

// Run multiple promises in parallel
async function fetchAllData() {
  try {
    // Run promises concurrently
    const [users, products, orders] = await Promise.all([
      fetchUsers(),
      fetchProducts(),
      fetchOrders(),
    ]);

    return { users, products, orders };
  } catch (error) {
    console.error("Error:", error);
  }
}
```

### Fetch API

```javascript
// Fetch API - modern interface for API calls
fetch("https://api.example.com/data")
  .then((response) => {
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return response.json(); // Parse response body to JSON
  })
  .then((data) => {
    console.log("Data:", data);
  })
  .catch((error) => {
    console.error("Error:", error);
  });

// POST request with Fetch
fetch("https://api.example.com/users", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    name: "John",
    email: "john@example.com",
  }),
})
  .then((response) => response.json())
  .then((data) => console.log("Success:", data))
  .catch((error) => console.error("Error:", error));

// Async/await with fetch
async function fetchUsers() {
  try {
    const response = await fetch("https://api.example.com/users");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const users = await response.json();
    return users;
  } catch (error) {
    console.error("Error fetching users:", error);
    throw error;
  }
}
```

## 🧑‍🏫 Lesson 9: Local Storage and Session Storage

### Web Storage API

```javascript
// LocalStorage - data is stored with no expiration time
// Save data
localStorage.setItem("username", "john_doe");
localStorage.setItem(
  "preferences",
  JSON.stringify({ theme: "dark", fontSize: 14 })
);

// Read data
const username = localStorage.getItem("username");
const preferences = JSON.parse(localStorage.getItem("preferences"));

// Remove an item
localStorage.removeItem("username");

// Clear all
localStorage.clear();

// SessionStorage - data is stored only for the current session
sessionStorage.setItem("temp_data", "some value");
const tempData = sessionStorage.getItem("temp_data");
sessionStorage.removeItem("temp_data");
sessionStorage.clear();

// Listen for storage changes (on other tabs/windows)
window.addEventListener("storage", (event) => {
  console.log("Storage changed:", event.key, event.newValue, event.oldValue);
});
```

### Use Cases

```javascript
// Save app state
function saveAppState() {
  const state = {
    darkMode: true,
    sidebar: "collapsed",
    lastVisitedPage: "/products",
  };
  localStorage.setItem("appState", JSON.stringify(state));
}

// Save shopping cart
function addToCart(product) {
  // Get current cart or create new
  let cart = JSON.parse(localStorage.getItem("cart")) || [];

  // Add product to cart
  cart.push(product);

  // Save cart
  localStorage.setItem("cart", JSON.stringify(cart));
}

// Track login
function login(user) {
  sessionStorage.setItem("currentUser", JSON.stringify(user));
  localStorage.setItem("lastLogin", new Date().toISOString());
}

function checkLogin() {
  const user = sessionStorage.getItem("currentUser");
  return user ? JSON.parse(user) : null;
}

function logout() {
  sessionStorage.removeItem("currentUser");
}
```

## 🧪 FINAL PROJECT: Building a Task Management App (Todo List)

### Project Description

Build a complete Todo List application with the following features:

1. Add new task
2. Edit task
3. Mark task as completed
4. Delete task
5. Filter tasks (all, completed, active)
6. Data persistence using Local Storage
7. User-friendly interface (using HTML/CSS learned)

### Requirements

- Use pure JavaScript, no libraries.
- Apply DOM, Events, Local Storage knowledge.
- Implement validation for task input.
- Use ES6+ features (arrow functions, destructuring, etc.).
- Implement using MVC pattern or module pattern.

### Advanced Features (Optional)

- Add task categorization.
- Add drag-and-drop for reordering.
- Show statistics (count of completed/active tasks).
- Add deadlines and notifications.

### Application Mockup

```text
+-----------------------------------------------+
|                  TODO LIST                    |
+-----------------------------------------------+
| Add new task: [______________________] [Add]  |
+-----------------------------------------------+
| Filters: [All] [Active] [Completed]           |
+-----------------------------------------------+
| [ ] Task 1                             [X]    |
| [x] Task 2 (completed)                 [X]    |
| [ ] Task 3                             [X]    |
+-----------------------------------------------+
| 2 tasks left | Clear completed                |
+-----------------------------------------------+
```
