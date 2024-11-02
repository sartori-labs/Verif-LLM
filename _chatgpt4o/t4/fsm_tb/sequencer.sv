// Sequencer class
class fsm_sequencer extends uvm_sequencer #(fsm_transaction);
  `uvm_component_utils(fsm_sequencer)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass