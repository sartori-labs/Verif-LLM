// adder_8bit_transaction.sv
class adder_8bit_transaction extends uvm_sequence_item;
  `uvm_object_utils(adder_8bit_transaction)

  rand logic [7:0] a;
  rand logic [7:0] b;
  rand logic cin;
  logic [7:0] sum;
  logic cout;

  function new(string name = "adder_8bit_transaction");
    super.new(name);
  endfunction
endclass