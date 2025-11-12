# Makefile for C/C++ examples

CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -std=c11
CXXFLAGS = -Wall -Wextra -std=c++17

# C targets
C_SOURCES = 01_c_basics.c 02_c_pointers.c 03_c_structs.c
C_TARGETS = $(C_SOURCES:.c=)

# C++ targets
CXX_SOURCES = 04_cpp_oop.cpp 05_cpp_polymorphism.cpp 06_cpp_stl.cpp
CXX_TARGETS = $(CXX_SOURCES:.cpp=)

.PHONY: all clean c cpp

all: c cpp

c: $(C_TARGETS)

cpp: $(CXX_TARGETS)

# Compile C programs
%: %.c
	$(CC) $(CFLAGS) $< -o $@

# Compile C++ programs
%: %.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

clean:
	rm -f $(C_TARGETS) $(CXX_TARGETS)
	rm -f *.txt *.bin
	@echo "Cleaned all executables and generated files"

run-c: c
	@echo "Running C examples..."
	@./01_c_basics
	@echo ""
	@./02_c_pointers
	@echo ""
	@./03_c_structs

run-cpp: cpp
	@echo "Running C++ examples..."
	@./04_cpp_oop
	@echo ""
	@./05_cpp_polymorphism
	@echo ""
	@./06_cpp_stl

run: run-c run-cpp
