---
prev:
  text: '📝 Introduction to HTML'
  link: '/WEB/Part1'
next:
  text: '🔄 JavaScript'
  link: '/WEB/Part3'
---

# 📘 PART 2: CSS - WEB STYLING

## 🎯 General Objectives

- Understand CSS and its role in web development.
- Master different ways to apply CSS to HTML.
- Master basic CSS properties and their usage.

## 🧑‍🏫 Lesson 1: Introduction to CSS

### What is CSS?

- CSS stands for Cascading Style Sheets.
- Used to format and present HTML content.
- Helps separate content (HTML) and presentation (CSS).
- Allows applying multiple different styles to the same webpage.

### How to Add CSS to HTML

1. **Inline CSS**: Using the `style` attribute directly on HTML tags (not recommended).

   ```html
   <p style="color: blue; font-size: 16px;">This is a blue paragraph.</p>
   ```

2. **Internal CSS**: Using the `<style>` tag inside the `<head>` section (not recommended for large sites).

   ```html
   <head>
     <style>
       p {
         color: blue;
         font-size: 16px;
       }
     </style>
   </head>
   ```

3. **External CSS**: Creating a separate CSS file and linking it to HTML.

   ```html
   <head>
     <link rel="stylesheet" href="styles.css" />
   </head>
   ```

Content of styles.css file:

```css
p {
  color: blue;
  font-size: 16px;
}
```

### Pros and Cons of Each Type

| CSS Type | Pros | Cons |
| -------- | --------------------------------------------------- | -------------------------------------------- |
| Inline | Highest priority, overrides other css properties | Hard to maintain, repetitive code |
| Internal | Applies to one page, no separate file needed | Must copy when using on other pages |
| External | Easy to maintain, reusable across multiple pages | Page might display before CSS loads |

## 🧑‍🏫 Lesson 2: CSS Selectors

### CSS Syntax

```css
selector {
  property: value;
  property: value;
}
```

### Basic Selector Types

```css
/* Element Selector */
p {
  color: blue;
}

/* Class Selector */
.important {
  font-weight: bold;
}

/* ID Selector */
#header {
  background-color: #f0f0f0;
}

/* Universal Selector */
* {
  margin: 0;
  padding: 0;
}

/* Attribute Selector */
input[type="text"] {
  border: 1px solid gray;
}

/* Pseudo-class Selector */
a:hover {
  color: red;
}

/* Pseudo-element Selector */
p::first-letter {
  font-size: 2em;
}
```

### Combined Selectors

```css
/* Descendant Selector */
article p {
  font-style: italic;
}

/* Child Selector (direct child) */
ul > li {
  list-style-type: square;
}

/* Adjacent Sibling Selector */
h2 + p {
  font-weight: bold;
}

/* General Sibling Selector */
h2 ~ p {
  color: gray;
}

/* Multiple Selectors */
h1,
h2,
h3 {
  text-transform: uppercase;
}
```

### Specificity in CSS

1. `!important` (highest)
2. Inline CSS
3. ID selector
4. Class selector, Attribute selector, Pseudo-class
5. Element selector, Pseudo-element
6. Universal selector (`*`)

```css
/* Specificity Example */
p {
  color: blue;
} /* Specificity: 0,0,0,1 */
.intro {
  color: red;
} /* Specificity: 0,0,1,0 */
#first {
  color: green;
} /* Specificity: 0,1,0,0 */
p.intro {
  color: purple;
} /* Specificity: 0,0,1,1 */

/* !important overrides all other rules */
p {
  color: yellow !important;
} /* Highest */
```

### Box Model

- This is the box model in CSS describing the space occupied by an HTML element.

```css
div {
  width: 300px; /* Content width */
  height: 200px; /* Content height */

  padding: 20px; /* Distance from content to border */
  border: 5px solid black; /* Border */
  margin: 30px; /* Distance from border to other elements */
}
```

### Box Model Details

- **Content**: The area displaying the actual content (`width`, `height`).
- **Padding**: The space between content and border (`padding`).
- **Border**: The border surrounding padding and content (`border`).
- **Margin**: The space between the border and adjacent elements (`margin`).

### Box-sizing

```css
/* Standard box model */
box-sizing: content-box; /* Default */

/* Alternative box model */
box-sizing: border-box; /* width/height includes padding and border */

/* Apply border-box to all elements */
* {
  box-sizing: border-box;
}
```

### Margin, Padding, and Border

```css
/* Longhand */
margin-top: 10px;
margin-right: 20px;
margin-bottom: 10px;
margin-left: 20px;

/* Shorthand clockwise (top, right, bottom, left) */
margin: 10px 20px 10px 20px;

/* Shorthand symmetric */
margin: 10px 20px; /* top/bottom 10px, left/right 20px */
margin: 10px; /* all 4 sides 10px */

/* Similar for padding */
padding: 10px 20px 15px 25px;

/* Border */
border-width: 2px;
border-style: solid;
border-color: black;

/* Shorthand */
border: 2px solid black;

/* Border per side */
border-top: 2px solid red;
border-right: 2px dashed blue;
border-bottom: 2px dotted green;
border-left: 2px double orange;
```

## 🧑‍🏫 Lesson 4: Typography and Colors

### Typography

```css
p {
  /* Font family */
  font-family: Arial, Helvetica, sans-serif;

  /* Font size */
  font-size: 16px; /* px - pixel */
  font-size: 1.2em; /* em - relative to parent element */
  font-size: 1.2rem; /* rem - relative to root element (html) */

  /* Font style */
  font-style: normal; /* normal, italic, oblique */

  /* Font weight */
  font-weight: bold; /* normal, bold, 100-900 */

  /* Line height */
  line-height: 1.5;

  /* Text align */
  text-align: center; /* left, right, center, justify */

  /* Text decoration */
  text-decoration: underline; /* none, underline, line-through, overline */

  /* Text transform */
  text-transform: uppercase; /* none, capitalize, uppercase, lowercase */

  /* Letter spacing */
  letter-spacing: 2px;

  /* Word spacing */
  word-spacing: 5px;
}
```

### Using Google Fonts (or online fonts)

```html
<head>
  <link
    href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"
    rel="stylesheet"
  />
</head>
```

```css
body {
  font-family: "Roboto", sans-serif;
}
```

### Using Local Fonts

```css
@font-face {
  font-family: "MyFont";
  src: url("fonts/MyFont.woff2") format("woff2"), url("fonts/MyFont.ttf") format("truetype");
  font-weight: normal;
  font-style: normal;
}
```

```css
body {
  font-family: "MyFont", sans-serif;
}
```

### Colors

```css
/* Color names */
color: red;
background-color: yellow;

/* Hex codes */
color: #ff0000; /* Red */
color: #00ff00; /* Green */
color: #0000ff; /* Blue */

/* RGB and RGBA */
color: rgb(255, 0, 0); /* Red */
color: rgba(255, 0, 0, 0.5); /* Red with 50% opacity */

/* HSL and HSLA (Hue, Saturation, Lightness) */
color: hsl(0, 100%, 50%); /* Red */
color: hsla(0, 100%, 50%, 0.5); /* Red with 50% opacity */
```

## 🧑‍🏫 Lesson 5: Layout and Positioning

### Display Property

```css
/* Common display values */
display: block; /* Block element takes up full width */
display: inline; /* Inline element takes only necessary space */
display: inline-block; /* Combines inline and block properties */
display: none; /* Hides element from page */
display: flex; /* Flexible Box Layout */
display: grid; /* Grid Layout */
```

### Position Property

```css
/* Static (default) */
position: static;

/* Relative - relative to original position */
position: relative;
top: 10px;
left: 20px;

/* Absolute - relative to nearest non-static ancestor */
position: absolute;
top: 0;
right: 0;

/* Fixed - relative to viewport */
position: fixed;
bottom: 20px;
right: 20px;

/* Sticky - combines relative and fixed */
position: sticky;
top: 0;
```

### Float and Clear

```css
/* Float */
float: left; /* Element floats left */
float: right; /* Element floats right */
float: none; /* No float (default) */

/* Clear - prevent elements from floating around */
clear: left; /* No floating elements on left */
clear: right; /* No floating elements on right */
clear: both; /* No floating elements on either side */
```

### Z-index - Stacking Order

```css
/* Element with higher z-index appears on top */
.background {
  position: relative;
  z-index: 1;
}

.foreground {
  position: relative;
  z-index: 2; /* Displays above .background */
}
```

## 🧑‍🏫 Lesson 6: Flexbox Layout

### Flexbox

- This is a one-dimensional layout model helping to distribute elements in a container flexibly.

```css
.container {
  display: flex; /* Activate flexbox */

  /* Main axis direction */
  flex-direction: row; /* row (default), row-reverse, column, column-reverse */

  /* Wrapping */
  flex-wrap: wrap; /* nowrap (default), wrap, wrap-reverse */

  /* Combine direction and wrap */
  flex-flow: row wrap;

  /* Align items along main axis */
  justify-content: center; /* flex-start, flex-end, center, space-between, space-around, space-evenly */

  /* Align items along cross axis */
  align-items: center; /* stretch, flex-start, flex-end, center, baseline */

  /* Align lines/columns in container */
  align-content: space-between; /* stretch, flex-start, flex-end, center, space-between, space-around */
}

.item {
  /* Display order */
  order: 2;

  /* Ability to grow */
  flex-grow: 1;

  /* Ability to shrink */
  flex-shrink: 1;

  /* Initial size */
  flex-basis: 200px;

  /* Combine grow, shrink, and basis */
  flex: 1 1 200px;

  /* Override align-items for individual item */
  align-self: flex-end;
}
```

### Flexbox Examples

```css
/* Navigation bar */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #333;
  padding: 10px 20px;
}

.logo {
  flex: 1;
}

.nav-links {
  display: flex;
  list-style: none;
}

.nav-links li {
  margin-left: 20px;
}

/* Card layout */
.card-container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.card {
  flex: 0 1 calc(33.333% - 20px);
  padding: 20px;
  border: 1px solid #ddd;
}
```

## 🧑‍🏫 Lesson 7: Grid Layout

### Grid Layout

- This is a two-dimensional layout system, helping arrange elements in both rows and columns.

```css
.container {
  display: grid;

  /* Define columns */
  grid-template-columns: 1fr 2fr 1fr;
  grid-template-columns: repeat(3, 1fr);

  /* Define rows */
  grid-template-rows: 100px auto 100px;

  /* Define gap between elements */
  gap: 20px;
  column-gap: 10px;
  row-gap: 15px;

  /* Name areas and define grid structure */
  grid-template-areas:
    "header header header"
    "sidebar content content"
    "footer footer footer";
}

.item {
  /* Item position by column (start / end) */
  grid-column: 1 / 3;
  grid-column: 1 / span 2;

  /* Item position by row (start / end) */
  grid-row: 2 / 4;
  grid-row: 2 / span 2;

  /* Combine row and column */
  grid-area: 2 / 1 / 4 / 3;

  /* Use defined grid-area name */
  grid-area: header;
}

/* Align items inside grid cell */
.item {
  justify-self: center; /* start, end, center, stretch */
  align-self: center; /* start, end, center, stretch */
}

.container {
  /* Align all items in grid */
  justify-items: center;
  align-items: center;

  /* Align entire grid within container */
  justify-content: space-between;
  align-content: space-around;
}
```

### Grid Examples

```css
/* Webpage layout */
.page-container {
  display: grid;
  grid-template-areas:
    "header header header"
    "nav content sidebar"
    "footer footer footer";
  grid-template-columns: 1fr 4fr 1fr;
  grid-template-rows: auto 1fr auto;
  min-height: 100vh;
  gap: 10px;
}

.header {
  grid-area: header;
}
.nav {
  grid-area: nav;
}
.content {
  grid-area: content;
}
.sidebar {
  grid-area: sidebar;
}
.footer {
  grid-area: footer;
}

/* Grid gallery */
.gallery {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 10px;
}
```

## 🧑‍🏫 Lesson 8: Responsive Web Design

### Responsive Web Design

- Helps web pages display appropriately on multiple devices with different screen sizes.

### Media Queries

```css
/* Breakpoint: small devices (phones) */
@media (max-width: 576px) {
  .container {
    width: 100%;
  }
}

/* Breakpoint: medium devices (tablets) */
@media (min-width: 577px) and (max-width: 992px) {
  .container {
    width: 90%;
  }
}

/* Breakpoint: large devices (desktops) */
@media (min-width: 993px) {
  .container {
    width: 80%;
    max-width: 1200px;
  }
}

/* Media query by orientation */
@media (orientation: landscape) {
  /* CSS for landscape */
}

@media (orientation: portrait) {
  /* CSS for portrait */
}

/* Combined media query */
@media (min-width: 768px) and (orientation: landscape) {
  /* CSS for landscape wide screens */
}
```

### Viewport Meta Tag

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
```

### Responsive Units

```css
/* Relative units */
.container {
  width: 80%; /* % based on parent element */
  font-size: 1.2em; /* em based on parent font-size */
  font-size: 1.2rem; /* rem based on root html font-size */

  width: 100vw; /* vw - 1% of viewport width */
  height: 100vh; /* vh - 1% of viewport height */

  min-height: 50vh; /* minimum 50% of viewport height */
  max-width: 1200px; /* max 1200px */
}
```

### Mobile-first Approach

- Design for mobile devices first, then expand for larger devices.

```css
/* Default styles for mobile */
.container {
  width: 100%;
}

/* Then expand for larger screens */
@media (min-width: 768px) {
  .container {
    width: 750px;
  }
}

@media (min-width: 992px) {
  .container {
    width: 970px;
  }
}

@media (min-width: 1200px) {
  .container {
    width: 1170px;
  }
}
```

### Responsive Images

```css
img {
  max-width: 100%;
  height: auto;
}
```

```html
<picture>
  <source media="(max-width: 576px)" srcset="small.jpg" />
  <source media="(max-width: 992px)" srcset="medium.jpg" />
  <img src="large.jpg" alt="Responsive image" />
</picture>
```

## 🧑‍🏫 Lesson 9: CSS Transitions and Animations

### Transitions

```css
.button {
  background-color: blue;
  color: white;

  /* Property, duration, timing function, delay */
  transition: background-color 0.3s ease 0.1s;

  /* Multiple properties */
  transition: background-color 0.3s ease, transform 0.2s ease-in;

  /* All properties */
  transition: all 0.3s ease;
}

.button:hover {
  background-color: darkblue;
  transform: scale(1.1);
}
```

### Animations

```css
/* Define animation with @keyframes */
@keyframes slideIn {
  from {
    transform: translateX(-100%);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
}

@keyframes pulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.1);
  }
  100% {
    transform: scale(1);
  }
}

/* Apply animation */
.element {
  /* name, duration, timing function, delay, iteration count, direction, fill-mode */
  animation: slideIn 1s ease-out 0.5s forwards;

  /* Multiple animations */
  animation: slideIn 1s ease-out, pulse 2s infinite;
}
```

### Animation Properties

```css
.element {
  animation-name: slideIn;
  animation-duration: 1s;
  animation-timing-function: ease-out;
  animation-delay: 0.5s;
  animation-iteration-count: 3; /* integer or infinite */
  animation-direction: alternate; /* normal, reverse, alternate, alternate-reverse */
  animation-fill-mode: forwards; /* none, forwards, backwards, both */
  animation-play-state: running; /* running, paused */
}
```

### Transform

```css
.element {
  /* Rotate */
  transform: rotate(45deg);
  transform: rotateX(45deg);
  transform: rotateY(45deg);

  /* Scale */
  transform: scale(1.5);
  transform: scaleX(1.5);
  transform: scaleY(0.5);

  /* Translate */
  transform: translate(50px, 20px);
  transform: translateX(50px);
  transform: translateY(20px);

  /* Skew */
  transform: skew(20deg, 10deg);
  transform: skewX(20deg);
  transform: skewY(10deg);

  /* Combined */
  transform: rotate(45deg) scale(1.5) translateX(50px);
}
```

## 🧪 FINAL PROJECT: Building a Portfolio Website Interface Using CSS

### Project Description

Continuing from the HTML project in Part 1, you will design and style your Personal Profile page with CSS to create a professional portfolio. You can refer to my [Portfolio](https://klpod221.com) for ideas.

### Requirements

1. Use external CSS.
2. Create a responsive layout:
   - Display well on phones (< 576px).
   - Display well on tablets (< 992px).
   - Display well on desktops (≥ 992px).
3. Apply Flexbox or Grid for main layout.
4. Create a responsive navigation menu.
5. Design sections:
   - Skills: display proficiency as progress bars.
   - Projects: display as grid cards with hover effects.
   - Contact form: styling and visible validation.
6. Use at least 2 animations/transitions for elements.

### Design Hints

```css
/* Reset CSS */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* Main Layout */
body {
  font-family: "Roboto", sans-serif;
  line-height: 1.6;
  color: #333;
}

.container {
  width: 90%;
  max-width: 1200px;
  margin: 0 auto;
}

/* Header */
header {
  background-color: #2c3e50;
  color: white;
  text-align: center;
  padding: 60px 0;
}

/* Responsive menu */
nav {
  background-color: #34495e;
}

/* Animation Example */
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.project-card {
  animation: fadeIn 1s ease-in;
}

/* Media queries */
@media (max-width: 576px) {
  /* Mobile styles */
}

@media (min-width: 577px) and (max-width: 991px) {
  /* Tablet styles */
}

@media (min-width: 992px) {
  /* Desktop styles */
}
```

### Expected Result

A complete portfolio website with an attractive interface, responsive layout, interactive effects, and appropriate animations to engage viewers.
