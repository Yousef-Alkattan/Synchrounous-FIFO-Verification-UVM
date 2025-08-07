# Synchrounous-FIFO-Verification-UVM

This repository contains the complete UVM testbench and design files for verifying a FIFO (First-In-First-Out) module. Below is a breakdown of each file and its role in the testbench architecture.

---

## 📁 File Descriptions

### 1. Project Reports

- `Yousef_Alkattan_Project2_sv7....`:  
  Likely a backup or exported version of the project or design. Consider renaming or organizing.


---

### 2. RTL & Test Top

- `FIFO.sv`:  
  The RTL design of the FIFO module under test.

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

#### Sequences

- `fifo_sequence_item.sv`:  
  Defines the transaction type (data packet) for FIFO operations.

- `fifo_sequence.sv`:  
  Contains the main sequence that generates stimulus (read/write commands).

- `fifo_reset_sequence.sv`:  
  Special sequence used to reset the FIFO in simulation before stimulus begins.

- `fifo_sequencer.sv`:  
  UVM sequencer responsible for controlling the flow of transaction items.

- `FIFO_coverage.sv`:  
  Includes functional coverage groups to measure test completeness.

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

## ✅ Summary

This project demonstrates a complete UVM testbench flow for verifying a FIFO design, including modular components, coverage collection, and simulation scripting.

