// transaction.sv
class transaction extends uvm_sequence_item;
  rand bit IN;
  bit MATCH;

  `uvm_object_utils(transaction)

  function new(string name = "transaction");
    super.new(name);
  endfunction
endclass