# C/C++ Examples

This directory contains example C and C++ programs demonstrating key concepts from the tutorial.

## Files

### C Examples
1. **01_c_basics.c** - Variables, data types, control flow, and functions
2. **02_c_pointers.c** - Pointers, arrays, and dynamic memory
3. **03_c_structs.c** - Structs and file I/O

### C++ Examples
4. **04_cpp_oop.cpp** - Classes, encapsulation, and operator overloading
5. **05_cpp_polymorphism.cpp** - Inheritance, polymorphism, and abstract classes
6. **06_cpp_stl.cpp** - STL containers, algorithms, and templates

## How to Compile and Run

### C Programs

```bash
# Compile
gcc 01_c_basics.c -o basics

# Run
./basics
```

### C++ Programs

```bash
# Compile (C++17)
g++ -std=c++17 04_cpp_oop.cpp -o oop

# Run
./oop
```

### Compile all at once

```bash
# C files
gcc 01_c_basics.c -o c_basics
gcc 02_c_pointers.c -o c_pointers
gcc 03_c_structs.c -o c_structs

# C++ files
g++ -std=c++17 04_cpp_oop.cpp -o cpp_oop
g++ -std=c++17 05_cpp_polymorphism.cpp -o cpp_poly
g++ -std=c++17 06_cpp_stl.cpp -o cpp_stl
```

## Example Output

### 01_c_basics.c
```
=== Variables and Data Types ===
age = 25
year = 2024
population = 8000000000
...
```

### 04_cpp_oop.cpp
```
=== Bank Account ===
Account created for Alice
Account: ACC001, Owner: Alice, Balance: $1000
...
```

## Compiler Flags

### Recommended C flags:
```bash
gcc -Wall -Wextra -std=c11 file.c -o output
```

### Recommended C++ flags:
```bash
g++ -Wall -Wextra -std=c++17 file.cpp -o output
```

## Notes

- C examples focus on procedural programming
- C++ examples demonstrate OOP and modern C++ features
- All code is well-commented
- Memory management examples use proper allocation/deallocation
- File I/O examples may create files in the current directory
