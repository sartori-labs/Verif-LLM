// Transaction class
class adder_8bit_trans extends uvm_sequence_item;
  `uvm_object_utils(adder_8bit_trans)

  rand bit [7:0] a;
  rand bit [7:0] b;
  rand bit cin;
  bit [7:0] sum;
  bit cout;

  function new(string name = "adder_8bit_trans");
    super.new(name);
  endfunction

  constraint c_a { a inside {[0:255]}; }
  constraint c_b { b inside {[0:255]}; }
  constraint c_cin { cin inside {[0:1]}; }
endclass