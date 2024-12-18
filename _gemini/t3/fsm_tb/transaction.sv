// fsm_transaction.sv
class fsm_transaction extends uvm_sequence_item;
  rand bit IN;
  bit MATCH;

  `uvm_object_utils(fsm_transaction)

  function new(string name = "fsm_transaction");
    super.new(name);
  endfunction
endclass
