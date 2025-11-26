---
prev:
  text: '🏠 Home'
  link: '/'
next:
  text: '🛠️ Environment Setup'
  link: '/INSTALL'
---

# 📘 PROGRAMMING OVERVIEW

## 🎯 General Objectives

- Clearly understand programming, programming languages and basic concepts in programming.
- Master basic concepts about computers, operating systems and computer networks.
- Get familiar with programming tools and development environments.
- Know how to organize source code and manage programming projects.

## 🧑‍🏫 Lesson 1: Introduction to Programming and Programming Languages

### What is Programming?

Programming is the process of writing, testing, debugging and maintaining source code of computer programs. This is a creative process that helps computers perform specific tasks using programming languages.

> 💡 **Illustration:** Programming is like writing a detailed cooking recipe for a computer. The computer will follow exactly each step in the recipe without the ability to reason or make creative decisions.

### Basic Concepts in Programming

1. **Algorithm**: A set of logical, ordered steps to solve a specific problem.

   - Example: Sorting algorithm, searching, data processing

   ```text
   Bubble Sort Algorithm:
   1. Traverse through the array from start to end
   2. Compare adjacent elements
   3. Swap positions if the previous element is larger than the next one
   4. Repeat the process until no more swaps

   Initial array: [5, 3, 8, 4, 2]

   Outer loop 1:
      [5, 3, 8, 4, 2] → Compare 5 and 3 → Swap → [3, 5, 8, 4, 2]
      [3, 5, 8, 4, 2] → Compare 5 and 8 → No swap → [3, 5, 8, 4, 2]
      [3, 5, 8, 4, 2] → Compare 8 and 4 → Swap → [3, 5, 4, 8, 2]
      [3, 5, 4, 8, 2] → Compare 8 and 2 → Swap → [3, 5, 4, 2, 8]

   End of round 1: [3, 5, 4, 2, 8] (Largest element 8 is at the last position)

   Outer loop 2:
      [3, 5, 4, 2, 8] → Compare 3 and 5 → No swap → [3, 5, 4, 2, 8]
      [3, 5, 4, 2, 8] → Compare 5 and 4 → Swap → [3, 4, 5, 2, 8]
      [3, 4, 5, 2, 8] → Compare 5 and 2 → Swap → [3, 4, 2, 5, 8]

   End of round 2: [3, 4, 2, 5, 8] (Second largest element 5 is in correct position)

   Outer loop 3:
      [3, 4, 2, 5, 8] → Compare 3 and 4 → No swap → [3, 4, 2, 5, 8]
      [3, 4, 2, 5, 8] → Compare 4 and 2 → Swap → [3, 2, 4, 5, 8]

   End of round 3: [3, 2, 4, 5, 8] (Third largest element 4 is in correct position)

   Outer loop 4:
      [3, 2, 4, 5, 8] → Compare 3 and 2 → Swap → [2, 3, 4, 5, 8]

   End of round 4: [2, 3, 4, 5, 8] (Array is sorted)
   ```

2. **Variable**: A place to store data in the program.

   - Example:

     ```javascript
     // JavaScript
     let age = 25; // Variable age stores integer value 25
     const name = "Alice"; // Variable name stores string "Alice"
     var isStudent = true; // Variable isStudent stores boolean value true
     ```

3. **Data Type**: Determines the type of data stored in a variable.

   - Basic:

     - integer: `42`, `-7`, `0`
     - float: `3.14`, `-0.001`, `2.0`
     - string: `"Hello"`, `'World'`, `"123"`
     - boolean (true/false): `true`, `false`

   - Complex:
     - array: `[1, 2, 3]`, `["apple", "orange", "banana"]`
     - object: `{name: "John", age: 30}`
     - class: Template to create objects

4. **Control Structure**:

   - Branching:

     ```python
     # Python
     if age >= 18:
         print("You are eligible to vote")
     else:
         print("You are not eligible to vote")
     ```

   - Loops:

     ```cpp
     // C++
     for(int i = 0; i < 5; i++) {
         cout << i << " ";  // Output: 0 1 2 3 4
     }

     int j = 0;
     while(j < 5) {
         cout << j << " ";  // Output: 0 1 2 3 4
         j++;
     }
     ```

5. **Function**: A block of code that performs a specific task and can be reused.

   ```java
   // JAVA
   public int sum(int a, int b) {
       return a + b;  // Function adds two numbers
   }

   // Call function
   int result = sum(5, 3);  // result = 8
   ```

### Programming Languages

1. **Classification by level:**

   - **Low-level languages**: Assembly, Machine Language - close to computer language

     ```assembly
     ; Assembly - Add two numbers
     MOV AL, 5    ; Assign value 5 to register AL
     MOV BL, 3    ; Assign value 3 to register BL
     ADD AL, BL   ; Add BL to AL (AL = AL + BL)
     ```

   - **Mid-level languages**: C, C++ - combination of high and low level

     ```c
     // C - Add two numbers
     int sum = 5 + 3;
     ```

   - **High-level languages**: Python, JAVA, JavaScript - close to natural language

     ```python
     # Python - Add two numbers
     sum = 5 + 3
     ```

2. **Classification by programming paradigm:**

   - **Procedural**: C, Pascal

     ```c
     // C - Procedural
     void printDetails(struct Person p) {
         printf("Name: %s\n", p.name);
         printf("Age: %d\n", p.age);
     }
     ```

   - **Object-Oriented**: JAVA, C++, C#, Python

     ```java
     // JAVA - OOP
     class Person {
         private String name;
         private int age;

         public void printDetails() {
             System.out.println("Name: " + name);
             System.out.println("Age: " + age);
         }
     }
     ```

   - **Functional**: Haskell, Scala, JavaScript (partial)

     ```javascript
     // JavaScript - Functional
     const numbers = [1, 2, 3, 4, 5];
     const doubled = numbers.map((n) => n * 2); // [2, 4, 6, 8, 10]
     ```

   - **Logic**: Prolog

     ```prolog
     /* Prolog - Logic */
     parent(john, mary).
     parent(john, tom).
     parent(jane, mary).

     sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
     ```

3. **Classification by execution method:**
   - **Compiled**: C, C++, Rust - converts entire source code to machine code before execution
   - **Interpreted**: Python, JavaScript - translates and executes line by line
   - **Hybrid**: JAVA, C# - compiles to bytecode, then interpreted by virtual machine

### Basic Software Development Process

1. **Requirements Analysis**: Clearly understand the problem to be solved

   - Example: Determine that the system needs login functionality, user management, and reporting.

2. **Design**: Build program structure and algorithms

   - Example: Design database, user interface, and functional modules.

3. **Programming**: Write source code

   - Example: Program functions according to confirmed design.

4. **Testing**: Find and fix bugs

   - Example: Check if login functionality works correctly.

5. **Deployment**: Put software into use

   - Example: Install software on production server and provide to users.

6. **Maintenance**: Update, fix bugs and upgrade the program
   - Example: Add new features or fix bugs after discovery.

## 🧑‍🏫 Lesson 2: Computer Basics, Operating Systems and Computer Networks

### Basic Computer Architecture

```text
Computer
|
|-- Hardware
|   |-- CPU (Central Processing Unit)
|   |   |-- ALU (Arithmetic Logic Unit)
|   |   |-- CU (Control Unit)
|   |   |-- Registers
|   |   |-- Cache
|   |
|   |-- Memory
|   |   |-- RAM (Random Access Memory)
|   |   |-- ROM (Read-Only Memory)
|   |
|   |-- Storage Devices
|   |   |-- HDD Hard Drive
|   |   |-- SSD Solid State Drive
|   |   |-- USB/Portable Storage
|   |
|   |-- Input/Output Devices
|       |-- Input Devices
|       |   |-- Keyboard
|       |   |-- Mouse
|       |   |-- Scanner
|       |   |-- Microphone
|       |
|       |-- Output Devices
|           |-- Monitor
|           |-- Printer
|           |-- Speakers
|
|-- Software
    |-- Operating System
    |-- Application Software
```

1. **Hardware**:

   - **CPU (Central Processing Unit)**: Central processing unit - the "brain" of the computer
   - **RAM (Random Access Memory)**: Temporary storage
   - **ROM (Read-Only Memory)**: Stores firmware
   - **Storage Devices**: HDD, SSD - long-term storage
   - **Input/Output Devices**: Keyboard, mouse, monitor, speakers

2. **Information Units**:
   - Bit: Smallest unit (0 or 1)
   - Byte: 8 bits
   - KB (Kilobyte): 1,024 bytes
   - MB (Megabyte): 1,024 KB
   - GB (Gigabyte): 1,024 MB
   - TB (Terabyte): 1,024 GB

### Operating System

An operating system is software that manages computer hardware and software, providing an interface for users and applications.

```text
Operating System
|
|-- Kernel
|   |-- Process Management
|   |-- Memory Management
|   |-- Device Drivers
|   |-- Security
|   |-- Network Stack
|
|-- Shell
|   |-- Command Line Interface
|   |-- Script Interpreter
|
|-- File System
|   |-- Directory/File Structure
|   |-- Access Permissions
|   |-- Storage Space Management
|
|-- Graphical Interface
|
|-- Operating System Categories:
    |-- Windows
    |-- Linux
    |-- macOS
    |-- Android
    |-- iOS
```

1. **Operating System Functions**:

   - Manage hardware and software
   - Manage processes and resources
   - Provide user interface
   - File management and security

2. **Common Operating Systems**:

   - **Windows**: Popular in personal and enterprise environments
   - **macOS**: Apple's operating system for Mac computers
   - **Linux**: Open source operating system, popular for servers and developers
   - **Android**: For mobile devices, based on Linux kernel
   - **iOS**: Operating system for Apple mobile devices

3. **Command Line Interface**:
   - **Windows**: Command Prompt, PowerShell
   - **macOS/Linux**: Terminal, Bash, Zsh

### Computer Networks

A computer network is a collection of connected devices to share resources and information. Thus, the internet is essentially a computer network connecting billions of devices worldwide. Or when you connect 2 computers together to share data, you've created a small computer network.

```text
Computer Network
|
|-- Network Models
|   |-- OSI Model - 7 Layers
|   |   |-- 1. Physical
|   |   |-- 2. Data Link
|   |   |-- 3. Network
|   |   |-- 4. Transport
|   |   |-- 5. Session
|   |   |-- 6. Presentation
|   |   |-- 7. Application
|   |
|   |-- TCP/IP Model - 4 Layers
|       |-- 1. Link Layer
|       |-- 2. Internet Layer
|       |-- 3. Transport Layer
|       |-- 4. Application Layer
|
|-- Network Components
|   |-- Router
|   |-- Switch
|   |-- Hub
|   |-- Modem
|   |-- Network Card
|   |-- Network Cable
|
|-- Network Types
|   |-- LAN (Local Area Network)
|   |-- WAN (Wide Area Network)
|   |-- MAN (Metropolitan Area Network)
|   |-- PAN (Personal Area Network)
|   |-- Internet (Global Network)
|
|-- Protocols
    |-- IP (Internet Protocol)
    |-- TCP (Transmission Control Protocol)
    |-- UDP (User Datagram Protocol)
    |-- HTTP/HTTPS
    |-- DNS (Domain Name System)
    |-- DHCP (Dynamic Host Configuration Protocol)
```

1. **OSI and TCP/IP Models**:

   - **OSI Model**: 7 layers (Physical, Data Link, Network, Transport, Session, Presentation, Application)
   - **TCP/IP Model**: 4 layers (Link, Internet, Transport, Application)

2. **Basic Concepts**:

   - **IP (Internet Protocol)**: Identifier for devices in network
   - **DNS (Domain Name System)**: Converts domain names to IP addresses
   - **HTTP/HTTPS**: Hypertext transfer protocol
   - **Client-Server**: Common connection model in networks

3. **Network Types**:
   - **LAN (Local Area Network)**: Local network in small scope
   - **WAN (Wide Area Network)**: Wide area network connecting multiple LANs
   - **Internet**: Global network connecting billions of devices

## 🧑‍🏫 Lesson 3: Programming Tools and Development Environment

### Integrated Development Environment (IDE)

1. **Popular IDEs**:

   - **Visual Studio Code**: Actually a lightweight but very powerful code editor, cross-platform, supports many languages, and can be extended with extensions
   - **IntelliJ IDEA**: Powerful for JAVA, Kotlin, and other JVM languages
   - **Eclipse**: Popular for JAVA, has many plugins
   - **Visual Studio**: Powerful for C#, .NET and Windows development
   - **PyCharm**: Specialized for Python

