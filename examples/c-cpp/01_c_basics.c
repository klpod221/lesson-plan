// Basic C program demonstrating variables and control flow
#include <stdio.h>

void demonstrateVariables() {
    printf("=== Variables and Data Types ===\n");
    
    // Integer types
    int age = 25;
    short year = 2024;
    long population = 8000000000L;
    
    // Floating point
    float pi = 3.14f;
    double e = 2.71828;
    
    // Character
    char grade = 'A';
    
    // Boolean (using int)
    int isStudent = 1;  // true
    int isWorking = 0;  // false
    
    printf("age = %d\n", age);
    printf("year = %hd\n", year);
    printf("population = %ld\n", population);
    printf("pi = %.2f\n", pi);
    printf("e = %.5lf\n", e);
    printf("grade = %c\n", grade);
    printf("isStudent = %d\n", isStudent);
}

void demonstrateControlFlow() {
    printf("\n=== Control Flow ===\n");
    
    // If-else
    int score = 85;
    printf("Score: %d - ", score);
    if (score >= 90) {
        printf("Grade A\n");
    } else if (score >= 80) {
        printf("Grade B\n");
    } else if (score >= 70) {
        printf("Grade C\n");
    } else {
        printf("Grade F\n");
    }
    
    // Switch
    int day = 3;
    printf("Day %d: ", day);
    switch (day) {
        case 1: printf("Monday\n"); break;
        case 2: printf("Tuesday\n"); break;
        case 3: printf("Wednesday\n"); break;
        case 4: printf("Thursday\n"); break;
        case 5: printf("Friday\n"); break;
        default: printf("Weekend\n");
    }
    
    // For loop
    printf("\nFor loop: ");
    for (int i = 1; i <= 5; i++) {
        printf("%d ", i);
    }
    printf("\n");
    
    // While loop
    printf("While loop: ");
    int n = 1;
    while (n <= 5) {
        printf("%d ", n);
        n++;
    }
    printf("\n");
    
    // Do-while loop
    printf("Do-while loop: ");
    n = 1;
    do {
        printf("%d ", n);
        n++;
    } while (n <= 5);
    printf("\n");
}

int add(int a, int b) {
    return a + b;
}

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

void demonstrateFunctions() {
    printf("\n=== Functions ===\n");
    
    int sum = add(10, 20);
    printf("10 + 20 = %d\n", sum);
    
    int fact = factorial(5);
    printf("5! = %d\n", fact);
}

int main() {
    demonstrateVariables();
    demonstrateControlFlow();
    demonstrateFunctions();
    
    return 0;
}
