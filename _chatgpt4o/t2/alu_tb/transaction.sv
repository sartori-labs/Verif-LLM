class alu_transaction extends uvm_sequence_item;
    rand bit [31:0] a;
    rand bit [31:0] b;
    rand bit [5:0]  aluc;
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
        `uvm_field_int(r, UVM_DEFAULT) // Replace UVM_NO_CMP with UVM_DEFAULT
        `uvm_field_int(zero, UVM_DEFAULT) // Replace UVM_NO_CMP with UVM_DEFAULT
        `uvm_field_int(carry, UVM_DEFAULT) // Replace UVM_NO_CMP with UVM_DEFAULT
        `uvm_field_int(negative, UVM_DEFAULT) // Replace UVM_NO_CMP with UVM_DEFAULT
        `uvm_field_int(overflow, UVM_DEFAULT) // Replace UVM_NO_CMP with UVM_DEFAULT
        `uvm_field_int(flag, UVM_DEFAULT) // Replace UVM_NO_CMP with UVM_DEFAULT
    `uvm_object_utils_end

    function new(string name = "alu_transaction");
        super.new(name);
    endfunction
endclass
