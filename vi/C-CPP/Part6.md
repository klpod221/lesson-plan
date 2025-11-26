# 📘 PHẦN 6: STL, TEMPLATES VÀ MODERN C++

## 🎯 Mục tiêu tổng quát

- Hiểu và sử dụng templates trong C++
- Nắm vững STL containers và algorithms
- Sử dụng iterators hiệu quả
- Áp dụng lambda expressions
- Hiểu các tính năng Modern C++ (C++11/14/17)
- Sử dụng smart pointers
- Áp dụng move semantics

## 🧑‍🏫 Bài 1: Function Templates

### Template cơ bản

```cpp
#include <iostream>
using namespace std;

// Function template
template <typename T>
T getMax(T a, T b) {
    return (a > b) ? a : b;
}

// Explicit template parameter
template <typename T>
void display(T value) {
    cout << "Value: " << value << endl;
}

int main() {
    // Compiler deduces type
    cout << "Max of 10 and 20: " << getMax(10, 20) << endl;
    cout << "Max of 3.5 and 2.1: " << getMax(3.5, 2.1) << endl;
    cout << "Max of 'a' and 'z': " << getMax('a', 'z') << endl;
    
    // Explicit type specification
    cout << "Max<double>: " << getMax<double>(10, 20.5) << endl;
    
    display(42);
    display(3.14);
    display("Hello");
    
    return 0;
}
```

### Multiple template parameters

```cpp
#include <iostream>
using namespace std;

template <typename T1, typename T2>
void printPair(T1 first, T2 second) {
    cout << "(" << first << ", " << second << ")" << endl;
}

template <typename T1, typename T2>
auto add(T1 a, T2 b) -> decltype(a + b) {
    return a + b;
}

template <typename T>
void swap(T &a, T &b) {
    T temp = a;
    a = b;
    b = temp;
}

int main() {
    printPair(10, 3.14);
    printPair("Name", 25);
    printPair('A', 100);
    
    cout << "Add int and double: " << add(5, 3.14) << endl;
    cout << "Add double and int: " << add(2.5, 10) << endl;
    
    int x = 10, y = 20;
    cout << "Before swap: x=" << x << ", y=" << y << endl;
    swap(x, y);
    cout << "After swap: x=" << x << ", y=" << y << endl;
    
    return 0;
}
```

### Template specialization

```cpp
#include <iostream>
#include <cstring>
using namespace std;

// Generic template
template <typename T>
T getMax(T a, T b) {
    cout << "Generic template" << endl;
    return (a > b) ? a : b;
}

// Template specialization for const char*
template <>
const char* getMax<const char*>(const char* a, const char* b) {
    cout << "Specialized for const char*" << endl;
    return (strcmp(a, b) > 0) ? a : b;
}

// Template specialization for bool
template <>
bool getMax<bool>(bool a, bool b) {
    cout << "Specialized for bool" << endl;
    return a || b;
}

int main() {
    cout << getMax(10, 20) << endl;
    cout << getMax(3.14, 2.71) << endl;
    cout << getMax("apple", "banana") << endl;
    cout << getMax(true, false) << endl;
    
    return 0;
}
```

## 🧑‍🏫 Bài 2: Class Templates

### Class template cơ bản

```cpp
#include <iostream>
using namespace std;

template <typename T>
class Box {
private:
    T value;
    
public:
    Box(T v) : value(v) {}
    
    T getValue() const {
        return value;
    }
    
    void setValue(T v) {
        value = v;
    }
    
    void display() const {
        cout << "Box contains: " << value << endl;
    }
};

int main() {
    Box<int> intBox(42);
    intBox.display();
    
    Box<double> doubleBox(3.14);
    doubleBox.display();
    
    Box<string> stringBox("Hello");
    stringBox.display();
    
    // Modify value
    intBox.setValue(100);
    cout << "New value: " << intBox.getValue() << endl;
    
    return 0;
}
```

### Template với multiple parameters

```cpp
#include <iostream>
using namespace std;

template <typename T1, typename T2>
class Pair {
private:
    T1 first;
    T2 second;
    
public:
    Pair(T1 f, T2 s) : first(f), second(s) {}
    
    T1 getFirst() const { return first; }
    T2 getSecond() const { return second; }
    
    void setFirst(T1 f) { first = f; }
    void setSecond(T2 s) { second = s; }
    
    void display() const {
        cout << "(" << first << ", " << second << ")" << endl;
    }
};

int main() {
    Pair<int, double> p1(10, 3.14);
    p1.display();
    
    Pair<string, int> p2("Age", 25);
    p2.display();
    
    Pair<char, string> p3('A', "Apple");
    p3.display();
    
    return 0;
}
```

### Template member functions

```cpp
#include <iostream>
using namespace std;

template <typename T>
class Array {
private:
    T *data;
    int size;
    
public:
    Array(int s) : size(s) {
        data = new T[size];
    }
    
    ~Array() {
        delete[] data;
    }
    
    T& operator[](int index) {
        return data[index];
    }
    
    int getSize() const {
        return size;
    }
    
    // Template member function
    template <typename U>
    void fill(U value) {
        for (int i = 0; i < size; i++) {
            data[i] = static_cast<T>(value);
        }
    }
    
    void display() const {
        cout << "[";
        for (int i = 0; i < size; i++) {
            cout << data[i];
            if (i < size - 1) cout << ", ";
        }
        cout << "]" << endl;
    }
};

int main() {
    Array<int> intArr(5);
    intArr.fill(42);
    intArr.display();
    
    Array<double> doubleArr(3);
    doubleArr.fill(3.14);
    doubleArr.display();
    
    Array<char> charArr(4);
    charArr.fill('X');
    charArr.display();
    
    return 0;
}
```

## 🧑‍🏫 Bài 3: STL Containers

### Vector

```cpp
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    // Create vector
    vector<int> vec;
    
    // Add elements
    vec.push_back(10);
    vec.push_back(20);
    vec.push_back(30);
    
    // Initialize with values
    vector<int> vec2 = {1, 2, 3, 4, 5};
    
    // Access elements
    cout << "First element: " << vec[0] << endl;
    cout << "Last element: " << vec.back() << endl;
    cout << "Using at(): " << vec.at(1) << endl;
    
    // Size and capacity
    cout << "Size: " << vec.size() << endl;
    cout << "Capacity: " << vec.capacity() << endl;
    
    // Iterate
    cout << "Elements: ";
    for (int val : vec) {
        cout << val << " ";
    }
    cout << endl;
    
    // Insert and erase
    vec.insert(vec.begin() + 1, 15);  // Insert 15 at position 1
    vec.erase(vec.begin());            // Remove first element
    
    // Sort
    sort(vec.begin(), vec.end());
    
    // Find
    auto it = find(vec.begin(), vec.end(), 20);
    if (it != vec.end()) {
        cout << "Found 20 at position: " << distance(vec.begin(), it) << endl;
    }
    
    // Clear
    vec.clear();
    cout << "After clear, size: " << vec.size() << endl;
    
    return 0;
}
```

### List

```cpp
#include <iostream>
#include <list>
using namespace std;

int main() {
    list<int> myList = {1, 2, 3, 4, 5};
    
    // Add elements
    myList.push_back(6);
    myList.push_front(0);
    
    // Display
    cout << "List: ";
    for (int val : myList) {
        cout << val << " ";
    }
    cout << endl;
    
    // Insert
    auto it = myList.begin();
    advance(it, 3);  // Move iterator to position 3
    myList.insert(it, 99);
    
    // Remove
    myList.remove(99);  // Remove all occurrences of 99
    
    // Sort and reverse
    myList.sort();
    myList.reverse();
    
    cout << "After operations: ";
    for (int val : myList) {
        cout << val << " ";
    }
    cout << endl;
    
    // Size
    cout << "Size: " << myList.size() << endl;
    
    return 0;
}
```

### Map và Unordered Map

