// UVM transaction class for 16-bit adder
class adder_16bit_trans extends uvm_sequence_item;
  rand bit [15:0] a;
  rand bit [15:0] b;
  rand bit Cin;
  bit [15:0] y;
  bit Co;

  `uvm_object_utils(adder_16bit_trans)

  function new(string name = "adder_16bit_trans");
    super.new(name);
  endfunction
endclass