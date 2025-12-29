# MIPS-Processor

This project implements a 32-bit MIPS processor from scratch, focusing on instruction-level execution, control logic, and datapath design. The processor is designed, simulated, synthesized, and implemented on an FPGA to demonstrate a complete hardware realization of a MIPS-like architecture.

🔧 Architecture

32-bit single-cycle MIPS datapath

Modular design including:

Program Counter (PC)

Instruction Memory

Register File

ALU

Control Unit

Data Memory

Sign-extension and shift units

Custom control logic to handle arithmetic, memory, branch, and jump operations

📜 Supported Instruction Types

R-Type Instructions

add, sub, and, or, slt

Register-to-register arithmetic and logic

I-Type Instructions

addi, lw, sw

beq, bne

Immediate arithmetic, memory access, and conditional branching

J-Type Instructions

j, jal

Subroutine calls and unconditional jumps

⚙️ Implementation Details

ALU operations controlled via a dedicated ALU control unit

Branch logic supports equality and inequality conditions

Jump-and-link (jal) implemented using return address ($ra)

Memory is word-aligned and byte-addressed

Instruction execution validated using MIPS assembly test programs

🧪 Verification & Testing

Functional simulation using testbenches

Verified instruction execution through waveform analysis

Tested control signals, datapath correctness, and memory access behavior

🧠 Languages & Tools

Hardware Description Language: VHDL

Simulation & Synthesis: Xilinx Vivado

Target Platform: Basys 3 FPGA (Artix-7)

Instruction Encoding: MIPS32 ISA format