```cpp
#include <iostream>
#include <map>
#include <unordered_map>
using namespace std;

int main() {
    // Map (ordered)
    map<string, int> ages;
    
    ages["Alice"] = 25;
    ages["Bob"] = 30;
    ages["Charlie"] = 28;
    
    // Access
    cout << "Alice's age: " << ages["Alice"] << endl;
    
    // Check if key exists
    if (ages.find("David") != ages.end()) {
        cout << "David found" << endl;
    } else {
        cout << "David not found" << endl;
    }
    
    // Iterate (sorted by key)
    cout << "\nMap contents (sorted):" << endl;
    for (const auto &pair : ages) {
        cout << pair.first << ": " << pair.second << endl;
    }
    
    // Unordered map (hash table)
    unordered_map<string, double> prices;
    
    prices["Apple"] = 1.99;
    prices["Banana"] = 0.99;
    prices["Orange"] = 2.49;
    
    cout << "\nUnordered map contents:" << endl;
    for (const auto &pair : prices) {
        cout << pair.first << ": $" << pair.second << endl;
    }
    
    // Erase
    ages.erase("Bob");
    
    // Size
    cout << "\nMap size: " << ages.size() << endl;
    
    return 0;
}
```

### Set và Unordered Set

```cpp
#include <iostream>
#include <set>
#include <unordered_set>
using namespace std;

int main() {
    // Set (ordered, unique elements)
    set<int> mySet = {5, 2, 8, 1, 9, 2, 5};  // Duplicates ignored
    
    cout << "Set (sorted): ";
    for (int val : mySet) {
        cout << val << " ";
    }
    cout << endl;
    
    // Insert
    mySet.insert(3);
    mySet.insert(7);
    
    // Find
    if (mySet.find(5) != mySet.end()) {
        cout << "5 is in the set" << endl;
    }
    
    // Erase
    mySet.erase(2);
    
    // Unordered set (hash set)
    unordered_set<string> words = {"hello", "world", "cpp", "hello"};
    
    cout << "\nUnordered set: ";
    for (const string &word : words) {
        cout << word << " ";
    }
    cout << endl;
    
    // Count (returns 0 or 1)
    cout << "Count of 'hello': " << words.count("hello") << endl;
    cout << "Count of 'java': " << words.count("java") << endl;
    
    return 0;
}
```

### Queue và Stack

```cpp
#include <iostream>
#include <queue>
#include <stack>
using namespace std;

int main() {
    // Queue (FIFO)
    queue<int> q;
    
    q.push(10);
    q.push(20);
    q.push(30);
    
    cout << "Queue front: " << q.front() << endl;
    cout << "Queue back: " << q.back() << endl;
    
    while (!q.empty()) {
        cout << "Dequeue: " << q.front() << endl;
        q.pop();
    }
    
    // Stack (LIFO)
    stack<string> s;
    
    s.push("First");
    s.push("Second");
    s.push("Third");
    
    cout << "\nStack top: " << s.top() << endl;
    cout << "Stack size: " << s.size() << endl;
    
    while (!s.empty()) {
        cout << "Pop: " << s.top() << endl;
        s.pop();
    }
    
    // Priority queue (max heap by default)
    priority_queue<int> pq;
    
    pq.push(30);
    pq.push(10);
    pq.push(50);
    pq.push(20);
    
    cout << "\nPriority queue (max heap):" << endl;
    while (!pq.empty()) {
        cout << pq.top() << " ";
        pq.pop();
    }
    cout << endl;
    
    return 0;
}
```

## 🧑‍🏫 Bài 4: STL Algorithms và Iterators

### Iterators

```cpp
#include <iostream>
#include <vector>
#include <list>
using namespace std;

int main() {
    vector<int> vec = {1, 2, 3, 4, 5};
    
    // Iterator types
    vector<int>::iterator it;
    vector<int>::const_iterator cit;
    vector<int>::reverse_iterator rit;
    
    // Forward iteration
    cout << "Forward: ";
    for (it = vec.begin(); it != vec.end(); ++it) {
        cout << *it << " ";
    }
    cout << endl;
    
    // Reverse iteration
    cout << "Reverse: ";
    for (rit = vec.rbegin(); rit != vec.rend(); ++rit) {
        cout << *rit << " ";
    }
    cout << endl;
    
    // Modify through iterator
    for (it = vec.begin(); it != vec.end(); ++it) {
        *it *= 2;
    }
    
    cout << "After modification: ";
    for (int val : vec) {
        cout << val << " ";
    }
    cout << endl;
    
    return 0;
}
```

