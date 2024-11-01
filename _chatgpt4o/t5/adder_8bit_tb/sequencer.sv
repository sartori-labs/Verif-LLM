// Sequencer class for 8-bit adder
class adder_8bit_sequencer extends uvm_sequencer #(adder_8bit_transaction);
  `uvm_component_utils(adder_8bit_sequencer)

  function new(string name = "adder_8bit_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass
