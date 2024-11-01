// Transaction class
class accu_transaction extends uvm_sequence_item;
    rand bit [7:0] data_in;
    rand bit valid_in;
    bit [9:0] data_out;
    bit valid_out;

    `uvm_object_utils(accu_transaction)

    function new(string name = "accu_transaction");
        super.new(name);
    endfunction
endclass