### Common algorithms

```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
using namespace std;

int main() {
    vector<int> vec = {5, 2, 8, 1, 9, 3, 7, 4, 6};
    
    // Sort
    sort(vec.begin(), vec.end());
    cout << "Sorted: ";
    for (int val : vec) cout << val << " ";
    cout << endl;
    
    // Reverse
    reverse(vec.begin(), vec.end());
    cout << "Reversed: ";
    for (int val : vec) cout << val << " ";
    cout << endl;
    
    // Find
    auto it = find(vec.begin(), vec.end(), 5);
    if (it != vec.end()) {
        cout << "Found 5 at position: " << distance(vec.begin(), it) << endl;
    }
    
    // Count
    int count = count_if(vec.begin(), vec.end(), [](int x) { return x > 5; });
    cout << "Elements > 5: " << count << endl;
    
    // Min and Max
    cout << "Min: " << *min_element(vec.begin(), vec.end()) << endl;
    cout << "Max: " << *max_element(vec.begin(), vec.end()) << endl;
    
    // Sum
    int sum = accumulate(vec.begin(), vec.end(), 0);
    cout << "Sum: " << sum << endl;
    
    // Binary search (requires sorted vector)
    sort(vec.begin(), vec.end());
    if (binary_search(vec.begin(), vec.end(), 5)) {
        cout << "5 found (binary search)" << endl;
    }
    
    // Transform
    vector<int> squared(vec.size());
    transform(vec.begin(), vec.end(), squared.begin(), [](int x) { return x * x; });
    
    cout << "Squared: ";
    for (int val : squared) cout << val << " ";
    cout << endl;
    
    // Remove duplicates
    vec.erase(unique(vec.begin(), vec.end()), vec.end());
    
    return 0;
}
```

### Lambda expressions

```cpp
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    vector<int> vec = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    
    // Simple lambda
    auto print = [](int x) { cout << x << " "; };
    
    cout << "Vector: ";
    for_each(vec.begin(), vec.end(), print);
    cout << endl;
    
    // Lambda with capture
    int threshold = 5;
    auto isGreater = [threshold](int x) { return x > threshold; };
    
    int count = count_if(vec.begin(), vec.end(), isGreater);
    cout << "Elements > " << threshold << ": " << count << endl;
    
    // Lambda with mutable capture
    int sum = 0;
    for_each(vec.begin(), vec.end(), [&sum](int x) { sum += x; });
    cout << "Sum: " << sum << endl;
    
    // Lambda for sorting
    vector<string> names = {"Alice", "Bob", "Charlie", "David"};
    sort(names.begin(), names.end(), [](const string &a, const string &b) {
        return a.length() < b.length();
    });
    
    cout << "Sorted by length: ";
    for (const string &name : names) {
        cout << name << " ";
    }
    cout << endl;
    
    // Generic lambda (C++14)
    auto multiply = [](auto a, auto b) { return a * b; };
    cout << "5 * 10 = " << multiply(5, 10) << endl;
    cout << "2.5 * 3.0 = " << multiply(2.5, 3.0) << endl;
    
    return 0;
}
```

## 🧑‍🏫 Bài 5: Modern C++ Features (C++11/14/17)

### Auto keyword

```cpp
#include <iostream>
#include <vector>
#include <map>
using namespace std;

int main() {
    // Auto with basic types
    auto x = 42;          // int
    auto y = 3.14;        // double
    auto z = 'A';         // char
    auto s = "Hello";     // const char*
    
    // Auto with containers
    auto vec = vector<int>{1, 2, 3, 4, 5};
    
    // Auto with iterators
    for (auto it = vec.begin(); it != vec.end(); ++it) {
        cout << *it << " ";
    }
    cout << endl;
    
    // Auto with map
    auto ages = map<string, int>{% raw %}{{"Alice", 25}, {"Bob", 30}}{% endraw %};
    
    for (const auto &pair : ages) {
        cout << pair.first << ": " << pair.second << endl;
    }
    
    // Auto with function return
    auto getValue = []() -> int { return 42; };
    cout << "Value: " << getValue() << endl;
    
    return 0;
}
```

