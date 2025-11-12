// C++ OOP basics
#include <iostream>
#include <string>
using namespace std;

class BankAccount {
private:
    string accountNumber;
    string ownerName;
    double balance;
    
public:
    // Constructor
    BankAccount(string accNum, string name, double initialBalance = 0.0) 
        : accountNumber(accNum), ownerName(name), balance(initialBalance) {
        cout << "Account created for " << ownerName << endl;
    }
    
    // Destructor
    ~BankAccount() {
        cout << "Account " << accountNumber << " closed" << endl;
    }
    
    // Getters
    string getAccountNumber() const { return accountNumber; }
    string getOwnerName() const { return ownerName; }
    double getBalance() const { return balance; }
    
    // Methods
    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            cout << "Deposited $" << amount << ". New balance: $" << balance << endl;
        } else {
            cout << "Invalid deposit amount" << endl;
        }
    }
    
    void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            cout << "Withdrew $" << amount << ". New balance: $" << balance << endl;
        } else {
            cout << "Invalid withdrawal amount or insufficient funds" << endl;
        }
    }
    
    void display() const {
        cout << "Account: " << accountNumber << ", Owner: " << ownerName 
             << ", Balance: $" << balance << endl;
    }
};

class Rectangle {
private:
    double width;
    double height;
    
public:
    Rectangle(double w, double h) : width(w), height(h) {}
    
    double area() const {
        return width * height;
    }
    
    double perimeter() const {
        return 2 * (width + height);
    }
    
    void display() const {
        cout << "Rectangle(" << width << " x " << height << ")" << endl;
        cout << "  Area: " << area() << endl;
        cout << "  Perimeter: " << perimeter() << endl;
    }
    
    // Operator overloading
    Rectangle operator+(const Rectangle &other) const {
        return Rectangle(width + other.width, height + other.height);
    }
    
    bool operator>(const Rectangle &other) const {
        return area() > other.area();
    }
};

int main() {
    cout << "=== Bank Account ===" << endl;
    
    BankAccount acc1("ACC001", "Alice", 1000.0);
    acc1.display();
    
    acc1.deposit(500);
    acc1.withdraw(200);
    acc1.display();
    
    cout << "\n=== Rectangles ===" << endl;
    
    Rectangle r1(5, 10);
    Rectangle r2(3, 8);
    
    r1.display();
    r2.display();
    
    Rectangle r3 = r1 + r2;
    cout << "\nSum of rectangles:" << endl;
    r3.display();
    
    if (r1 > r2) {
        cout << "\nRectangle 1 has larger area" << endl;
    } else {
        cout << "\nRectangle 2 has larger area" << endl;
    }
    
    return 0;
}
