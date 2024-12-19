// Sequencer class
class fsm_sequencer extends uvm_sequencer#(fsm_trans);
  `uvm_component_utils(fsm_sequencer)

  function new(string name = "fsm_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass