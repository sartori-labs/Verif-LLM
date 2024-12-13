// Transaction class
class accu_trans extends uvm_sequence_item;
    rand bit [7:0] data_in;
    rand bit valid_in;
    bit [9:0] data_out;
    bit valid_out;

    `uvm_object_utils_begin(accu_trans)
        `uvm_field_int(data_in, UVM_ALL_ON)
        `uvm_field_int(valid_in, UVM_ALL_ON)
        `uvm_field_int(data_out, UVM_ALL_ON)
        `uvm_field_int(valid_out, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "accu_trans");
        super.new(name);
    endfunction
endclass