### Range-based for loops

```cpp
#include <iostream>
#include <vector>
#include <map>
using namespace std;

int main() {
    // With vector
    vector<int> vec = {1, 2, 3, 4, 5};
    
    cout << "Vector: ";
    for (int val : vec) {
        cout << val << " ";
    }
    cout << endl;
    
    // Modify elements (reference)
    for (int &val : vec) {
        val *= 2;
    }
    
    cout << "After modification: ";
    for (const auto &val : vec) {
        cout << val << " ";
    }
    cout << endl;
    
    // With map
    map<string, int> ages = {% raw %}{{"Alice", 25}, {"Bob", 30}, {"Charlie", 28}}{% endraw %};
    
    for (const auto &[name, age] : ages) {  // C++17 structured bindings
        cout << name << " is " << age << " years old" << endl;
    }
    
    // With array
    int arr[] = {10, 20, 30, 40, 50};
    
    cout << "Array: ";
    for (int val : arr) {
        cout << val << " ";
    }
    cout << endl;
    
    return 0;
}
```

### Smart pointers

```cpp
#include <iostream>
#include <memory>
using namespace std;

class Resource {
public:
    Resource() { cout << "Resource acquired" << endl; }
    ~Resource() { cout << "Resource destroyed" << endl; }
    void doSomething() { cout << "Doing something" << endl; }
};

void useUniquePtr() {
    cout << "\n=== unique_ptr ===" << endl;
    unique_ptr<Resource> ptr1 = make_unique<Resource>();
    ptr1->doSomething();
    
    // unique_ptr cannot be copied
    // unique_ptr<Resource> ptr2 = ptr1;  // ERROR!
    
    // But can be moved
    unique_ptr<Resource> ptr2 = move(ptr1);
    if (ptr1 == nullptr) {
        cout << "ptr1 is now null" << endl;
    }
    ptr2->doSomething();
}  // Resource automatically destroyed

void useSharedPtr() {
    cout << "\n=== shared_ptr ===" << endl;
    shared_ptr<Resource> ptr1 = make_shared<Resource>();
    cout << "Reference count: " << ptr1.use_count() << endl;
    
    {
        shared_ptr<Resource> ptr2 = ptr1;  // Can be copied
        cout << "Reference count: " << ptr1.use_count() << endl;
        ptr2->doSomething();
    }  // ptr2 destroyed, but Resource still alive
    
    cout << "Reference count: " << ptr1.use_count() << endl;
}  // Resource destroyed when last shared_ptr is destroyed

void useWeakPtr() {
    cout << "\n=== weak_ptr ===" << endl;
    shared_ptr<Resource> sptr = make_shared<Resource>();
    weak_ptr<Resource> wptr = sptr;
    
    cout << "shared_ptr count: " << sptr.use_count() << endl;
    cout << "weak_ptr expired: " << wptr.expired() << endl;
    
    if (auto locked = wptr.lock()) {
        locked->doSomething();
    }
    
    sptr.reset();  // Destroy resource
    cout << "After reset, weak_ptr expired: " << wptr.expired() << endl;
}

int main() {
    useUniquePtr();
    useSharedPtr();
    useWeakPtr();
    
    return 0;
}
```

### Move semantics