2. **Main IDE Features**:
   - Code Editor with syntax highlighting
   - Debugger
   - Code Completion
   - Integration with version control systems
   - Build and run tools

### Compilers & Interpreters

1. **Compiler**:

   - Converts entire source code to machine code before execution
   - Examples: GCC for C/C++, javac for JAVA

2. **Interpreter**:
   - Reads and executes source code directly, line by line
   - Examples: Python interpreter, Node.js for JavaScript

### Version Control System

1. **Functions**:

   - Track changes in source code
   - Coordinate teamwork
   - Revert to previous versions when needed

2. **Common Systems**:

   - **Git**: Distributed, most popular currently
   - **SVN (Subversion)**: Centralized, older
   - **Mercurial**: Distributed, similar to Git

3. **Source Code Hosting Platforms**:
   - **GitHub**: Most popular, supports many collaboration features
   - **GitLab**: Has self-hosted version
   - **Bitbucket**: Integrates well with other Atlassian products

### Other Development Support Tools

1. **Package Manager**:

   - **npm** for JavaScript
   - **pip** for Python
   - **Maven/Gradle** for JAVA
   - **Composer** for PHP
   - **NuGet** for .NET

2. **Testing Tools**:

   - Unit testing frameworks
   - Integration testing tools
   - Performance testing tools

3. **CI/CD (Continuous Integration/Continuous Deployment)**:
   - **Jenkins**
   - **GitHub Actions**
   - **GitLab CI/CD**
   - **Travis CI**

## 🧑‍🏫 Lesson 4: Source Code Organization and Programming Project Management

### Project Structure

1. **Directory Organization**: (example, may vary by language and framework)

   ```plaintext
   ├── src/        # Main code
   ├── build/      # Compiled files (if any)
   ├── tests/      # Test files
   ├── docs/       # Documentation
   ├── .gitignore  # File to exclude unnecessary files from git
   ├── README.md   # Project introduction documentation
   ├── LICENSE     # License
   └── .env        # Environment configuration file (if any)
   ```

2. **Separation of Concerns**:

   - Each file/module solves only one problem
   - Divide project into logical layers (UI, business logic, data access)

### Naming Conventions and Coding Style

1. **Naming Conventions**:

   - **camelCase**: Commonly used for variables and functions (JavaScript, JAVA)
   - **PascalCase**: Commonly used for classes (JAVA, C#)
   - **snake_case**: Commonly used for variables (Python)
   - **kebab-case**: Commonly used for folders and URLs

2. **Coding Style Guides**:
   - Google Style Guides
   - PEP 8 for Python
   - Airbnb JavaScript Style Guide
   - PSR for PHP

### Programming Project Management

1. **Software Development Methodologies**:

   - **Agile**: Flexible, adapt to changes
   - **Scrum**: Short sprints (2-4 weeks), daily meetings
   - **Kanban**: Continuous workflow management
   - **Waterfall**: Sequential, few changes once requirements confirmed

2. **Project Management Tools**:

   - **Jira**: Manage tasks, bugs, and sprints
   - **Trello**: Simple Kanban board
   - **Asana**: Task and timeline management
   - **GitHub Projects/Issues**: Integrated with source code

3. **Documentation**:
   - **README**: Project introduction, installation and usage guide
   - **API Documentation**: Swagger, OpenAPI
   - **Code Comments**: Explain complex parts (should use clear code that can explain itself instead of relying on comments)
   - **Wiki**: Detailed documentation and usage guide

### Security and Code Quality

1. **Testing**:

   - **Unit Testing**: Test individual small code units
   - **Integration Testing**: Test interaction between components
   - **E2E Testing**: Test entire process

2. **Code Review**:

   - Code review process before merge
   - Discover bugs, improve code quality
   - Share knowledge in team

3. **Basic Security**:
   - Don't store sensitive information in source code
   - Use environment variables for configuration information
   - Avoid common security vulnerabilities (SQL Injection, XSS)

---

Thus, you have been equipped with an overview of the programming world: from languages and basic concepts, computer architecture and operating systems, to computer networks, development tools, and project management methods. This is the solid foundation to continue your learning journey and develop your programming skills.

Next we will officially start with start setting up the environment for learning.
