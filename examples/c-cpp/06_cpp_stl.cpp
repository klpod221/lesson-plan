// C++ STL examples
#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <algorithm>
#include <numeric>
#include <memory>
using namespace std;

void demonstrateVector() {
    cout << "=== Vector ===" << endl;
    
    vector<int> vec = {5, 2, 8, 1, 9};
    
    // Add elements
    vec.push_back(3);
    vec.push_back(7);
    
    cout << "Vector: ";
    for (int val : vec) {
        cout << val << " ";
    }
    cout << endl;
    
    // Sort
    sort(vec.begin(), vec.end());
    cout << "Sorted: ";
    for (int val : vec) {
        cout << val << " ";
    }
    cout << endl;
    
    // Find
    auto it = find(vec.begin(), vec.end(), 8);
    if (it != vec.end()) {
        cout << "Found 8 at position: " << distance(vec.begin(), it) << endl;
    }
    
    // Lambda with algorithms
    int count = count_if(vec.begin(), vec.end(), [](int x) { return x > 5; });
    cout << "Elements > 5: " << count << endl;
    
    // Transform
    vector<int> squared;
    transform(vec.begin(), vec.end(), back_inserter(squared), 
              [](int x) { return x * x; });
    
    cout << "Squared: ";
    for (int val : squared) {
        cout << val << " ";
    }
    cout << endl;
}

void demonstrateMap() {
    cout << "\n=== Map ===" << endl;
    
    map<string, int> ages;
    ages["Alice"] = 25;
    ages["Bob"] = 30;
    ages["Charlie"] = 28;
    
    cout << "Ages:" << endl;
    for (const auto &[name, age] : ages) {
        cout << "  " << name << ": " << age << endl;
    }
    
    // Check if key exists
    if (ages.find("Alice") != ages.end()) {
        cout << "Alice's age: " << ages["Alice"] << endl;
    }
}

void demonstrateSet() {
    cout << "\n=== Set ===" << endl;
    
    set<int> mySet = {5, 2, 8, 1, 9, 2, 5};  // Duplicates ignored
    
    cout << "Set: ";
    for (int val : mySet) {
        cout << val << " ";
    }
    cout << endl;
    
    mySet.insert(3);
    mySet.insert(7);
    
    cout << "After insert: ";
    for (int val : mySet) {
        cout << val << " ";
    }
    cout << endl;
}

template <typename T>
T getMax(T a, T b) {
    return (a > b) ? a : b;
}

template <typename T>
class Box {
private:
    T value;
    
public:
    Box(T v) : value(v) {}
    
    T getValue() const { return value; }
    void setValue(T v) { value = v; }
    
    void display() const {
        cout << "Box contains: " << value << endl;
    }
};

void demonstrateTemplates() {
    cout << "\n=== Templates ===" << endl;
    
    cout << "Max of 10 and 20: " << getMax(10, 20) << endl;
    cout << "Max of 3.14 and 2.71: " << getMax(3.14, 2.71) << endl;
    
    Box<int> intBox(42);
    Box<string> stringBox("Hello");
    
    intBox.display();
    stringBox.display();
}

void demonstrateSmartPointers() {
    cout << "\n=== Smart Pointers ===" << endl;
    
    // unique_ptr
    unique_ptr<int> ptr1 = make_unique<int>(42);
    cout << "unique_ptr value: " << *ptr1 << endl;
    
    // shared_ptr
    shared_ptr<int> ptr2 = make_shared<int>(100);
    shared_ptr<int> ptr3 = ptr2;  // Both point to same object
    
    cout << "shared_ptr value: " << *ptr2 << endl;
    cout << "Reference count: " << ptr2.use_count() << endl;
}

int main() {
    demonstrateVector();
    demonstrateMap();
    demonstrateSet();
    demonstrateTemplates();
    demonstrateSmartPointers();
    
    return 0;
}
