class alu_transaction extends uvm_sequence_item;
  rand logic [31:0] a;
  rand logic [31:0] b;
  rand logic [5:0] aluc;
  logic [31:0] r;
  logic zero;
  logic carry;
  logic negative;
  logic overflow;
  logic flag;

  `uvm_object_utils_begin(alu_transaction)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(aluc, UVM_ALL_ON)
    `uvm_field_int(r, UVM_ALL_ON)
    `uvm_field_int(zero, UVM_ALL_ON)
    `uvm_field_int(carry, UVM_ALL_ON)
    `uvm_field_int(negative, UVM_ALL_ON)
    `uvm_field_int(overflow, UVM_ALL_ON)
    `uvm_field_int(flag, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "alu_transaction");
    super.new(name);
  endfunction
endclass
