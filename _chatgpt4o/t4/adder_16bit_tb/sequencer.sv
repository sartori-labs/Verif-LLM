// adder_16bit_sequencer.sv
class adder_16bit_sequencer extends uvm_sequencer #(adder_16bit_txn);
  `uvm_component_utils(adder_16bit_sequencer)

  function new(string name = "adder_16bit_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass