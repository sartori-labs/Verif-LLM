class fsm_sequencer extends uvm_sequencer#(fsm_trans);
  `uvm_component_utils(fsm_sequencer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass