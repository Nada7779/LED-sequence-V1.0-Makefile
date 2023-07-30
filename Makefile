# Compiler
CC = avr-gcc

# Directories
SRC_DIR = src
INC_DIR = inc
BUILD_DIR = build
BIN_DIR = bin

# Source files
SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
# Object files
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRC_FILES))

# Target name
TARGET = $(BIN_DIR)/main.elf

# Compiler flags
CFLAGS = -mmcu=atmega32 -Wall -Wextra 

all: $(TARGET)

# Link object files into binary executable
$(TARGET): $(OBJ_FILES)
	@mkdir -p $(BIN_DIR)
	$(CC) $^ -o $@

# Compile source files into object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) -c $< -o $@ $(CFLAGS)

# Flash target to program MCU using avrdude
flash:
	avrdude -p atmega32 -c usbasp -U flash:w:$(TARGET)

# Clean target to remove generated files and directories
clean:
	rm -rf $(BUILD_DIR)/* $(BIN_DIR)/*

.PHONY: all clean flash





