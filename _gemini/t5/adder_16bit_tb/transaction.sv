// adder_16bit_transaction.sv
class adder_16bit_transaction extends uvm_sequence_item;
  `uvm_object_utils(adder_16bit_transaction)

  rand logic [15:0] a;
  rand logic [15:0] b;
  rand logic Cin;
  logic [15:0] y;
  logic Co;

  function new(string name = "adder_16bit_transaction");
    super.new(name);
  endfunction
endclass