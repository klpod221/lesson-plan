# Rust Examples

This directory contains example Rust programs demonstrating key concepts from the tutorial.

## Files

1. **01_basics.rs** - Variables, data types, control flow, and functions
2. **02_ownership.rs** - Ownership, borrowing, and references
3. **03_structs.rs** - Structs, methods, and implementations
4. **04_enums.rs** - Enums, pattern matching, Option, and Result
5. **05_collections.rs** - Vec, String, HashMap, and other collections
6. **06_traits.rs** - Traits, generics, and trait bounds

## How to Run

### Single file
```bash
rustc 01_basics.rs
./01_basics
```

### Or use rustc directly
```bash
rustc 02_ownership.rs -o ownership
./ownership
```

### Using Cargo (recommended)

Create a new Cargo project and copy the examples:

```bash
cargo new rust_examples
cd rust_examples
```

Copy any example file to `src/main.rs`:
```bash
cp 01_basics.rs rust_examples/src/main.rs
```

Run:
```bash
cargo run
```

## Example Output

### 01_basics.rs
```
=== Variables and Data Types ===
x = 5
y = 10
y after mutation = 20
...
```

### 02_ownership.rs
```
=== Ownership ===
s2: hello
s3: world, s4: world
...
```

## Notes

- All examples use `println!` macro for output
- Examples demonstrate Rust's ownership system
- Code is formatted according to Rust conventions
- Each file is self-contained and runnable
