---
prev:
  text: '⚡ Advanced SQL Topics'
  link: '/SQL/Part4'
next:
  text: '🧵 Threads, Multithreading and JDBC'
  link: '/JAVA/Part5'
---

# 🧪 FINAL PROJECT (SQL)

## **Project: Library Management Database**

Design and implement a complete database for a library management application, including features such as user registration, book borrowing, book returns, book search, borrowing statistics, and book information management.

### System Description

- **Users**: Readers and library staff
- **Main Features**:
  - User registration
  - Login
  - Search books by multiple criteria (title, author, genre)
  - Borrow books
  - Return books
  - Borrowing statistics by time period
  - Book information management (add, edit, delete)
  - User information management (readers and staff)

### Database Requirements

- `users` table with reader/staff classification
- `books` table with complete book information
- `transactions` table storing borrow/return transactions
- `categories` table for book classification
- `publishers` table for publisher information

### SQL Features to Implement

1. **Stored Procedures**:

   - Register new user
   - Add new book to system
   - Process book borrowing transaction
   - Process book return and late fees
   - Advanced book search (by multiple criteria)

2. **Triggers**:

   - Update book quantity when borrowing/returning
   - Check borrowing conditions (available quantity, user not blocked)
   - Log critical operations

3. **Views**:

   - List of currently borrowed books
   - Detailed book information with status
   - Borrowing statistics by reader
   - Most popular books statistics

4. **Optimization**:

   - Create indexes for frequently searched fields
   - Design efficient table structure
   - Optimize complex queries

5. **Security**:
   - User permission management (readers, staff)
   - Use views to hide sensitive information

---

After completing this final project, you will have mastered basic and advanced concepts in SQL, including database design, writing complex queries, using stored procedures, triggers, views and performance optimization.

Next, you will return to Java to continue learning and applying the knowledge learned in SQL to real-world applications.
