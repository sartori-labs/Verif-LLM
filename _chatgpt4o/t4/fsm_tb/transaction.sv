// Transaction class
class fsm_transaction extends uvm_sequence_item;
  `uvm_object_utils(fsm_transaction)
  
  rand bit IN;      // Input to the FSM
  bit MATCH;        // Output from the FSM

  // Constructor
  function new(string name = "fsm_transaction");
    super.new(name);
  endfunction
endclass