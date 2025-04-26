`include "uvm_macros.svh"

// adder_8bit_pkg.sv
package adder_8bit_pkg;

  import uvm_pkg::*;
  
  `include "tb/transaction.sv"
  `include "tb/sequence.sv"
  `include "tb/sequencer.sv"
  `include "tb/driver.sv"
  `include "tb/monitor.sv"
  `include "tb/agent.sv"
  `include "tb/scoreboard.sv"
  `include "tb/environment.sv"
  `include "tb/test.sv"

endpackage