```cpp
#include <iostream>
#include <vector>
#include <string>
using namespace std;

class MyString {
private:
    char *data;
    size_t size;
    
public:
    // Constructor
    MyString(const char *str) {
        size = strlen(str);
        data = new char[size + 1];
        strcpy(data, str);
        cout << "Constructor: " << data << endl;
    }
    
    // Copy constructor
    MyString(const MyString &other) {
        size = other.size;
        data = new char[size + 1];
        strcpy(data, other.data);
        cout << "Copy constructor: " << data << endl;
    }
    
    // Move constructor (C++11)
    MyString(MyString &&other) noexcept {
        data = other.data;
        size = other.size;
        other.data = nullptr;
        other.size = 0;
        cout << "Move constructor" << endl;
    }
    
    // Destructor
    ~MyString() {
        if (data) {
            cout << "Destructor: " << data << endl;
            delete[] data;
        }
    }
    
    // Copy assignment
    MyString& operator=(const MyString &other) {
        if (this != &other) {
            delete[] data;
            size = other.size;
            data = new char[size + 1];
            strcpy(data, other.data);
            cout << "Copy assignment: " << data << endl;
        }
        return *this;
    }
    
    // Move assignment (C++11)
    MyString& operator=(MyString &&other) noexcept {
        if (this != &other) {
            delete[] data;
            data = other.data;
            size = other.size;
            other.data = nullptr;
            other.size = 0;
            cout << "Move assignment" << endl;
        }
        return *this;
    }
    
    void display() const {
        if (data) cout << "String: " << data << endl;
        else cout << "String: (empty)" << endl;
    }
};

int main() {
    MyString s1("Hello");
    
    MyString s2 = s1;  // Copy constructor
    
    MyString s3 = move(s1);  // Move constructor
    s1.display();  // s1 is now empty
    s3.display();
    
    MyString s4("World");
    s4 = s2;  // Copy assignment
    
    MyString s5("Temp");
    s5 = move(s4);  // Move assignment
    s4.display();
    s5.display();
    
    return 0;
}
```

### nullptr và constexpr

```cpp
#include <iostream>
using namespace std;

// constexpr function
constexpr int factorial(int n) {
    return (n <= 1) ? 1 : n * factorial(n - 1);
}

constexpr int square(int x) {
    return x * x;
}

// constexpr class
class Point {
private:
    int x, y;
    
public:
    constexpr Point(int x, int y) : x(x), y(y) {}
    
    constexpr int getX() const { return x; }
    constexpr int getY() const { return y; }
};

void processPointer(int *ptr) {
    if (ptr == nullptr) {
        cout << "Null pointer!" << endl;
    } else {
        cout << "Value: " << *ptr << endl;
    }
}

int main() {
    // nullptr (better than NULL)
    int *ptr1 = nullptr;
    int value = 42;
    int *ptr2 = &value;
    
    processPointer(ptr1);
    processPointer(ptr2);
    
    // constexpr - computed at compile time
    constexpr int fact5 = factorial(5);
    constexpr int sq10 = square(10);
    
    cout << "5! = " << fact5 << endl;
    cout << "10^2 = " << sq10 << endl;
    
    // constexpr with array size
    int arr[factorial(4)];  // Size is compile-time constant
    cout << "Array size: " << sizeof(arr) / sizeof(int) << endl;
    
    // constexpr object
    constexpr Point p(10, 20);
    cout << "Point: (" << p.getX() << ", " << p.getY() << ")" << endl;
    
    return 0;
}
```

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý thư viện sách

### Mô tả bài toán

Xây dựng hệ thống quản lý thư viện sách sử dụng STL và Modern C++:

- Quản lý sách (thêm, xóa, tìm kiếm, sắp xếp)
- Quản lý độc giả
- Mượn/trả sách
- Thống kê (sách được mượn nhiều nhất, độc giả mượn nhiều nhất)
- Lưu/load từ file

### Yêu cầu

1. **Sử dụng STL containers:**
   - `vector<Book>` để lưu danh sách sách
   - `map<string, Reader>` để lưu độc giả (key: ID)
   - `map<string, vector<string>>` để lưu lịch sử mượn sách
   - `set<string>` để lưu thể loại sách

2. **Templates:**
   - Generic function để tìm kiếm
   - Generic function để sắp xếp
   - Template class cho Report

3. **Modern C++:**
   - Smart pointers cho dynamic memory
   - Lambda expressions cho sorting/filtering
   - Auto và range-based for loops
   - Move semantics cho large objects

4. **STL Algorithms:**
   - `sort`, `find`, `find_if`, `count_if`
   - `transform`, `accumulate`
   - `remove_if`, `unique`

**Code template:**

```cpp
#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <algorithm>
#include <memory>
#include <string>
using namespace std;

class Book {
private:
    string isbn;
    string title;
    string author;
    string category;
    int year;
    bool available;
    
public:
    Book(string i, string t, string a, string c, int y)
        : isbn(i), title(t), author(a), category(c), year(y), available(true) {}
    
    // Getters
    string getISBN() const { return isbn; }
    string getTitle() const { return title; }
    string getAuthor() const { return author; }
    string getCategory() const { return category; }
    int getYear() const { return year; }
    bool isAvailable() const { return available; }
    
    // Setters
    void setAvailable(bool av) { available = av; }
    
    void display() const {
        cout << "ISBN: " << isbn << ", Title: " << title 
             << ", Author: " << author << ", Year: " << year
             << ", Available: " << (available ? "Yes" : "No") << endl;
    }
};

class Reader {
private:
    string id;
    string name;
    vector<string> borrowedBooks;  // List of ISBNs
    
public:
    Reader(string i, string n) : id(i), name(n) {}
    
    string getID() const { return id; }
    string getName() const { return name; }
    const vector<string>& getBorrowedBooks() const { return borrowedBooks; }
    
    void borrowBook(const string &isbn) {
        borrowedBooks.push_back(isbn);
    }
    
    void returnBook(const string &isbn) {
        auto it = find(borrowedBooks.begin(), borrowedBooks.end(), isbn);
        if (it != borrowedBooks.end()) {
            borrowedBooks.erase(it);
        }
    }
    
    void display() const {
        cout << "ID: " << id << ", Name: " << name 
             << ", Borrowed: " << borrowedBooks.size() << " books" << endl;
    }
};

class Library {
private:
    vector<unique_ptr<Book>> books;
    map<string, unique_ptr<Reader>> readers;
    map<string, int> borrowCount;  // ISBN -> borrow count
    
public:
    void addBook(unique_ptr<Book> book) {
        books.push_back(move(book));
    }
    
    void addReader(unique_ptr<Reader> reader) {
        readers[reader->getID()] = move(reader);
    }
    
    void displayAllBooks() const {
        cout << "\n=== ALL BOOKS ===" << endl;
        for (const auto &book : books) {
            book->display();
        }
    }
    
    void displayAllReaders() const {
        cout << "\n=== ALL READERS ===" << endl;
        for (const auto &[id, reader] : readers) {
            reader->display();
        }
    }
    
    // TODO: Implement more methods
    // - borrowBook(readerID, isbn)
    // - returnBook(readerID, isbn)
    // - searchBookByTitle(title)
    // - searchBookByAuthor(author)
    // - sortBooksByYear()
    // - getMostBorrowedBook()
    // - getTopReaders()
    // - saveToFile()
    // - loadFromFile()
};

int main() {
    Library library;
    
    // Add books
    library.addBook(make_unique<Book>("978-0134685991", "Effective Modern C++", "Scott Meyers", "Programming", 2014));
    library.addBook(make_unique<Book>("978-0201633610", "Design Patterns", "Gang of Four", "Programming", 1994));
    library.addBook(make_unique<Book>("978-0132350884", "Clean Code", "Robert Martin", "Programming", 2008));
    
    // Add readers
    library.addReader(make_unique<Reader>("R001", "Alice"));
    library.addReader(make_unique<Reader>("R002", "Bob"));
    
    library.displayAllBooks();
    library.displayAllReaders();
    
    // TODO: Implement menu system
    // 1. Add book
    // 2. Add reader
    // 3. Borrow book
    // 4. Return book
    // 5. Search books
    // 6. Display statistics
    // 7. Save to file
    // 8. Load from file
    // 0. Exit
    
    return 0;
}
```

### Yêu cầu mở rộng

1. Implement đầy đủ tất cả methods trong Library class
2. Thêm validation (không mượn quá 5 quyển, kiểm tra sách có sẵn)
3. Thêm thời hạn mượn sách (due date)
4. Thêm fine cho trả sách trễ
5. Export reports (top books, top readers) ra file
6. Implement search với multiple criteria (title AND author AND year)
7. Add book recommendations (based on borrow history)
8. Thread-safe operations (C++11 `<mutex>`)
