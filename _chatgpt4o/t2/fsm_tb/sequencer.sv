class sequencer_fsm extends uvm_sequencer #(trans_fsm);
  `uvm_component_utils(sequencer_fsm)

  function new(string name = "sequencer_fsm", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass
