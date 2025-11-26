---
prev:
  text: '⚡ Applied Algorithms'
  link: '/DSA/Part5'
next:
  text: '🎨 CSS - Web Styling'
  link: '/WEB/Part2'
---

# 📘 PART 1: INTRODUCTION TO HTML

## 🎯 General Objectives

- Understand the structure of an HTML webpage.
- Know how to use basic HTML tags.
- Create your first static webpage.

## 🧑‍🏫 Lesson 1: Introduction to HTML

### What is HTML?

- HTML stands for HyperText Markup Language.
- It is the standard markup language for creating web pages.
- HTML describes the structure of a web page using tags.
- Browsers do not display the HTML tags but use them to render the content of the page.

### Basic Structure of an HTML Page

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Page Title</title>
  </head>
  <body>
    <h1>This is a heading</h1>
    <p>This is a paragraph.</p>
  </body>
</html>
```

Try creating an `index.html` file with the content above and open it in a browser or use the [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) extension in Visual Studio Code to see the result.

### Explanation

- `<!DOCTYPE html>`: Declares the document type as HTML5.
- `<html>`: The root element of an HTML page.
- `<head>`: Contains meta-information, CSS, JavaScript.
- `<title>`: Specifies the title of the webpage (shown in the browser tab).
- `<body>`: Contains the visible content of the webpage.
- `<h1>`: Heading level 1.
- `<p>`: A paragraph.

## 🧑‍🏫 Lesson 2: Basic HTML Tags

### Heading Tags

```html
<h1>Heading Level 1</h1>
<h2>Heading Level 2</h2>
<h3>Heading Level 3</h3>
<h4>Heading Level 4</h4>
<h5>Heading Level 5</h5>
<h6>Heading Level 6</h6>
```

### Text Formatting Tags

```html
<p>This is a paragraph.</p>
<b>Bold text</b>
<i>Italic text</i>
<u>Underlined text</u>
<strong>Strong text (usually rendered as bold)</strong>
<em>Emphasized text (usually rendered as italic)</em>
<mark>Marked/Highlighted text</mark>
<small>Smaller text</small>
<del>Deleted/Strikethrough text</del>
<sub>Subscript text</sub>
<sup>Superscript text</sup>
```

### List Tags

```html
<!-- Ordered List -->
<ol>
  <li>First item</li>
  <li>Second item</li>
  <li>Third item</li>
</ol>

<!-- Unordered List -->
<ul>
  <li>First item</li>
  <li>Second item</li>
  <li>Third item</li>
</ul>

<!-- Description List -->
<dl>
  <dt>HTML</dt>
  <dd>HyperText Markup Language</dd>
  <dt>CSS</dt>
  <dd>Cascading Style Sheets</dd>
</dl>
```

### Link and Image Tags

```html
<!-- Link -->
<a href="https://www.google.com">Go to Google</a>
<a href="page2.html">Go to page 2</a>
<a href="#section1">Go to section 1 on this page</a>

<!-- Image -->
<img src="image.jpg" alt="Image description" width="300" height="200" />
```

## 🧑‍🏫 Lesson 3: Tables and Forms in HTML

### Tables

```html
<table border="1">
  <thead>
    <tr>
      <th>No.</th>
      <th>Name</th>
      <th>Age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>John Doe</td>
      <td>20</td>
    </tr>
    <tr>
      <td>2</td>
      <td>Jane Smith</td>
      <td>22</td>
    </tr>
  </tbody>
</table>
```

### Forms

```html
<form action="/submit-form" method="post">
  <div>
    <label for="name">Full Name:</label>
    <input type="text" id="name" name="name" required />
  </div>

  <div>
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required />
  </div>

  <div>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required />
  </div>

  <div>
    <label>Gender:</label>
    <input type="radio" id="male" name="gender" value="male" />
    <label for="male">Male</label>
    <input type="radio" id="female" name="gender" value="female" />
    <label for="female">Female</label>
  </div>

  <div>
    <label>Hobbies:</label>
    <input type="checkbox" id="reading" name="hobby" value="reading" />
    <label for="reading">Reading</label>
    <input type="checkbox" id="sports" name="hobby" value="sports" />
    <label for="sports">Sports</label>
  </div>

  <div>
    <label for="country">Country:</label>
    <select id="country" name="country">
      <option value="">Select country</option>
      <option value="vn">Vietnam</option>
      <option value="us">USA</option>
      <option value="uk">UK</option>
    </select>
  </div>

  <div>
    <label for="message">Message:</label>
    <textarea id="message" name="message" rows="4" cols="30"></textarea>
  </div>

  <div>
    <button type="submit">Submit</button>
    <button type="reset">Reset</button>
  </div>
</form>
```

## 🧑‍🏫 Lesson 4: HTML5 Semantic Elements

### Definition

HTML5 introduced semantic tags to help organize and describe the structure of a webpage more clearly:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Webpage with HTML5 Semantic</title>
  </head>
  <body>
    <header>
      <h1>Website Name</h1>
      <nav>
        <ul>
          <li><a href="#home">Home</a></li>
          <li><a href="#about">About</a></li>
          <li><a href="#services">Services</a></li>
          <li><a href="#contact">Contact</a></li>
        </ul>
      </nav>
    </header>

    <main>
      <section id="home">
        <h2>Home</h2>
        <p>Home content...</p>
      </section>

      <section id="about">
        <h2>About</h2>
        <p>About content...</p>
      </section>

      <section id="services">
        <h2>Services</h2>
        <article>
          <h3>Service 1</h3>
          <p>Description of service 1...</p>
        </article>
        <article>
          <h3>Service 2</h3>
          <p>Description of service 2...</p>
        </article>
      </section>

      <section id="contact">
        <h2>Contact</h2>
        <form>
          <!-- Form elements -->
        </form>
      </section>

      <aside>
        <h3>Side Content</h3>
        <p>Additional info...</p>
      </aside>
    </main>

    <footer>
      <p>&copy; 2023 Website Name. All rights reserved.</p>
    </footer>
  </body>
</html>
```

### Semantic Tags in HTML5

- `<header>`: Defines the header section of a webpage or a section.
- `<nav>`: Defines a set of navigation links.
- `<main>`: Specifies the main content of the document.
- `<section>`: Defines a section in a document.
- `<article>`: Specifies independent, self-contained content.
- `<aside>`: Defines content aside from the page content (like a sidebar).
- `<footer>`: Defines a footer for a document or section.
- `<figure>`: Specifies self-contained content, like illustrations, diagrams, photos, code listings, etc.
- `<figcaption>`: Defines a caption for a `<figure>` element.
- `<time>`: Defines a specific time (or datetime).

## 🧑‍🏫 Lesson 5: Using Developer Tools in the Browser

### Introduction to Developer Tools

Developer Tools (DevTools) is a set of web developer tools built directly into modern browsers like Chrome, Firefox, Edge, and Safari. They allow developers to inspect, debug, and optimize the source code of a webpage.

### How to Open Developer Tools

- Chrome: Press `F12` or `Ctrl + Shift + I` (Windows/Linux) or `Cmd + Option + I` (Mac).
- Firefox: Press `F12` or `Ctrl + Shift + I` (Windows/Linux) or `Cmd + Option + I` (Mac).
- Edge: Press `F12` or `Ctrl + Shift + I` (Windows/Linux) or `Cmd + Option + I` (Mac).
- Safari: Press `Cmd + Option + I` (Mac).

### Main Components of Developer Tools

- **Elements**: Inspect and edit HTML and CSS.
- **Console**: View messages, errors, and execute JavaScript.
- **Network**: Inspect network requests and load performance.
- **Sources**: View and debug JavaScript source code.
- **Performance**: Analyze performance and optimize the site.
- **Memory**: Inspect and manage memory usage.
- **Application**: Manage application data like cookies, local storage, session storage.
- **Security**: Inspect security issues.

### Inspecting and Editing HTML

- Use the **Elements** tab to view the HTML structure.
- Right-click an element and select "Edit as HTML" to edit directly.
- Changes are applied immediately in the browser viewport.

### Benefits of Developer Tools

- Quickly inspect and debug code.
- Optimize website performance.
- Test and edit HTML, CSS, JavaScript in real-time.
- Analyze and manage network requests.
- Check for security issues.

## 🧑‍🏫 Lesson 6: Emmet - Tool for Writing HTML Faster

### Introduction to Emmet

Emmet is a plugin that helps developers write HTML and CSS code faster by using abbreviations, similar to CSS selectors (you will learn about selectors in the CSS section). Emmet helps save time and effort when coding.

You can visit the Emmet homepage to see visual examples: [Emmet](https://emmet.io/).

### Basic Emmet Syntax

```text
element
element>child
element+sibling
element*n
element.classname
element#id
element[attribute=value]
element{text content}
```

### Emmet Examples

| Emmet Abbreviation | HTML Result |
| ---------------- | -------------------------------------------------------------------------------- |
| `div` | `<div></div>` |
| `div>ul>li` | `<div><ul><li></li></ul></div>` |
| `div+p+bq` | `<div></div><p></p><blockquote></blockquote>` |
| `ul>li*5` | `<ul><li></li><li></li><li></li><li></li><li></li></ul>` |
| `div.container` | `<div class="container"></div>` |
| `div#header` | `<div id="header"></div>` |
| `a[href=#]` | `<a href="#"></a>` |
| `p{Hello World}` | `<p>Hello World</p>` |
| `ul>li.item$*3` | `<ul><li class="item1"></li><li class="item2"></li><li class="item3"></li></ul>` |

### Emmet for Forms

```text
form:get
input:text
input:email
input:password
input:submit
```

Result:

```html
<!-- form:get -->
<form action="" method="get"></form>

<!-- input:text -->
<input type="text" name="" id="" />

<!-- input:email -->
<input type="email" name="" id="" />

<!-- input:password -->
<input type="password" name="" id="" />

<!-- input:submit -->
<input type="submit" value="" />
```

### Benefits of Emmet

- Saves time when writing HTML and CSS.
- Reduces necessary keystrokes.
- Reduces syntax errors.
- Built-in to many popular IDEs and text editors like VS Code, Sublime Text, Atom, WebStorm...

### Editors supporting Emmet

- Visual Studio Code
- Sublime Text
- Atom
- WebStorm
- Notepad++
- And many other IDEs...

## 🧪 FINAL PROJECT: Building a Portfolio Page

### Project Description

Create a personal introduction website with the following sections:

- Header: Name and profile picture.
- Introduction: Personal information, education.
- Skills: List of skills with proficiency levels.
- Projects: Introduction to projects you have worked on.
- Contact: Form for others to send messages.
- Footer: Copyright information, social media links.

### Requirements

- Use HTML5 semantic elements.
- Create a table to display education information.
- Create a contact form with necessary fields.
- Add images and links.

### Website Mockup Reference

```text
+---------------------------------------------------------+
|                      MY PORTFOLIO                       |
+---------------------------------------------------------+
| [Profile Photo]    John Doe                             |
|                    Web Developer                        |
+---------------------------------------------------------+
|                   ABOUT ME                              |
+---------------------------------------------------------+
| Hello! I'm John, a passionate web developer with        |
| 1 years of experience creating modern web applications. |
|                                                         |
| [Education]                                             |
| +---------------------------------------------------+   |
| | Degree               | Institution      | Year    |   |
| |----------------------|-----------------|----------|   |
| | B.S. Computer Science| ABC University  | 2018     |   |
| | Web Dev Certification| XYZ Institute   | 2019     |   |
| +---------------------------------------------------+   |
+---------------------------------------------------------+
|                   SKILLS                                |
+---------------------------------------------------------+
| Java        [███████████████████████░░] 95%             |
| SQL         [██████████████████████░░░] 90%             |
| HTML        [███████████████████░░░░░░] 85%             |
| CSS         [█████████████████░░░░░░░░] 75%             |
| JavaScript  [███████████████░░░░░░░░░░] 70%             |
+---------------------------------------------------------+
|                   PROJECTS                              |
+---------------------------------------------------------+
| +------------------------+  +------------------------+  |
| | [Project 1 Screenshot] |  | [Project 2 Screenshot] |  |
| | E-Commerce Website     |  | Task Manager App       |  |
| | HTML, CSS, JavaScript  |  | React, Node.js         |  |
| | [View Project] [Code]  |  | [View Project] [Code]  |  |
| +------------------------+  +------------------------+  |
|                                                         |
| +------------------------+  +------------------------+  |
| | [Project 3 Screenshot] |  | [Project 4 Screenshot] |  |
| | Portfolio Website      |  | Weather App            |  |
| | React, CSS             |  | JavaScript, API        |  |
| | [View Project] [Code]  |  | [View Project] [Code]  |  |
| +------------------------+  +------------------------+  |
+---------------------------------------------------------+
|                   CONTACT ME                            |
+---------------------------------------------------------+
| +--------------------------------------------------+    |
| | Name:    [________________________]              |    |
| | Email:   [________________________]              |    |
| | Subject: [________________________]              |    |
| | Message:                                         |    |
| | [                                            ]   |    |
| | [                                            ]   |    |
| |                                                  |    |
| |                             [Submit Message]     |    |
| +--------------------------------------------------+    |
+---------------------------------------------------------+
|                   FOOTER                                |
+---------------------------------------------------------+
| © 2025 John Doe - All Rights Reserved                   |
|                                                         |
| [GitHub] [LinkedIn] [Twitter] [Instagram]               |
+---------------------------------------------------------+
```
