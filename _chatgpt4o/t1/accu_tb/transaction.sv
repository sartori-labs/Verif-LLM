// Transaction Class (Sequence Item)
class accu_transaction extends uvm_sequence_item;
    `uvm_object_utils(accu_transaction)
    
    rand bit [7:0] data_in;
    bit valid_in;

    // Constructor
    function new(string name = "accu_transaction");
        super.new(name);
    endfunction

    // Field macros for UVM automation
    // `uvm_field_int(data_in, UVM_ALL_ON)
    // `uvm_field_int(valid_in, UVM_ALL_ON)
endclass