FIFO Verification using SystemVerilog
Overview

This project verifies a synchronous FIFO using a SystemVerilog class-based testbench. The verification environment generates random write and read operations, checks the FIFO output using a reference model, and reports whether each transaction passes or fails. Functional coverage is also added to check whether important FIFO scenarios are exercised.

Files:

- fifo.sv : FIFO RTL
- interface.sv : Interface with clocking blocks
- transaction.sv : Transaction class
- generator.sv : Generates random transactions
- driver.sv : Drives inputs to the FIFO
- wr_monitor.sv : Monitors write operations
- rd_monitor.sv : Monitors read operations
- reference_model.sv : Predicts expected FIFO output
- scoreboard.sv : Compares expected and actual data
- environment.sv : Connects all verification components
- tb_top.sv : Top-level testbench


Verification Flow:

- Generator creates random write and read transactions.
- Driver applies these transactions to the FIFO.
- Write monitor observes successful writes.
- Read monitor observes successful reads.
- Reference model stores write data and predicts the expected read data.
- Scoreboard compares the expected output with the actual FIFO out


Verification Checks:

- Reset functionality
- Write operation
- Read operation
- FIFO Full condition
- FIFO Empty condition
- Simultaneous write/read prevention

Expected Output:

RESET DEASSERTED

PASS : Expected=129 Actual=129
PASS : Expected=238 Actual=238
PASS : Expected=5 Actual=5
...

==================================
---------FIFO SCOREBOARD----------
Total Transactions : 30
Passed             : 30
Failed             : 0
==================================

Result:
The testbench automatically generates random transactions, verifies FIFO behaviour using a reference model, reports pass/fail results through the scoreboard, and collects functional coverage for important FIFO scenarios.