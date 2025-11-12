// Pointers and arrays in C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void demonstratePointers() {
    printf("=== Pointers ===\n");
    
    int x = 10;
    int *ptr = &x;
    
    printf("x = %d\n", x);
    printf("Address of x = %p\n", (void*)&x);
    printf("ptr = %p\n", (void*)ptr);
    printf("*ptr = %d\n", *ptr);
    
    // Modify through pointer
    *ptr = 20;
    printf("After *ptr = 20, x = %d\n", x);
    
    // Pointer arithmetic
    int arr[] = {1, 2, 3, 4, 5};
    int *p = arr;
    
    printf("\nPointer arithmetic:\n");
    for (int i = 0; i < 5; i++) {
        printf("arr[%d] = %d, *(p+%d) = %d\n", i, arr[i], i, *(p + i));
    }
}

void demonstrateArrays() {
    printf("\n=== Arrays ===\n");
    
    int numbers[5] = {1, 2, 3, 4, 5};
    
    printf("Array elements: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", numbers[i]);
    }
    printf("\n");
    
    // 2D array
    int matrix[3][3] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };
    
    printf("\nMatrix:\n");
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
    
    // Character array (string)
    char name[] = "Alice";
    printf("\nName: %s\n", name);
    printf("Length: %lu\n", strlen(name));
}

void demonstrateDynamicMemory() {
    printf("\n=== Dynamic Memory ===\n");
    
    // Allocate single integer
    int *ptr = (int*)malloc(sizeof(int));
    if (ptr == NULL) {
        printf("Memory allocation failed\n");
        return;
    }
    
    *ptr = 42;
    printf("Value: %d\n", *ptr);
    free(ptr);
    
    // Allocate array
    int size = 5;
    int *arr = (int*)malloc(size * sizeof(int));
    if (arr == NULL) {
        printf("Memory allocation failed\n");
        return;
    }
    
    for (int i = 0; i < size; i++) {
        arr[i] = i * 10;
    }
    
    printf("Dynamic array: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    
    // Reallocate
    size = 10;
    arr = (int*)realloc(arr, size * sizeof(int));
    
    for (int i = 5; i < size; i++) {
        arr[i] = i * 10;
    }
    
    printf("After realloc: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    
    free(arr);
}

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void demonstratePassByPointer() {
    printf("\n=== Pass by Pointer ===\n");
    
    int x = 10, y = 20;
    printf("Before swap: x = %d, y = %d\n", x, y);
    swap(&x, &y);
    printf("After swap: x = %d, y = %d\n", x, y);
}

int main() {
    demonstratePointers();
    demonstrateArrays();
    demonstrateDynamicMemory();
    demonstratePassByPointer();
    
    return 0;
}
