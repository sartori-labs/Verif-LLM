// Transaction class
class adder_16bit_trans extends uvm_sequence_item;
  rand bit [15:0] a;
  rand bit [15:0] b;
  rand bit Cin;
  bit [15:0] y;
  bit Co;

  `uvm_object_utils_begin(adder_16bit_trans)
  `uvm_field_int(a, UVM_ALL_ON)
  `uvm_field_int(b, UVM_ALL_ON)
  `uvm_field_int(Cin, UVM_ALL_ON)
  `uvm_field_int(y, UVM_ALL_ON)
  `uvm_field_int(Co, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "adder_16bit_trans");
    super.new(name);
  endfunction
endclass
