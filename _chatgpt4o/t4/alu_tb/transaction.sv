// Transaction class (UVM sequence item)
class alu_transaction extends uvm_sequence_item;
  // Input ports
  rand bit [31:0] a;
  rand bit [31:0] b;
  rand bit [5:0] aluc;
  // Output ports (observed through sampling)
  bit [31:0] r;
  bit zero;
  bit carry;
  bit negative;
  bit overflow;
  bit flag;

  `uvm_object_utils_begin(alu_transaction)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(aluc, UVM_ALL_ON)
    `uvm_field_int(r, UVM_NOPACK)
    `uvm_field_int(zero, UVM_NOPACK)
    `uvm_field_int(carry, UVM_NOPACK)
    `uvm_field_int(negative, UVM_NOPACK)
    `uvm_field_int(overflow, UVM_NOPACK)
    `uvm_field_int(flag, UVM_NOPACK)
  `uvm_object_utils_end

  function new(string name = "alu_transaction");
    super.new(name);
  endfunction
endclass