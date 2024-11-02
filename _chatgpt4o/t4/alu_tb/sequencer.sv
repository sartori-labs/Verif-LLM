// Sequencer class
class alu_sequencer extends uvm_sequencer #(alu_transaction);
  `uvm_component_utils(alu_sequencer)

  function new(string name = "alu_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass