// Transaction class
class adder_16bit_trans extends uvm_sequence_item;
  `uvm_object_utils(adder_16bit_trans)

  rand bit [15:0] a;
  rand bit [15:0] b;
  rand bit Cin;
  bit [15:0] y;
  bit Co;

  constraint valid_input {a != 0; b != 0;}

  function new(string name = "adder_16bit_trans");
    super.new(name);
  endfunction

endclass