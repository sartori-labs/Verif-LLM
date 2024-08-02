# Verif-LLM
An open-source benchmark for generating Verification Suites using UVM with natural language

The Directory Tree is as shown below

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

#### 1. Getting Started

1. Add Verdi Python Libraries to Path

    `export LD_LIBRARY_PATH=“$VERDI_HOME/platform/linux64/bin:$LD_LIBRARY_PATH"`
    
2. Navigate to a design of choice, and make sure the directory contains a `config.yaml` script. If this is absent, follow the convention shown below to 

    ```
    module_name:
        name: module_name
        required: True/False
        active: True/False
    ```

3. Then run  `make`

    This will invoke the default make directive to generate a stub code using Python Abstraction which can be found under `scripts/` folder.

#### 2. To-Do(s)

* Wrapper for DUT
* TB Top
* File List for Compilation
* VCS Compilation out of the Box
