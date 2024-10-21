package adder_16bit_pkg;

    import uvm_pkg::*;

    `include "testbench/transaction.sv"
    `include "testbench/sequencer.sv"
    `include "testbench/sequence.sv"
    `include "testbench/scoreboard.sv"
    `include "testbench/driver.sv"
	`include "testbench/monitor.sv"
	`include "testbench/agent.sv"
    `include "testbench/environment.sv"

    `include "testbench/test.sv"

endpackage : adder_16bit_pkg