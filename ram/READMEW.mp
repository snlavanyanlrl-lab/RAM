# 16×8 Synchronous RAM in Verilog

## Overview

This project implements a **16×8 Random Access Memory (RAM)** using Verilog HDL.

The RAM contains **16 memory locations**, with each location storing **8 bits** of data. A **4-bit address** is used to select one of the 16 locations.

The design supports:

* Synchronous write
* Synchronous read
* 16 memory locations
* 8-bit data width
* 4-bit address width
* Verilog testbench
* Waveform generation for simulation

## RAM Specifications

| Parameter       | Value        |
| --------------- | ------------ |
| Memory depth    | 16 locations |
| Data width      | 8 bits       |
| Address width   | 4 bits       |
| Read operation  | Synchronous  |
| Write operation | Synchronous  |
| HDL             | Verilog      |

### Memory Organization

```text
Address       Data
0000          8 bits
0001          8 bits
0010          8 bits
0011          8 bits
...           ...
1110          8 bits
1111          8 bits
```

Since there are 16 locations:

```text
2^4 = 16
```

Therefore, a 4-bit address is required.

## Repository Structure

```text
verilog-ram-16x8/
│
├── README.md
│
├── rtl/
│   └── ram_16x8.v
│
├── tb/
│   └── ram_16x8_tb.v
│
├── sim/
│   └── README.md
│
└── .gitignore
```

## RAM Interface

| Signal | Width | Description    |
| ------ | ----: | -------------- |
| `clk`  |     1 | Clock          |
| `we`   |     1 | Write enable   |
| `addr` |     4 | Memory address |
| `din`  |     8 | Input data     |
| `dout` |     8 | Output data    |

## Operation

### Write

When `we` is high, data is written into the selected memory location on the rising edge of the clock.

```text
we = 1
addr = selected address
din = data to store
```

For example:

```text
addr = 3
din  = 0x55
we   = 1
```

At the rising edge of `clk`, `0x55` is stored at address 3.

### Read

The RAM uses a **synchronous read**.

The selected address is sampled on the rising edge of the clock, and the corresponding memory data is assigned to `dout`.

```text
addr = selected address
we   = 0
```

The read data appears after the clock edge.

## Simulation

The project can be simulated using tools such as:

* Icarus Verilog
* GTKWave
* ModelSim
* QuestaSim

### Using Icarus Verilog

Compile the design and testbench:

```bash
iverilog -o ram_sim rtl/ram_16x8.v tb/ram_16x8_tb.v
```

Run the simulation:

```bash
vvp ram_sim
```

The testbench generates a waveform file:

```text
ram_16x8.vcd
```

### View the Waveform

If GTKWave is installed:

```bash
gtkwave ram_16x8.vcd
```

You can observe:

```text
clk
we
addr
din
dout
```

in the waveform viewer.

## Expected Simulation Output

The testbench writes the following values:

| Address | Data Written |
| ------: | -----------: |
|       0 |         `A5` |
|       1 |         `3C` |
|       2 |         `F0` |
|       3 |         `55` |

The read operation should produce the corresponding stored values.

Example:

```text
Address =  0, Data = a5
Address =  1, Data = 3c
Address =  2, Data = f0
Address =  3, Data = 55
```

## How the Design Works

The memory is declared as:

```verilog
reg [7:0] mem [0:15];
```

This creates:

```text
16 locations × 8 bits
```

The main sequential block is:

```verilog
always @(posedge clk)
```

Therefore, RAM operations occur on the rising edge of the clock.

The write operation is:

```verilog
if (we)
    mem[addr] <= din;
```

The synchronous read operation is:

```verilog
dout <= mem[addr];
```

## Learning Objectives

This project demonstrates:

1. Verilog memory declaration
2. Address decoding through an array index
3. Synchronous RAM design
4. Clocked read/write operations
5. Verilog testbench development
6. Waveform generation
7. RTL simulation

## Future Improvements

Possible extensions include:

* Adding a reset mechanism
* Creating a dual-port RAM
* Adding byte-enable signals
* Parameterizing memory depth and data width
* Adding assertions to the testbench
* Creating automated simulation scripts
* Synthesizing the RAM for an FPGA

## Author

**Verilog RAM Project**

A simple RTL implementation of a 16×8 synchronous RAM for learning and FPGA/ASIC design fundamentals.
