# 32-Bit RISC-V Processor Implementation

A complete hardware implementation of a 32-bit RISC-V processor in Verilog, featuring a 5-stage pipeline architecture with support for basic arithmetic, logic, memory, and branch operations.

## 📋 Project Overview

This project implements a functional RISC-V processor core that executes a subset of the RISC-V instruction set. The processor is designed to compute the sum of 4 numbers as a demonstration application.

### Key Features

- **32-bit Architecture**: Full 32-bit instruction and data path
- **RISC-V ISA Compliance**: Supports core RISC-V instruction types (I, R, S, B-type)
- **Harvard Architecture**: Separate instruction and data memory
- **Control Unit**: Intelligent instruction decoding and control signal generation
- **ALU Operations**: Support for ADD, SUB, AND, OR, XOR, SLT operations
- **Memory Operations**: Load (LW) and Store (SW) capability
- **Branch Support**: Conditional branching with BNE instruction

## 📁 Repository Structure

```
32-Bit_RISC-V/
├── README.md                 # Project documentation
├── rtl/                      # RTL (Register Transfer Level) modules
│   ├── alu.v                # Arithmetic Logic Unit
│   ├── control.v            # Control Unit & Instruction Decoder
│   ├── data_mem.v           # Data Memory Module
│   ├── imm_gen.v            # Immediate Value Generator
│   ├── instr_mem.v          # Instruction Memory
│   ├── pc.v                 # Program Counter
│   ├── reg_file.v           # Register File (32 x 32-bit)
│   ├── top.v                # Top Module - Main Processor
│   └── tb_top.v             # Testbench for Simulation
```

## 🔧 Module Descriptions

### ALU (Arithmetic Logic Unit)
Performs arithmetic and logical operations on two 32-bit operands.
- **Inputs**: Two 32-bit operands, 3-bit control signal
- **Outputs**: 32-bit result, Zero flag

### Control Unit
Decodes instructions and generates appropriate control signals.
- **Inputs**: 7-bit opcode
- **Outputs**: reg_write, alu_src, mem_write, mem_read, branch, alu_ctrl

### Data Memory
Provides read/write access to data stored in memory.
- **Capacity**: 256 x 32-bit words
- **Supports**: Load (LW) and Store (SW) operations

### Instruction Memory
Stores the program instructions to be executed.
- **Capacity**: 256 x 32-bit words
- **Pre-loaded**: Default application (sum of 4 numbers)

### Program Counter (PC)
Manages instruction address sequencing.
- **Inputs**: Clock, Reset, Next PC value
- **Outputs**: Current PC address

### Register File
32 x 32-bit register storage for operands and results.
- **Registers**: x0-x31 (x0 hardwired to 0)
- **Ports**: 2 read ports, 1 write port

### Immediate Generator
Extracts and extends immediate values from instructions.
- **Supports**: I-type, S-type, B-type immediate formats

### Top Module
Integrates all components into a complete processor.
- **Orchestrates**: PC, Instruction Fetch, Control, ALU, Memory operations

## 📚 Application: Sum of 4 Numbers

The processor executes a pre-programmed application that computes the sum of 4 numbers:

```assembly
addi x1, x0, 0      # Initialize sum register
addi x2, x0, 0      # Initialize loop counter
addi x3, x0, 4      # Set loop limit
loop:
lw   x4, 0(x1)      # Load operand
add  x1, x1, x4     # Add to sum
addi x2, x2, 1      # Increment counter
bne  x2, x3, loop   # Branch if not equal (loop condition)
sw   x1, 0(x0)      # Store result
```

## 🛠️ Supported Instructions

| Instruction | Type | Operation |
|-------------|------|-----------|
| ADDI | I | Add Immediate |
| ADD | R | Add |
| SUB | R | Subtract |
| AND | R | Bitwise AND |
| OR | R | Bitwise OR |
| XOR | R | Bitwise XOR |
| SLT | R | Set Less Than |
| LW | I | Load Word |
| SW | S | Store Word |
| BNE | B | Branch if Not Equal |

## 🚀 Getting Started

### Prerequisites
- Verilog Simulator (ModelSim, Vivado, Icarus Verilog, or similar)
- Verilog HDL knowledge

### Simulation Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Senbagaseelan18/32-Bit_RISC-V.git
   cd 32-Bit_RISC-V
   ```

2. **Compile the Verilog files** (using your simulator):
   ```bash
   # Example with Icarus Verilog
   iverilog -o sim rtl/*.v
   vvp sim
   ```

3. **Run simulation**:
   - Open your simulator with all RTL files from the `rtl/` folder
   - Run the testbench (`tb_top.v`)
   - Observe the clock cycles and verify output

## 📊 Simulation Output

After simulation, you should see:
- PC incrementing through instruction addresses
- Register values updating appropriately
- Final result stored in memory at address 0x00

## 💡 Implementation Details

### Clock and Reset
- **Clock-driven**: Synchronous design with positive edge triggering
- **Reset**: Asynchronous reset signal for all state elements

### Memory Access
- **Instruction Fetch**: Zero wait states (combinational)
- **Data Memory**: Single cycle read/write

### Instruction Execution
- **Cycle-accurate**: Each instruction executes in one clock cycle
- **Pipelined Path**: Simplified single-cycle execution model

## 📝 Notes

- All values in instruction memory are pre-loaded during initialization
- The immediate generator supports RISC-V standard immediate encoding
- Memory addresses use word-addressing (32-bit aligned)
