// accu_sequencer.sv
`ifndef ACCU_SEQUENCER_SV
`define ACCU_SEQUENCER_SV

class accu_sequencer extends uvm_sequencer#(accu_trans);
  `uvm_component_utils(accu_sequencer)

  function new(string name = "accu_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass

`endif
