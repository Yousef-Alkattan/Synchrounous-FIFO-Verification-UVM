# Synchrounous-FIFO-Verification-UVM

This repository contains the complete UVM testbench and design files for verifying a FIFO (First-In-First-Out) module. Below is a breakdown of each file and its role in the testbench architecture.

---

## 🔷 Introduction

This project presents a **Universal Verification Methodology (UVM)**-based testbench for verifying a **synchronous FIFO (First-In, First-Out)** buffer.  
FIFO is a critical component in digital systems, acting as a temporary storage queue that manages data transfer between modules operating on different clock domains or execution rates.

Our design features multiple control and status signals such as `full`, `almostfull`, `empty`, `almostempty`, `overflow`, and `underflow`, ensuring safe and efficient data communication.

The verification framework rigorously tests these features using structured UVM components like sequences, agents, drivers, monitors, and scoreboards to provide **comprehensive functional coverage**.

---

## FIFO Input/Output Ports

| **Port**       | **Direction** | **Description**                                                                 |
|----------------|---------------|---------------------------------------------------------------------------------|
| `clk`          | Input         | Clock signal for synchronous operations                                        |
| `rst_n`        | Input         | Active-low asynchronous reset                                                  |
| `data_in`      | Input         | Input data to be written into the FIFO                                         |
| `wr_en`        | Input         | Write enable — data is written when high and FIFO is not full                 |
| `rd_en`        | Input         | Read enable — data is read when high and FIFO is not empty                    |
| `data_out`     | Output        | Data read from the FIFO                                                        |
| `full`         | Output        | Indicates FIFO is full — prevents further writes                               |
| `almostfull`   | Output        | Indicates FIFO is almost full — one write away from being full                 |
| `empty`        | Output        | Indicates FIFO is empty — prevents further reads                               |
| `almostempty`  | Output        | Indicates FIFO is almost empty — one read away from being empty                |
| `overflow`     | Output        | Signals an overflow event — write attempted when FIFO is full                  |
| `underflow`    | Output        | Signals an underflow event — read attempted when FIFO is empty                 |
| `wr_ack`       | Output        | Acknowledges that the write was successful                                     |

---

## 📁 File Descriptions

### 1. Project Reports

- `Yousef_Alkattan_Project2_sv7....`:  
  Includes all codes & Simulation Waveforms

---

### 2. RTL & Test Top

- `FIFO.sv`:  
  The RTL design of the FIFO module under test & also includes Assertions.

- `FIFO2_top.sv`:  
  Top-level testbench module that instantiates the DUT, interface, and connects the UVM environment.

---

### 3. UVM Testbench Files

#### 🧱 Testbench Components

- `fifo_interface.sv`:  
  Defines the interface between the testbench and DUT including signals like clk, rst, wr_en, etc.

- `fifo_agent.sv`:  
  Contains the UVM agent, which includes driver, monitor, and sequencer for the FIFO.

- `fifo_driver.sv`:  
  Drives stimulus to the DUT based on transaction items received from the sequencer.

- `fifo_monitor.sv`:  
  Observes DUT signals and collects information into transactions for coverage and checking.

- `fifo_scoreboard.sv`:  
  Implements the self-checking mechanism by comparing expected vs actual FIFO behavior.

- `fifo_config.sv`:  
  Configuration class used to share parameters or handles across components.

- `fifo_env.sv`:  
  The UVM environment that instantiates and connects agents and scoreboard.

- `fifo_test.sv`:  
  Top-level UVM test class that configures and starts the test.

- `FIFO_coverage.sv`:  
  Includes functional coverage groups to measure test completeness. 

#### Sequences

- `fifo_sequence_item.sv`:  
  Defines the transaction type (data packet) for FIFO operations.

- `fifo_sequence.sv`:  
  Contains the main sequence that generates stimulus (read/write commands).

- `fifo_reset_sequence.sv`:  
  Special sequence used to reset the FIFO in simulation before stimulus begins.

- `fifo_sequencer.sv`:  
  UVM sequencer responsible for controlling the flow of transaction items.


---

### 4. Do file & List of files

- `doffio2.do`:  
  ModelSim/Questa `.do` script for compiling and running the simulation.

- `fifo2_files.list`:  
  File list used for compiling all SystemVerilog files in the correct order.

---

## 🛠 Tools

- Language: SystemVerilog
- Methodology: UVM (Universal Verification Methodology)
- Simulator: Questasim / ModelSim

---

## Conclusion

The UVM-based verification environment for the FIFO buffer has proven successful in ensuring **design correctness, protocol compliance, and data integrity** across a wide range of functional scenarios.  
This includes edge cases like simultaneous read/write operations, resets during transactions, and overflow/underflow events.

Through the use of **SystemVerilog Assertions**, **Golden reference models**, and **UVM sequences**, we’ve implemented a reusable and scalable testbench that achieves high confidence in the FIFO's reliability for integration into larger digital systems.

This project reflects best practices in functional verification and demonstrates the value of **automated, structured verification methodologies** like UVM in modern digital design flows.

