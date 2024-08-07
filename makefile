# Compiler and simulation command
IVERILOG = iverilog
VVP = vvp

# Directories
SRC_DIR = src/modules
TEST_DIR = src/tests

# Source files
SRC_FILES = $(wildcard $(SRC_DIR)/*.v)

# List of modules and testbenches
MODULES = ALU ControlUnit DataPath InstructionFetch RegisterFile Mux

# Output files
OUTPUTS = $(addprefix tb, $(MODULES))
OUTPUT_FILES = $(addsuffix .out, $(OUTPUTS))

# Default target: list all available targets
.PHONY: all
all:
	@echo "Available targets:"
	@$(foreach module, $(MODULES), echo "  make tb$(module)";)

# Rule to compile and run each testbench
$(OUTPUT_FILES): tb%.out: $(TEST_DIR)/tb%.v $(SRC_FILES)
	$(IVERILOG) -o $@ -I $(SRC_DIR) $^
	$(VVP) $@

# Create targets for each testbench
.PHONY: $(addprefix tb, $(MODULES))
$(foreach module, $(MODULES), $(eval tb$(module): tb$(module).out))

# Clean up generated files
.PHONY: clean
clean:
	rm -f *.out
