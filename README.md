# Verif-LLM: Open-Source Benchmark for Generating UVM Verification Suites Using Natural Language

## Introduction
Verif-LLM is a framework designed to streamline the generation of verification environments for digital designs using UVM (Universal Verification Methodology). It leverages natural language and AI-based large language models (LLMs) for automated testbench generation and verification suite creation. The project is flexible enough to support multiple language models, and it simplifies the setup, simulation, and analysis processes for hardware designs.

## Table of Contents

1. [Introduction](#introduction)
2. [Directory Structure](#directory-structure)
3. [Getting Started](#getting-started)
    1. [Step 1: Initial Setup (Optional)](#step-1-initial-setup-optional)
        1. [Add Verdi Python Libraries to Path](#add-verdi-python-libraries-to-path)
        2. [Configure the Design](#configure-the-design)
        3. [Build the Design](#build-the-design)
    2. [Step 2: Build and Simulate](#step-2-build-and-simulate)
        1. [Define Variables](#define-variables)
        2. [Makefile Directives](#makefile-directives)
            1. [Build the VCS Simulation](#build-the-vcs-simulation-vcs)
            2. [Run the Simulation](#run-the-simulation-sim)
            3. [Generate Coverage Report](#generate-coverage-report-coverage_report)
            4. [Generate Coverage Summary](#generate-coverage-summary-coverage_summary)
4. [Step-by-Step Example](#step-by-step-example)
5. [Additional Notes](#additional-notes)
6. [Future Improvements](#future-improvements)

The Directory Tree is as shown below
```
Verif-LLM
├── designs
│   ├── accu
│   │   ├── config.yaml
│   │   ├── dut
│   │   │   ├── accu.v
│   │   │   └── design_description.txt
│   │   └── makefile
│   ├── adder_16bit
│   │   ├── config.yaml
│   │   ├── dut
│   │   │   ├── adder_16bit.v
│   │   │   └── design_description.txt
│   │   └── makefile
.
.
.
.
.

├── README.md
└── scripts
    ├── generate_interface.py
    ├── generate_package.py
    ├── run_main.py
    ├── uvm_agent.py
    ├── uvm_driver.py
    ├── uvm_environment.py
    ├── uvm_monitor.py
    ├── uvm_scoreboard.py
    ├── uvm_sequence.py
    ├── uvm_sequencer.py
    ├── uvm_test.py
    └── uvm_transaction.py
```

## Getting Started

#### 1. Init (can skip)
1. **Add Verdi Python Libraries to Path**:

    - Ensure that your environment is set up to include the Verdi library for waveform viewing and debugging.

    `export LD_LIBRARY_PATH=“$VERDI_HOME/platform/linux64/bin:$LD_LIBRARY_PATH"`
    
2. **Configure the Design**:

    - Navigate to the desired design directory. Ensure that it contains a config.yaml file, which defines key parameters for the design.
    - If config.yaml is missing, create it following this format:
    
    ```
    module_name:
        name: module_name
        required: True/False
        active: True/False
    ```

3. **Build the Design**:

    - Run the default make directive to build the testbench using Python abstraction. The build script generates UVM components under the scripts/ directory.

    `make build`

#### 2. Build

###### (DEFAULT)

You can build and simulate the default Human-written UVM testbench by running the make command.

```
make vcs
```

###### Variables

You can pass the following variables directly as part of the `make` command:

- **LLM**: The language model used for testing. The valid values are:
  - `_chatgpt4o`
  - `_starcoder`
  - `_llama3`  
- **TRIAL**: Specifies the trial number for the testbench.

---

###### Make Directives

1. `vcs`

**Description:**
This directive is used to build the VCS simulation. It compiles the Verilog/SystemVerilog design files, the UVM library files, and the testbench files, and prepares the simulation executable. It also applies code coverage and debugging options for detailed analysis.

**Command**:
```
make vcs LLM=<value> TRIAL=<value>
```
---

2. `sim`

**Description**:
This directive runs the compiled VCS simulation. It executes the `simv` binary created by the `vcs` directive and logs the results.

**Command**:
```
make sim 
```
---

3. `coverage_report`

**Description**:
Generates a detailed coverage report for the executed simulation. This uses Synopsys VCS's \`urg\` tool to generate coverage reports from the simulation database.

**Command**:
```
make coverage_report
```
---

4. `coverage_summary`

**Description**:
Extracts a summary of coverage metrics such as Toggle, Cond, Line, FSM, Branch, Assert, and CoverGroup from the coverage report.

**Command**:
```
make coverage_summary
```
---
#### Usage Example

Here’s a step-by-step example on how to run the simulation and generate a coverage report:

1. **Build the VCS simulation:**
   ```
   make vcs LLM=_chatgpt4o TRIAL=1
   ```

2. **Run the simulation, Generate Coverage Reports and Summary:**
   ```
   make sim coverage_report coverage_summary
   ```


#### Notes

- Ensure that you have VCS and UVM installed and properly set up in your environment.
- The `INCLUDE_PATH` is dynamically set based on the values of `LLM` and `TRIAL`. Verify that the correct testbench paths are in place before running the simulation.
- Use the `compile.log` and `run.log` files for debugging if the compilation or simulation fails.



#### To-Do(s)

* Wrapper for DUT
* TB Top
* File List for Compilation
* VCS Compilation out of the Box
