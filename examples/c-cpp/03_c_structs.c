// Structs and file I/O in C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    char name[50];
    float gpa;
} Student;

void displayStudent(const Student *s) {
    printf("ID: %d, Name: %s, GPA: %.2f\n", s->id, s->name, s->gpa);
}

void demonstrateStructs() {
    printf("=== Structs ===\n");
    
    // Create struct
    Student s1 = {1, "Alice", 3.8};
    Student s2;
    s2.id = 2;
    strcpy(s2.name, "Bob");
    s2.gpa = 3.5;
    
    displayStudent(&s1);
    displayStudent(&s2);
    
    // Array of structs
    Student students[3] = {
        {1, "Alice", 3.8},
        {2, "Bob", 3.5},
        {3, "Charlie", 3.9}
    };
    
    printf("\nAll students:\n");
    for (int i = 0; i < 3; i++) {
        displayStudent(&students[i]);
    }
}

void demonstrateFileIO() {
    printf("\n=== File I/O ===\n");
    
    // Write to text file
    FILE *fp = fopen("students.txt", "w");
    if (fp == NULL) {
        printf("Error opening file\n");
        return;
    }
    
    fprintf(fp, "1,Alice,3.8\n");
    fprintf(fp, "2,Bob,3.5\n");
    fprintf(fp, "3,Charlie,3.9\n");
    fclose(fp);
    
    printf("Written to students.txt\n");
    
    // Read from text file
    fp = fopen("students.txt", "r");
    if (fp == NULL) {
        printf("Error opening file\n");
        return;
    }
    
    printf("\nReading from students.txt:\n");
    Student s;
    while (fscanf(fp, "%d,%49[^,],%f\n", &s.id, s.name, &s.gpa) == 3) {
        displayStudent(&s);
    }
    fclose(fp);
}

void demonstrateBinaryIO() {
    printf("\n=== Binary File I/O ===\n");
    
    Student students[3] = {
        {1, "Alice", 3.8},
        {2, "Bob", 3.5},
        {3, "Charlie", 3.9}
    };
    
    // Write binary
    FILE *fp = fopen("students.bin", "wb");
    if (fp == NULL) {
        printf("Error opening file\n");
        return;
    }
    
    fwrite(students, sizeof(Student), 3, fp);
    fclose(fp);
    
    printf("Written to students.bin\n");
    
    // Read binary
    fp = fopen("students.bin", "rb");
    if (fp == NULL) {
        printf("Error opening file\n");
        return;
    }
    
    printf("\nReading from students.bin:\n");
    Student readStudents[3];
    fread(readStudents, sizeof(Student), 3, fp);
    fclose(fp);
    
    for (int i = 0; i < 3; i++) {
        displayStudent(&readStudents[i]);
    }
}

int main() {
    demonstrateStructs();
    demonstrateFileIO();
    demonstrateBinaryIO();
    
    return 0;
}
