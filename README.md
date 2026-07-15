# UVM_Based_Verification_of_AMBA_AHB_Protocol_with_Highest_coverage

## Description

This repository contains a UVM-based verification environment for the AMBA Advanced High-performance Bus (AHB) protocol developed using SystemVerilog. The project verifies the functional correctness of AHB read and write transactions through constrained-random stimulus generation, protocol monitoring, scoreboard-based checking, and functional coverage collection. The verification environment is modular, reusable, and designed to validate different transfer sizes, burst types, and address transactions using industry-standard UVM methodology.

---

## Verification Flow

```text
                +----------------------+
                |      UVM Test        |
                +----------+-----------+
                           |
                           ▼
                  Random Sequence
                           |
                           ▼
                     UVM Sequencer
                           |
                           ▼
                       UVM Driver
                           |
                           ▼
                   AMBA AHB Interface
                           |
                           ▼
                    AHB Slave (DUT)
                           |
                           ▼
                      UVM Monitor
                 ┌─────────┴─────────┐
                 ▼                   ▼
         UVM Scoreboard      Functional Coverage
                 │                   │
                 └─────────┬─────────┘
                           ▼
                 Verification Results
```

---

## Files

- `rtl/ahb_if.sv` – AMBA AHB interface containing bus signals and modports.
- `rtl/ahb_slave.sv` – AHB Slave DUT implementing read and write operations.
- `uvm_tb/ahb_transaction.sv` – Transaction class defining randomized AHB transactions.
- `uvm_tb/ahb_sequence.sv` – Generates constrained-random AHB transactions.
- `uvm_tb/ahb_sequencer.sv` – Controls the flow of transactions from sequence to driver.
- `uvm_tb/ahb_driver.sv` – Drives AHB transactions onto the interface.
- `uvm_tb/ahb_monitor.sv` – Captures bus activity and forwards transactions.
- `uvm_tb/ahb_scoreboard.sv` – Compares DUT responses with the reference model.
- `uvm_tb/ahb_coverage.sv` – Collects functional coverage metrics.
- `uvm_tb/ahb_agent.sv` – Encapsulates driver, monitor, and sequencer.
- `uvm_tb/ahb_env.sv` – Builds and connects the complete verification environment.
- `uvm_tb/ahb_test.sv` – Executes the verification test and sequences.
- `uvm_tb/ahb_pkg.sv` – Includes all UVM verification components.
- `sim/ahb_top.sv` – Top-level simulation module.

---

## Features

- UVM-based reusable verification environment
- Constrained-random transaction generation
- Read and write transaction verification
- Functional coverage collection
- Scoreboard-based data validation
- Support for Byte, Half-word, and Word transfers
- Support for Single and INCR4 burst transfers
- Protocol monitoring and waveform analysis

---

## Tools Used

- QuestaSim
- Universal Verification Methodology (UVM)
- EDA Playground

---
