// accu_transaction.sv
class accu_transaction extends uvm_sequence_item;
  `uvm_object_utils(accu_transaction)

  rand logic [7:0] data_in;
  rand logic valid_in;
  logic valid_out;
  logic [9:0] data_out;

  function new(string name = "accu_transaction");
    super.new(name);
  endfunction
endclass
