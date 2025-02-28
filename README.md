# FPGA UART Implementation

A complete UART (Universal Asynchronous Receiver/Transmitter) implementation for FPGAs, written in Verilog HDL. This project includes transmitter and receiver modules, baud rate generation, and test infrastructure for both simulation and hardware validation.

## Overview

This repository contains a full-featured UART implementation targeting FPGA devices. The design supports:
- Configurable baud rate generation
- Standard UART protocol (8N1 - 8 data bits, no parity, 1 stop bit)
- 16x oversampling for reliable data reception
- Clean and modular design architecture

## Repository Structure

```
├── rtl/                     # RTL source files
│   ├── baud_rate_generator.v  # Baud rate generation module
│   ├── uart_receiver.v        # UART receiver module
│   ├── uart_transmitter.v     # UART transmitter module
│   └── uart_top.v             # Top-level module
├── sim/                     # Simulation files
│   └── uart_tb.v              # Testbench for UART verification
├── constraints/             # FPGA constraints
│   └── uart_constraints.xdc   # Xilinx Design Constraints file
└── README.md                # This file
```

## Features

- **Baud Rate Generator**: Generates precise timing signals for UART communication
- **UART Transmitter**: Serializes 8-bit data with proper framing
- **UART Receiver**: Deserializes incoming serial data with robust noise tolerance
- **Complete Testbench**: Verifies functionality through simulation
- **Physical Interface**: Includes constraints for real hardware testing
- **Terminal Testing**: Compatible with standard terminal applications (Tera Term, PuTTY)

## Parameters and Customization

The implementation allows for easy customization through parameters:

| Parameter    | Description                              | Default    |
|--------------|------------------------------------------|------------|
| CLOCK_FREQ   | Input clock frequency in Hz              | 100000000  |
| BAUD_RATE    | Communication speed in bits per second   | 9600       |

## Getting Started

### Prerequisites
- Xilinx Vivado Design Suite
- FPGA development board
- USB-to-UART bridge (for hardware testing)
- Terminal application (Tera Term or PuTTY)

### Simulation

1. Clone this repository
2. Open Vivado and create a new project
3. Add the RTL and simulation source files
4. Run behavioral simulation
5. Observe transmission and reception in the waveform viewer

### Hardware Implementation

1. Add the constraints file to your project
2. Modify pin assignments in the XDC file to match your FPGA board
3. Run synthesis and implementation
4. Generate bitstream and program your device
5. Connect USB-to-UART bridge to the designated pins
6. Configure your terminal application:
   - Select appropriate COM port
   - Set baud rate (default: 9600)
   - Configure 8 data bits, no parity, 1 stop bit (8N1)
   - Disable flow control

## Testing

### Using the Testbench
The testbench (`uart_tb.v`) implements a loopback test where:
- A test pattern is transmitted
- The transmitted signal is fed back to the receiver
- The received data is compared with the original pattern

### Hardware Testing with Terminal
1. Set data using on-board switches (tx_data[7:0])
2. Press the transmit button (tx_start)
3. Observe the transmitted character in your terminal
4. Send characters from the terminal
5. Observe received data on the FPGA's LEDs (rx_data[7:0])

## Theory of Operation

### Baud Rate Generation
The baud rate generator divides the input clock to create timing ticks at 16 times the desired baud rate, enabling the receiver to sample in the middle of each bit.

### UART Protocol
Standard UART frames consist of:
1. Idle line (high)
2. Start bit (low)
3. 8 data bits (LSB first)
4. Stop bit (high)

### State Machines
Both transmitter and receiver implement state machines to handle the UART protocol:
- IDLE: Waiting for activity
- START: Processing start bit
- DATA: Handling data bits
- STOP: Processing stop bit
